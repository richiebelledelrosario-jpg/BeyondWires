/* ==========================================================
   BeyondWires shared front-end helper  |  JS/api.js
   Every page loads it BEFORE its own script:
     <script src="../JS/api.js"></script>
   Talks to the PHP backend: ../api/index.php?r=/route
   The server is the source of truth: logins, roles, limits, prices
   and schedules are all checked there, not only in the page.
   ========================================================== */
(function () {
    'use strict';

    const API_URL = '../api/index.php';
    const HOME = { customer: 'HomePage.html', admin: 'AdminHomePage.html', superadmin: 'SuperHomePage.html' };
    const LOGIN = { customer: 'LandingPage.html#login', admin: 'Super&AdminAccount.html', superadmin: 'Super&AdminAccount.html' };

    class ApiError extends Error {
        constructor(message, status) { super(message); this.status = status; }
    }
    let loginPage = null;   // set by guard(); a 401 later sends the user back here

    function buildUrl(path, query) {
        let url = API_URL + '?r=' + encodeURIComponent(path);
        if (query) Object.keys(query).forEach(k => {
            const v = query[k];
            if (v !== undefined && v !== null && v !== '') url += '&' + encodeURIComponent(k) + '=' + encodeURIComponent(v);
        });
        return url;
    }

    /**
     * api('/auth/login', { body: {...} })              -> POST JSON
     * api('/admin/inquiries', { query: { q: 'x' } })   -> GET
     * api('/customer/payments/5/proof', { form: fd })   -> POST multipart (file upload)
     * api('/admin/quotations/3', { method: 'PUT', body: {...} })
     */
    async function api(path, opt) {
        opt = opt || {};
        const method = opt.method || ((opt.body !== undefined || opt.form) ? 'POST' : 'GET');
        const headers = { 'X-Requested-With': 'fetch', 'Accept': 'application/json' };
        let body;
        if (opt.form) body = opt.form;
        else if (opt.body !== undefined) { headers['Content-Type'] = 'application/json'; body = JSON.stringify(opt.body); }
        let res;
        try {
            res = await fetch(buildUrl(path, opt.query), { method, headers, body, credentials: 'same-origin' });
        } catch (e) {
            throw new ApiError('Cannot reach the server. Make sure Apache and MySQL are running in XAMPP.', 0);
        }
        let json = null;
        try { json = await res.json(); } catch (e) { /* not JSON */ }
        if (!json) throw new ApiError('Unexpected server response (' + res.status + '). Open api/index.php?r=/catalog in your browser to check PHP and the database.', res.status);
        if (!json.ok) {
            if (res.status === 401 && loginPage && !opt.noRedirect) location.replace(loginPage);
            throw new ApiError(json.error || 'Request failed.', res.status);
        }
        return json.data;
    }
    /** URL for GET downloads and images (proofs, photos). The session cookie is sent automatically. */
    const fileUrl = (path, query) => buildUrl(path, query);

    /**
     * Protects a dashboard page. Resolves with the logged-in user, or redirects:
     *  - not logged in         -> that role's login page
     *  - logged in, wrong role -> the user's own dashboard
     * The page stays hidden until the server has answered, so nothing flashes.
     */
    async function guard(role) {
        loginPage = LOGIN[role];
        document.documentElement.style.visibility = 'hidden';
        try {
            const me = await api('/auth/me', { noRedirect: true });
            if (me.role !== role) { location.replace(HOME[me.role] || 'LandingPage.html'); return new Promise(() => {}); }
            document.documentElement.style.visibility = '';
            return me;
        } catch (e) {
            if (e.status === 401) { location.replace(loginPage); return new Promise(() => {}); }
            document.documentElement.style.visibility = '';
            document.body.innerHTML = '<div style="font:14px sans-serif;padding:40px;max-width:640px;margin:auto"><h2>Cannot load the dashboard</h2><p>' +
                esc(e.message) + '</p><p><a href="LandingPage.html">Back to home</a></p></div>';
            return new Promise(() => {});
        }
    }
    async function logout(to) {
        try { await api('/auth/logout', { body: {}, noRedirect: true }); } catch (e) { /* already logged out */ }
        try { sessionStorage.clear(); } catch (e) {  }
        location.replace(to || 'LandingPage.html');
    }

    /* ---------- notifications (same layout + behaviour on every dashboard) ----------
       Items come from the server. Clicking one (or Enter / Space) marks it read and calls
       open(link), where link is e.g. "quotation:12", "project:3", "inquiry:5", "schedule:7", "documents". */
    function Notifications(o) {
        const listEl = document.getElementById(o.list), dotEl = document.getElementById(o.dot), markEl = document.getElementById(o.markAll);
        const ICON = { quotation: 'fa-file-invoice', project: 'fa-folder-open', inquiry: 'fa-inbox', schedule: 'fa-calendar-days', documents: 'fa-file-lines', payment: 'fa-receipt' };
        let items = [];
        async function load() {
            try { const r = await api('/notifications', { noRedirect: true }); items = r.items || []; }
            catch (e) { if (e.status === 401 && loginPage) location.replace(loginPage); return; }   // logged out after 30 idle minutes: leave the page
            listEl.innerHTML = items.length ? items.map((n, i) => {
                const kind = String(n.link || '').split(':')[0];
                const icon = /payment|proof|receipt/i.test(n.title) ? 'fa-receipt' : (ICON[kind] || 'fa-bell');
                return '<div class="notif-item' + (+n.is_read ? '' : ' unread') + '" data-n="' + i + '" role="button" tabindex="0"><strong><i class="fa-solid ' + icon + '"></i>' +
                    esc(n.message || n.title) + '</strong><span>' + esc(ago(n.timestamp)) + '</span></div>';
            }).join('') : '<div class="notif-empty">No notifications</div>';
            if (dotEl) dotEl.style.display = items.some(n => !+n.is_read) ? 'block' : 'none';
        }
        async function openIt(i) {
            const n = items[i]; if (!n) return;
            if (!+n.is_read) { n.is_read = 1; api('/notifications/' + n.notification_id + '/read', { body: {} }).catch(() => {}); }
            if (o.close) o.close();
            if (o.open) o.open(String(n.link || ''), n);
            load();
        }
        listEl.addEventListener('click', e => { const it = e.target.closest('[data-n]'); if (it) openIt(+it.dataset.n); });
        listEl.addEventListener('keydown', e => { const it = e.target.closest('[data-n]'); if (it && (e.key === 'Enter' || e.key === ' ')) { e.preventDefault(); openIt(+it.dataset.n); } });
        const markAll = async () => { try { await api('/notifications/read', { body: {} }); await load(); if (o.toast) o.toast('All notifications marked as read'); } catch (e) { if (o.toast) o.toast(e.message); } };
        if (markEl) { markEl.onclick = markAll; markEl.addEventListener('keydown', e => { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); markAll(); } }); }
        load();
        setInterval(load, 60000);   // new notifications show up without a reload
        return { load };
    }

    function esc(s) {
        return String(s == null ? '' : s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
    }
    /** Accepts 'YYYY-MM-DD' or MySQL 'YYYY-MM-DD HH:MM:SS'. */
    function toDate(s) {
        if (!s) return null;
        if (s instanceof Date) return s;
        const str = String(s);
        return new Date(str.length <= 10 ? str + 'T00:00:00' : str.replace(' ', 'T'));
    }
    function ago(s) {
        const d = toDate(s); if (!d) return '';
        const sec = Math.floor((Date.now() - d.getTime()) / 1000);
        if (sec < 60) return 'just now';
        if (sec < 3600) return Math.floor(sec / 60) + ' mins ago';
        if (sec < 86400) return Math.floor(sec / 3600) + ' hours ago';
        const days = Math.floor(sec / 86400);
        return days < 30 ? days + ' days ago' : days < 365 ? Math.floor(days / 30) + ' months ago' : Math.floor(days / 365) + ' years ago';
    }
    const pad = n => String(n).padStart(2, '0');
    const isoDate = d => d.getFullYear() + '-' + pad(d.getMonth() + 1) + '-' + pad(d.getDate());
    const num = v => Number(v) || 0;
    /* Display numbers the pages use: INQ-2026-0005 style ids from the database ids */
    const inqNo = (id, date) => 'INQ-' + String(date || '').slice(0, 4) + '-' + String(id).padStart(3, '0');
    const prjNo = id => 'PRJ-' + String(id).padStart(3, '0');
    const toast = (msg) => { const t = document.createElement('div'); t.className = 'bw-toast'; t.textContent = msg; document.body.appendChild(t); setTimeout(() => t.remove(), 3200); };

    /* ---------- dialogs (used instead of the browser's alert / confirm / prompt) ----------
       BW.confirm({ title, message, ok, danger })            -> Promise<true|false>
       BW.prompt({ title, message, label, value, ok })       -> Promise<text|null>
       BW.reason({ title, message, reasons: [...], ok })     -> Promise<{ reason, comment }|null>  ("Others" is added)
       BW.alert({ title, message })                          -> Promise<void>
       Optional onOk(result): runs while the buttons are locked; if it throws, the error shows in the dialog and it stays open. */
    function dialog(o) {
        return new Promise(resolve => {
            const prev = document.activeElement, kind = o.kind || 'confirm';
            const icon = o.danger ? 'fa-triangle-exclamation' : kind === 'alert' ? 'fa-circle-info' : 'fa-circle-question';
            const ov = document.createElement('div');
            ov.className = 'bwm-overlay';
            let f = '';
            if (kind === 'prompt') f = '<label class="bwm-label" for="bwmText">' + esc(o.label || 'Details') + '</label><textarea class="bwm-in" id="bwmText" rows="3">' + esc(o.value || '') + '</textarea>';
            if (kind === 'reason') f = '<label class="bwm-label" for="bwmReason">Reason</label><select class="bwm-in" id="bwmReason"><option value="">Select a reason</option>' +
                o.reasons.concat('Others').map(r => '<option>' + esc(r) + '</option>').join('') + '</select>' +
                '<div id="bwmOtherWrap" hidden><label class="bwm-label" for="bwmOther">Please specify</label><input class="bwm-in" id="bwmOther" maxlength="100"></div>' +
                '<label class="bwm-label" for="bwmText">Comment' + (o.commentRequired ? '' : ' (optional)') + '</label><textarea class="bwm-in" id="bwmText" rows="3" maxlength="400"></textarea>';
            ov.innerHTML = '<div class="bwm-card" role="' + (o.danger ? 'alertdialog' : 'dialog') + '" aria-modal="true" aria-labelledby="bwmTitle" aria-describedby="bwmMsg">' +
                '<button type="button" class="bwm-x" data-bwm="cancel" aria-label="Close"><i class="fa-solid fa-xmark"></i></button>' +
                '<div class="bwm-head"><span class="bwm-ico' + (o.danger ? ' danger' : '') + '"><i class="fa-solid ' + icon + '"></i></span><h3 id="bwmTitle">' + esc(o.title || 'Please confirm') + '</h3></div>' +
                '<p class="bwm-msg" id="bwmMsg">' + esc(o.message || '') + '</p>' + f +
                '<small class="bwm-err" id="bwmErr" role="alert"></small>' +
                '<div class="bwm-actions">' + (kind === 'alert' ? '' : '<button type="button" class="bwm-btn sec" data-bwm="cancel">' + esc(o.cancel || 'Cancel') + '</button>') +
                '<button type="button" class="bwm-btn ' + (o.danger ? 'danger' : 'pri') + '" data-bwm="ok">' + esc(o.ok || (kind === 'alert' ? 'OK' : 'Confirm')) + '</button></div></div>';
            (document.querySelector('.content') || document.body).appendChild(ov);
            const card = ov.firstChild, q = s => ov.querySelector(s), err = q('#bwmErr');
            let busy = false;
            const done = v => { if (busy) return; ov.remove(); document.removeEventListener('keydown', key, true); if (prev && prev.focus) prev.focus(); resolve(v); };
            const value = () => {
                if (kind === 'confirm') return true;
                if (kind === 'alert') return undefined;
                const text = q('#bwmText').value.trim();
                if (kind === 'prompt') return text ? text : (err.textContent = 'Please fill this in.', null);
                let r = q('#bwmReason').value;
                if (!r) return (err.textContent = 'Please choose a reason.', null);
                if (r === 'Others') { r = q('#bwmOther').value.trim(); if (!r) return (err.textContent = 'Please specify the reason.', null); }
                if (o.commentRequired && !text) return (err.textContent = 'Please add a comment.', null);
                return { reason: r, comment: text };
            };
            async function ok() {
                err.textContent = '';
                const v = value(); if (v === null) return;
                if (!o.onOk) return done(v);
                busy = true; ov.querySelectorAll('button,input,select,textarea').forEach(b => b.disabled = true); q('[data-bwm="ok"]').classList.add('loading');
                try { await o.onOk(v); busy = false; done(v); }
                catch (e) { busy = false; err.textContent = e.message || 'Something went wrong.'; ov.querySelectorAll('button,input,select,textarea').forEach(b => b.disabled = false); q('[data-bwm="ok"]').classList.remove('loading'); }
            }
            function key(e) {
                if (e.key === 'Escape') { e.preventDefault(); e.stopPropagation(); if (kind !== 'alert' || !busy) done(kind === 'confirm' ? false : kind === 'alert' ? undefined : null); }
                else if (e.key === 'Tab') {   // keep the focus inside the dialog
                    const f = [...card.querySelectorAll('button,input,select,textarea')].filter(x => !x.disabled && x.offsetParent !== null);
                    if (!f.length) return;
                    if (e.shiftKey && document.activeElement === f[0]) { e.preventDefault(); f[f.length - 1].focus(); }
                    else if (!e.shiftKey && document.activeElement === f[f.length - 1]) { e.preventDefault(); f[0].focus(); }
                }
            }
            document.addEventListener('keydown', key, true);
            ov.addEventListener('click', e => {
                const b = e.target.closest('[data-bwm]');
                if (e.target === ov || (b && b.dataset.bwm === 'cancel')) return done(kind === 'confirm' ? false : kind === 'alert' ? undefined : null);
                if (b && b.dataset.bwm === 'ok') ok();
            });
            if (kind === 'reason') q('#bwmReason').addEventListener('change', e => { q('#bwmOtherWrap').hidden = e.target.value !== 'Others'; });
            card.addEventListener('input', () => { err.textContent = ''; });   // the message clears as soon as the field is fixed
            (q('#bwmReason') || q('#bwmText') || q('[data-bwm="ok"]')).focus();
        });
    }
    /* ---------- birthday (sign-up + customer Settings; the server checks the same rules) ----------
       Oldest year = this year - 122 (Guinness record: Jeanne Calment, 122 years). Youngest = 18 years old today. */
    const MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    function birthRange() { const y = new Date().getFullYear(); return { min: y - 122, max: y - 18 }; }
    function birthError(y, m, d) {
        if (!y || !m || !d) return 'Please select your complete birthday.';
        const dt = new Date(y, m - 1, d);
        if (dt.getFullYear() !== +y || dt.getMonth() !== m - 1 || dt.getDate() !== +d) return 'That date does not exist.';
        const now = new Date(), adult = new Date(now.getFullYear() - 18, now.getMonth(), now.getDate());
        if (dt > now) return 'Your birthday cannot be in the future.';
        if (dt > adult) return 'You must be at least 18 years old to create an account.';
        if (y < birthRange().min) return 'Please check the year.';
        return '';
    }
    /** Fills three selects (month, day, year). The day list follows the month and year (leap years included). */
    function birthPicker(mSel, dSel, ySel) {
        const r = birthRange();
        mSel.innerHTML = '<option value="">Month</option>' + MONTHS.map((n, i) => '<option value="' + (i + 1) + '">' + n + '</option>').join('');
        let yo = '<option value="">Year</option>'; for (let y = r.max; y >= r.min; y--) yo += '<option>' + y + '</option>';
        ySel.innerHTML = yo;
        function days() {
            const m = +mSel.value, y = +ySel.value, keep = dSel.value;
            const n = m ? new Date(y || 2000, m, 0).getDate() : 31;   // no year yet: allow Feb 29
            let o = '<option value="">Day</option>'; for (let d = 1; d <= n; d++) o += '<option>' + d + '</option>';
            dSel.innerHTML = o; dSel.value = +keep <= n ? keep : '';
        }
        days();
        mSel.addEventListener('change', days); ySel.addEventListener('change', days);
        return {
            value() { const y = +ySel.value, m = +mSel.value, d = +dSel.value; return y && m && d ? y + '-' + pad(m) + '-' + pad(d) : ''; },
            error() { return birthError(+ySel.value, +mSel.value, +dSel.value); },
            set(v) { const p = String(v || '').split('-'); ySel.value = p[0] ? String(+p[0]) : ''; mSel.value = p[1] ? String(+p[1]) : ''; days(); dSel.value = p[2] ? String(+p[2]) : ''; },
            touched() { return !!(mSel.value || dSel.value || ySel.value); }
        };
    }
    const GENDERS = ['Male', 'Female', 'Prefer not to say'];

    /* ---------- live validation + red asterisks (every page that loads this file) ----------
       Any field with "required" or a data-check is checked as soon as it is left (a dropdown: as soon as it
       is changed), then again on every change, so the message clears the moment it is fixed. Fields the
       person has not touched stay quiet. A red * is added to the label of every required field.
       The page's own Save / Submit checks and the server's checks still run as before.
       data-check: gmail | email | name | phone | password | match:<id> | money | int | past | code6
       Native min / max / minlength / step also count. Forms marked data-live="own" do their own live checks. */
    const PH_MOBILE = v => /^(\+?63|0)9\d{9}$/.test(String(v).replace(/[\s\-()]/g, ''));
    function fieldMessage(el) {
        if (el.disabled || el.readOnly || el.type === 'hidden' || el.type === 'file' || el.type === 'checkbox' || el.offsetParent === null) return '';
        const v = String(el.value == null ? '' : el.value).trim(), chk = el.dataset.check || '';
        if (!v) return el.required ? (el.tagName === 'SELECT' ? 'Please choose an option.' : 'This field is required.') : '';
        if (el.type === 'number' && el.validity && el.validity.badInput) return 'Enter a valid number.';
        if (chk === 'gmail' && !/^(?!\.)(?!.*\.\.)[a-z0-9.]{6,30}(?<!\.)@gmail\.com$/i.test(v)) return 'Enter a valid Gmail address. Use 6–30 letters, numbers, or periods before @gmail.com.';
        if ((chk === 'email' || el.type === 'email') && !/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(v)) return 'Enter a valid email address.';
        if (chk === 'name' && !/^[\p{L}]+(?:[\s.'-]+[\p{L}]+)*\.?$/u.test(v)) return 'Use letters and spaces only.';
        if (chk === 'phone' && !PH_MOBILE(v)) return 'Enter a valid PH mobile number, e.g. +63 917 824 6310.';
        if (chk === 'password' && (v.length < 8 || !/\d/.test(v))) return 'Use at least 8 characters and include a number.';
        if (chk === 'code6' && !/^\d{6}$/.test(v)) return 'Enter the 6-digit code.';
        if (chk.startsWith('match:')) { const o = document.getElementById(chk.slice(6)); if (o && o.value !== el.value) return 'Passwords do not match.'; }
        if (el.type === 'number' || chk === 'money' || chk === 'int') {
            const n = Number(v);
            if (!isFinite(n)) return 'Enter a valid number.';
            if (chk === 'int' && !Number.isInteger(n)) return 'Enter a whole number.';
            if (chk === 'money' && n <= 0) return 'Enter an amount greater than 0.';
            if (chk === 'money' && /\.\d{3,}$/.test(v)) return 'Use at most 2 decimal places.';
            const lo = el.min !== '' ? Number(el.min) : null, hi = el.max !== '' ? Number(el.max) : null;
            const fmt = x => x.toLocaleString('en-US');
            if (lo != null && hi != null && (n < lo || n > hi)) return 'Enter a value from ' + fmt(lo) + ' to ' + fmt(hi) + '.';
            if (lo != null && n < lo) return 'Enter ' + fmt(lo) + ' or more.';
            if (hi != null && n > hi) return 'Enter ' + fmt(hi) + ' or less.';
        }
        if (el.type === 'date') {
            if (!/^\d{4}-\d{2}-\d{2}$/.test(v)) return 'Choose a valid date.';
            if (chk === 'past' && v > isoDate(new Date())) return 'The date cannot be in the future.';
            if (el.min && v < el.min) return 'Choose a date on or after ' + el.min + '.';
            if (el.max && v > el.max) return 'Choose a date on or before ' + el.max + '.';
        }
        const minL = el.minLength > 0 ? el.minLength : +(el.dataset.minLen || 0);
        if (minL && v.length < minL) return 'Enter at least ' + minL + ' characters.';
        return '';
    }
    const ERR_SEL = '.field-error, .field-err, .st-err, .rv-err, .form-error, .bw-live-err, .mc-field-err';
    function errorElement(el, create) {
        if (el.id) for (const s of ['Error', 'Err', '-err']) { const e = document.getElementById(el.id + s); if (e) return e; }
        if (el.id) { const e = document.querySelector('.bw-live-err[data-for="' + CSS.escape(el.id) + '"]'); if (e) return e; }   // a message made earlier for this field (fields without a wrapper, e.g. in dialogs)
        const wrap = el.closest('.field, .st-field, .panel-field, .si-field, .inq-field, .mc-form > div, .bwm-card');
        const found = wrap && !wrap.classList.contains('bwm-card') && Array.from(wrap.querySelectorAll(ERR_SEL)).find(x => !x.dataset.for || x.dataset.for === el.id);
        if (found || !create) return found || null;
        const e = document.createElement('small'); e.className = 'bw-live-err'; e.setAttribute('role', 'alert'); if (el.id) e.dataset.for = el.id;
        (el.closest('.st-input, .password-wrap, .pw, .bw-in-wrap') || el).insertAdjacentElement('afterend', e);
        return e;
    }
    function checkField(el) {
        const msg = fieldMessage(el), box = errorElement(el, !!msg);
        el.classList.toggle('invalid', !!msg); el.setAttribute('aria-invalid', msg ? 'true' : 'false');
        const st = el.closest('.st-input'); if (st) st.classList.toggle('invalid', !!msg);
        const fw = el.closest('.field'); if (fw && fw.querySelector('.form-error')) fw.classList.toggle('invalid', !!msg);
        if (box) { box.textContent = msg; if (box.hidden && msg) box.hidden = false; }
        return !msg;
    }
    const watched = el => el && /^(INPUT|SELECT|TEXTAREA)$/.test(el.tagName) && (el.required || el.dataset.check || el.type === 'number' || el.type === 'date' || el.minLength > 0) && !el.closest('[data-live="own"]');
    document.addEventListener('focusout', e => { const el = e.target; if (!watched(el)) return; if (el.value !== '' || el.dataset.live) { el.dataset.live = '1'; checkField(el); } }, true);
    ['input', 'change'].forEach(ev => document.addEventListener(ev, e => {
        const el = e.target; if (!watched(el)) return;
        if (el.tagName === 'SELECT' || el.dataset.live) { el.dataset.live = '1'; checkField(el); }
        // a password change re-checks its "confirm" field
        document.querySelectorAll('[data-check="match:' + el.id + '"][data-live]').forEach(checkField);
    }, true));
    /** Checks every watched field inside root and shows all messages. Returns true when all are fine. */
    function checkAll(root) {
        let ok = true, first = null;
        (root || document).querySelectorAll('input, select, textarea').forEach(el => { if (!watched(el)) return; el.dataset.live = '1'; if (!checkField(el) && ok) { ok = false; first = el; } });
        if (first) first.focus();
        return ok;
    }
    // trying to submit a form shows every message at once
    document.addEventListener('submit', e => { if (!e.target.closest('[data-live="own"]')) checkAll(e.target); }, true);
    /* the red * after the label of each required field (also for windows opened later) */
    function markRequired(root) {
        (root || document).querySelectorAll('input[required], select[required], textarea[required]').forEach(el => {
            const wrapLabel = el.closest('label');
            if (wrapLabel && wrapLabel.querySelector('.bw-req')) return;
            let label = el.id ? document.querySelector('label[for="' + el.id + '"]') : null;
            if (!label) { const g = el.closest('[aria-labelledby]'); if (g && g.getAttribute('role') === 'group') label = document.getElementById(g.getAttribute('aria-labelledby')); }
            if (!label) { const wrap = el.closest('label'); label = wrap && (wrap.querySelector(':scope > span:not(.password-wrap):not(.st-input):not(.bw-req)') || wrap); }
            if (!label) { const f = el.closest('.field, .st-field, .mc-form > div, .si-field'); label = f && f.querySelector('label'); }
            if (!label || label.querySelector('.bw-req')) return;
            const star = document.createElement('span'); star.className = 'bw-req'; star.setAttribute('aria-hidden', 'true'); star.textContent = '*';
            const firstCtl = label.querySelector('input, select, textarea, .password-wrap, .st-input');
            if (firstCtl && label.contains(firstCtl)) firstCtl.insertAdjacentElement('beforebegin', star); else label.appendChild(star);
            label.title = label.title || 'Required';
        });
    }
    let reqTimer = null;
    const observe = () => { markRequired(); new MutationObserver(() => { clearTimeout(reqTimer); reqTimer = setTimeout(markRequired, 60); }).observe(document.body, { childList: true, subtree: true }); };
    if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', observe); else observe();

    const confirmBox = o => dialog(Object.assign({}, o, { kind: 'confirm' }));
    const promptBox = o => dialog(Object.assign({}, o, { kind: 'prompt' }));
    const reasonBox = o => dialog(Object.assign({}, o, { kind: 'reason' }));
    const alertBox = o => dialog(Object.assign({}, o, { kind: 'alert' }));

    window.BW = { api, fileUrl, guard, logout, Notifications, ApiError, esc, toDate, ago, pad, isoDate, num, inqNo, prjNo, toast, HOME,
        confirm: confirmBox, prompt: promptBox, reason: reasonBox, alert: alertBox, birthPicker, birthError, GENDERS, checkAll, checkField };
})();
