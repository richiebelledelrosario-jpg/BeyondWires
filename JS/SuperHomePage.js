(function () {
'use strict';

/* ===================== Helpers ===================== */
const VAT = 0.12, r2 = n => Math.round(n * 100) / 100;
/* Quotation edit limits */
const PRICE_MIN = 1, PRICE_MAX = 1000000;      // unit price per line item (PHP)
const QTY_MIN = 1, QTY_MAX = 100;              // whole units per line item
const EXP_MAX = 1000000;                       // transport / other expenses (PHP)
const VALIDITY_MIN = 1, VALIDITY_MAX = 30, VALIDITY_DEFAULT = 30;   // days the quoted prices are honored
/* Same math as the server: items + extra expenses + the admin's labor lines, then 12% VAT (older quotations without VAT keep theirs) */
function quoteCalc(q) {
    const sub = r2((q.items || []).reduce((s, i) => s + i.qty * i.price, 0)), tr = r2(q.transport || 0), lab = r2(q.labor || 0);
    const vat = q.noVat ? 0 : r2((sub + tr + lab) * VAT);
    return { sub, tr, lab, vat, total: r2(sub + tr + lab + vat) };
}
const DB_KEY = 'bw_super_db_v3', SET_KEY = 'bw_super_settings_v1', SIDEBAR_KEY = 'bw_super_sidebar_v1';
const THEME_KEY = 'bw_theme', PROFILE_KEY = 'bw_super_profile', LANDING = 'LandingPage.html';
let ME = 0;            // user id of the signed-in super admin (set in init)
const api = window.BW.api;
const $ = id => document.getElementById(id);
const $$ = (sel, root) => Array.from((root || document).querySelectorAll(sel));
const esc = s => String(s == null ? '' : s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
const uid = () => 'i' + Date.now().toString(36) + Math.random().toString(36).slice(2, 6);
const peso = n => '₱' + Math.round(Number(n) || 0).toLocaleString('en-US');
const fmtDate = ts => new Date(ts).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
const initials = n => n.trim().split(/\s+/).map(w => w[0]).slice(0, 2).join('').toUpperCase();
const tone = n => ['blue', 'gray', 'green', 'orange'][[...n].reduce((a, c) => a + c.charCodeAt(0), 0) % 4];
const badge = n => `<span class="client-badge ${tone(n)}">${esc(initials(n))}</span>`;
const emptyRow = (cols, msg) => `<tr class="empty-row"><td colspan="${cols}">${msg}</td></tr>`;
const readJSON = (k, fb) => { try { const v = JSON.parse(localStorage.getItem(k)); return v == null ? fb : v; } catch (e) { return fb; } };
const writeJSON = (k, v) => { try { localStorage.setItem(k, JSON.stringify(v)); } catch (e) {} };

let profile = { name: '', email: '' };   // the signed-in account (from the server)
const firstName = () => profile.name.split(/\s+/)[0] || '';

const TABS = {
    dashboard: { crumb: 'OVERVIEW > DASHBOARD', title: 'System Dashboard', sub: '' },
    quotations: { crumb: 'MANAGEMENT > QUOTATIONS', title: 'Quotations', sub: 'Review, approve, or modify outgoing business proposals.' },
    projects: { crumb: 'MANAGEMENT > PROJECTS', title: 'Project Summary', sub: 'Track installations and security deployments by status and start date.' },
    financial: { crumb: 'PORTFOLIO > FINANCIAL SUMMARY', title: 'Financial Performance', sub: 'Real-time revenue, expense tracking, and profit analysis.' },
    activity: { crumb: 'SYSTEM > AUDIT TRAIL', title: 'Activity Log', sub: '' },
    settings: { crumb: 'SYSTEM SUPPORT > SETTINGS', title: 'System Settings', sub: 'Manage your dashboard appearance and account security.' }
};
const setDashSub = () => { TABS.dashboard.sub = `Welcome back, ${firstName()}. Here is a live summary of system status and recent operations.`; };
setDashSub();

const ui = {
    tab: 'dashboard', metric: 'revenue', range: 6, eventsShown: 5, perPage: 5, confirm: null, activeQuote: null,
    q: { page: 1, search: '', status: 'all' },
    p: { page: 1, search: '', status: 'all', from: '', to: '' },
    l: { page: 1, search: '', admin: 'all' }, a: { page: 1 }
};
let db;

/* ===================== Data ===================== */
const keyOf = d => d.getFullYear() + '-' + String(d.getMonth() + 1).padStart(2, '0');
const curKey = () => keyOf(new Date());
function lastMonths(n) {
    const out = [], now = new Date();
    for (let i = n - 1; i >= 0; i--) {
        const d = new Date(now.getFullYear(), now.getMonth() - i, 1);
        out.push({ key: keyOf(d), label: d.toLocaleString('en-US', { month: 'short' }), full: d.toLocaleString('en-US', { month: 'long', year: 'numeric' }) });
    }
    return out;
}

/* ===================== Finance ledger =====================
   ledger[YYYY-MM] = revenue + expenses per category, loaded from the server (api/owner.php: /owner/ledger). */
/* ===================== Data from the server =====================
   Quotations, projects, revenue/expenses, activity and accounts are loaded from the
   API and mapped to the shapes this page draws. Every action goes to the server. */
const EVENT_TEXT = {
    LOGIN: 'Signed in', LOGOUT: 'Signed out', QUOTATION_CREATED: 'Created quotation', QUOTATION_SUBMITTED: 'Sent quotation to superadmin', QUOTATION_EDITED: 'Edited quotation',
    QUOTATION_APPROVED_OWNER: 'Approved quotation', QUOTATION_REJECTED_OWNER: 'Returned quotation', QUOTATION_EDITED_OWNER: 'Edited quotation', QUOTATION_APPROVED: 'Customer approved quotation',
    QUOTATION_DECLINED: 'Customer declined quotation', QUOTATION_DECLINED_ADMIN: 'Marked quotation as declined', QUOTATION_DELETED: 'Deleted draft quotation',
    INQUIRY_ACCEPTED: 'Accepted inquiry', INQUIRY_REJECTED: 'Rejected inquiry', INQUIRY_SUBMITTED: 'Customer submitted inquiry', SITE_VISIT_CONFIRMED: 'Confirmed site visit', SITE_VISIT_DONE: 'Completed site visit',
    SITE_VISIT_SCHEDULED: 'Scheduled site visit', PAYMENT_CONFIRMED: 'Confirmed payment', PAYMENT_REJECTED: 'Requested payment re-upload', PAYMENT_PROOF_UPLOADED: 'Customer uploaded payment proof',
    INSTALL_SCHEDULED: 'Scheduled installation', INSTALL_STARTED: 'Started installation', INSTALLATION_COMPLETE: 'Completed installation', RECEIPT_SENT: 'Sent receipt', CERTIFICATE_SENT: 'Sent installation certificate',
    PRODUCT_ADDED: 'Added catalog item', PRODUCT_EDITED: 'Edited catalog item', PRODUCT_PRICE: 'Changed price', PRODUCT_ARCHIVED: 'Archived catalog item', PRODUCT_RESTORED: 'Restored catalog item', PRODUCT_DELETED: 'Deleted catalog item',
    AVAILABILITY_CHANGED: 'Changed available slots', AVAILABILITY_BULK: 'Published available slots', SCHEDULE_CONFIRMED: 'Confirmed schedule', SCHEDULE_MOVED: 'Moved schedule', SCHEDULE_CHANGED_CUSTOMER: 'Customer moved schedule',
    USER_CREATED: 'Created account', USER_DELETED: 'Deleted account', USER_STATUS: 'Changed account status', PROFILE_UPDATE: 'Updated own profile', PASSWORD_CHANGE: 'Changed own password',
    EXPENSE_ADDED: 'Recorded expense', PROJECT_TERMS: 'Changed payment terms', CONTACT_UPDATE: 'Updated primary contact'
};
const ms = v => v ? new Date(String(v).replace(' ', 'T')).getTime() : Date.now();
const QSTATUS = q => q.status === 'Pending Superadmin' ? 'pending' : q.status === 'Draft' ? 'rejected' : 'approved';
async function load() {
    const [quotes, projects, ledger, logs, users] = await Promise.all([
        api('/owner/quotations', { query: { status: 'all' } }), api('/admin/projects'), api('/owner/ledger'),
        api('/owner/activity', { query: { source: 'staff' } }), api('/owner/users', { query: { role: 'all' } })]);
    const staff = users.filter(u => u.role !== 'customer').sort((a, b) => a.user_id - b.user_id);
    let n = 0;
    const accounts = staff.map(u => ({ id: +u.user_id, name: (u.first_name + ' ' + u.last_name).trim(), email: u.email,
        role: u.role === 'superadmin' ? 'Super Admin' : 'Administrator ' + (++n), status: u.status, lastActivity: ms(u.last_activity || u.created_at) }));
    const roleOf = id => (accounts.find(a => a.id === +id) || {}).role || 'Customer';
    const revMap = {};
    ledger.revenue.forEach(r => { revMap[r.m] = +r.v; });
    const months = lastMonths(24), led = {};
    months.forEach(m => { led[m.key] = { rev: revMap[m.key] || 0 }; });
    const hProj = {}, hQuote = {};
    ledger.projects.forEach(r => { hProj[r.m] = +r.v; }); ledger.quotes.forEach(r => { hQuote[r.m] = +r.v; });
    db = {
        quotes: quotes.filter(q => q.status !== 'Draft' || q.superadmin_comment).map(q => ({
            id: q.quotation_no, dbId: +q.quotation_id, client: q.customer, scope: q.project_title || 'Quotation ' + q.quotation_no, status: QSTATUS(q), serverStatus: q.status,
            date: ms(q.date_created), amount: +q.total_amount, notes: q.status === 'Draft' ? q.superadmin_comment || '' : '', sentAt: q.status !== 'Pending Superadmin' && q.status !== 'Draft' ? ms(q.sent_at || q.date_created) : null,
            validity: q.expiry_date ? Math.max(1, Math.min(30, Math.round((ms(q.expiry_date) - ms(String(q.date_created).slice(0, 10))) / 864e5))) : VALIDITY_DEFAULT, items: null })),
        projects: projects.map(p => ({ id: 'p' + p.project_id, dbId: +p.project_id, code: window.BW.prjNo(p.project_id), name: p.project_name || 'Project', client: p.customer,
            status: p.status === 'Done' ? 'completed' : p.status === 'Failed' ? 'hold' : 'active', start: ms(p.start_date || p.created_at) })),
        events: logs.filter(e => e.role !== 'customer').map(e => ({ id: +e.log_id, desc: e.action_type === 'LOGIN' ? (e.details || 'Signed in') : (EVENT_TEXT[e.action_type] || String(e.action_type).replace(/_/g, ' ').toLowerCase()) + (e.details ? ' ' + e.details : ''),
            name: e.user_name, user: roleOf(e.user_id), time: ms(e.timestamp), status: 'completed' })),
        ledger: led, sales: [], hProj, hQuote, accounts, receivables: ledger.receivables
    };
}
/* quotation lines are loaded when a quotation is opened */
async function loadQuote(x) {
    const d = await api('/admin/quotations/' + x.dbId);
    x.items = d.items.map(i => ({ product_id: +i.product_id, name: i.description, qty: +i.quantity, price: +i.unit_price, desc: i.product_description || i.category || '' }));
    x.charges = d.charges; x.transport = +d.other_charges_total; x.labor = +d.labor_total; x.noVat = +d.vat_amount === 0 && +d.total_amount > 0;
    x.laborLines = d.labor; x.address = d.site_address || d.installation_address; x.duration = d.duration; x.payTerms = d.payment_terms; x.incharge = d.project_incharge;
    x.scopeText = d.scope_of_work; x.quoteNotes = d.notes || ''; x.amount = +d.total_amount;
    return x;
}
function loadSettings() {
    const s = readJSON(SET_KEY, null);
    if (s) { ui.range = s.range || 6; ui.eventsShown = s.events || 5; ui.perPage = s.perPage || 5; }
}

const me = () => db.accounts.find(a => a.id === ME) || { name: profile.name, role: 'Super Admin' };
const activeProjects = () => db.projects.filter(p => p.status === 'active').length;
const pendingQuotes = () => db.quotes.filter(q => q.status === 'pending').length;
const salesIn = key => db.sales.filter(s => keyOf(new Date(s.ts)) === key);
const monthRevenue = key => r2(((db.ledger[key] || {}).rev || 0) + salesIn(key).reduce((a, s) => a + s.amount, 0));
const curRevenue = () => monthRevenue(curKey());
function metricValue(metric, key) {
    if (key === curKey()) return metric === 'revenue' ? curRevenue() : metric === 'projects' ? activeProjects() : pendingQuotes();
    if (metric === 'revenue') return monthRevenue(key);
    return ((metric === 'projects' ? db.hProj : db.hQuote)[key]) || 0;
}


function toast(msg, type) {
    type = type || 'success';
    const el = document.createElement('div');
    el.className = 'toast ' + type;
    el.innerHTML = `<i class="fa-solid ${type === 'error' ? 'fa-circle-exclamation' : 'fa-circle-check'}"></i> ${esc(msg)}`;
    $('toast-stack').appendChild(el);
    setTimeout(() => el.remove(), 3000);
}
/* reload everything from the server (the server already wrote the activity log entry) */
async function commit() {
    try { await load(); } catch (e) { toast(e.message, 'error'); }
    renderAll();
}
/* run a server action; shows the server's message if it refuses */
async function run(fn, okMsg) {
    try { await fn(); } catch (e) { if (e.status === 403) { toast('This browser is no longer signed in as the Super Admin (another account signed in on another tab). Please sign in again.', 'error'); setTimeout(() => window.BW.guard('superadmin'), 1800); return false; } toast(e.message, 'error'); return false; }
    await commit(); if (okMsg) toast(okMsg); return true;
}
function fmtTime(ts) {
    const d = new Date(ts), t = new Date(), y = new Date(); y.setDate(t.getDate() - 1);
    const day = d.toDateString() === t.toDateString() ? 'Today' : d.toDateString() === y.toDateString() ? 'Yesterday' : d.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
    return { main: `${day}, ${d.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' })}`, sub: fmtDate(ts) };
}
function ago(ts) {
    const s = Math.max(1, Math.floor((Date.now() - ts) / 1000));
    if (s < 60) return 'just now';
    if (s < 3600) return Math.floor(s / 60) + ' mins ago';
    if (s < 86400) return Math.floor(s / 3600) + ' hours ago';
    return Math.floor(s / 86400) + ' days ago';
}
function downloadCSV(name, rows) {
    const q = v => '"' + String(v).replace(/"/g, '""') + '"';
    const url = URL.createObjectURL(new Blob(['\ufeff' + rows.map(r => r.map(q).join(',')).join('\r\n')], { type: 'text/csv;charset=utf-8;' }));
    const a = document.createElement('a');
    a.href = url; a.download = name; document.body.appendChild(a); a.click(); a.remove(); URL.revokeObjectURL(url);
}

function pager(id, st, total, noun, rerender) {
    const per = ui.perPage, pages = Math.max(1, Math.ceil(total / per));
    if (st.page > pages) st.page = pages;
    const start = (st.page - 1) * per, end = Math.min(start + per, total);
    let nums = '';
    for (let p = 1; p <= pages; p++) nums += `<button class="page-num ${p === st.page ? 'active' : ''}" data-page="${p}">${p}</button>`;
    const el = $(id);
    el.innerHTML = `<span class="pagination-info">SHOWING ${total ? start + 1 : 0}-${end} OF ${total} ${noun}</span>
        <div class="pagination-controls"><button class="page-btn" data-page="${st.page - 1}" ${st.page === 1 ? 'disabled' : ''}>Prev</button>${nums}
        <button class="page-btn" data-page="${st.page + 1}" ${st.page === pages ? 'disabled' : ''}>Next</button></div>`;
    el.onclick = e => { const b = e.target.closest('[data-page]'); if (b && !b.disabled) { st.page = parseInt(b.dataset.page, 10); rerender(); } };
}
const pageSlice = (list, st) => list.slice((st.page - 1) * ui.perPage, st.page * ui.perPage);

/* ===================== Dashboard ===================== */
function renderKPIs() {
    $('kpi-projects-val').textContent = activeProjects();
    const k = curKey(), added = db.projects.filter(p => keyOf(new Date(p.start)) === k).length;
    $('kpi-projects-sub').innerHTML = added ? `<i class="fa-solid fa-arrow-up"></i> +${added} this month` : 'No new projects this month';
    $('kpi-projects-sub').className = 'kpi-sub ' + (added ? 'up' : 'muted');
    const pq = pendingQuotes();
    $('kpi-quotes-val').textContent = pq;
    $('kpi-quotes-sub').innerHTML = pq ? '<i class="fa-solid fa-clock"></i> Requires review' : '<i class="fa-solid fa-circle-check"></i> All reviewed';
    $('kpi-quotes-sub').className = 'kpi-sub ' + (pq ? 'warn' : 'up');
    const cur = curRevenue(), prev = monthRevenue(lastMonths(2)[0].key), sub = $('kpi-revenue-sub');
    $('kpi-revenue-val').textContent = peso(cur);
    if (!prev) { sub.textContent = 'No previous month data'; sub.className = 'kpi-sub muted'; }
    else {
        const pct = (cur - prev) / prev * 100;
        sub.innerHTML = `<i class="fa-solid fa-arrow-${pct >= 0 ? 'up' : 'down'}"></i> ${pct >= 0 ? '+' : ''}${pct.toFixed(1)}% vs last month`;
        sub.className = 'kpi-sub ' + (pct >= 0 ? 'up' : 'down');
    }
}

const METRIC = {
    revenue: { fmt: peso, axis: v => v >= 1000 ? '₱' + (v / 1000) + 'k' : '₱' + v, color: '#2563eb', sub: 'Monthly incoming collections' },
    projects: { fmt: v => v + ' projects', axis: v => v, color: '#16a34a', sub: 'Active projects at month end' },
    quotes: { fmt: v => v + ' pending', axis: v => v, color: '#d97706', sub: 'Quotations waiting for review' }
};
let chartPts = [];
const CW = 720, CH = 260, PL = 52, PR = 18, PT = 18, PB = 32;

function renderStats() {
    const m = METRIC[ui.metric], months = lastMonths(ui.range), vals = months.map(x => metricValue(ui.metric, x.key));
    $('chart-subtitle').textContent = `${m.sub} · last ${ui.range} months`;
    const cur = vals[vals.length - 1], prev = vals.length > 1 ? vals[vals.length - 2] : 0;
    const avg = vals.reduce((a, b) => a + b, 0) / vals.length, peakI = vals.indexOf(Math.max(...vals));
    let chg = '—', cls = '';
    if (prev) { const p = (cur - prev) / prev * 100; chg = (p >= 0 ? '+' : '') + p.toFixed(1) + '%'; cls = p >= 0 ? 'up' : 'down'; }
    $('stat-tiles').innerHTML = `
        <div class="stat-tile"><span>CURRENT</span><strong>${m.fmt(cur)}</strong><small>${months[months.length - 1].full}</small></div>
        <div class="stat-tile"><span>AVERAGE</span><strong>${ui.metric === 'revenue' ? peso(avg) : avg.toFixed(1)}</strong><small>per month</small></div>
        <div class="stat-tile"><span>PEAK</span><strong>${m.fmt(vals[peakI])}</strong><small>${months[peakI].full}</small></div>
        <div class="stat-tile"><span>VS LAST MONTH</span><strong class="${cls}">${chg}</strong><small>change</small></div>`;
    const maxV = Math.max(...vals, 1);
    let top;
    if (ui.metric === 'revenue') {
        const raw = maxV * 1.1 / 4, mag = Math.pow(10, Math.floor(Math.log10(raw)));
        top = [1, 2, 2.5, 5, 10].map(k => k * mag).find(v => v >= raw) * 4;
    } else top = Math.max(4, Math.ceil(maxV * 1.1 / 4) * 4);
    const x = i => PL + (vals.length === 1 ? (CW - PL - PR) / 2 : i * (CW - PL - PR) / (vals.length - 1));
    const y = v => PT + (CH - PT - PB) * (1 - v / top), base = y(0);
    chartPts = vals.map((v, i) => ({ x: x(i), y: y(v), v, month: months[i] }));
    let svg = `<defs><linearGradient id="areaG" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="${m.color}" stop-opacity="0.28"/><stop offset="1" stop-color="${m.color}" stop-opacity="0"/></linearGradient></defs>`;
    for (let t = 0; t <= 4; t++) {
        const yy = y(top / 4 * t);
        svg += `<line x1="${PL}" x2="${CW - PR}" y1="${yy}" y2="${yy}" stroke="#94a3b8" stroke-opacity=".3" stroke-dasharray="${t === 0 ? '0' : '4 4'}"/>`;
        svg += `<text x="${PL - 8}" y="${yy + 3}" text-anchor="end" font-size="10" fill="#94a3b8">${m.axis(top / 4 * t)}</text>`;
    }
    let line = `M ${chartPts[0].x} ${chartPts[0].y}`;
    for (let i = 1; i < chartPts.length; i++) {
        const a = chartPts[i - 1], b = chartPts[i], mx = (a.x + b.x) / 2;
        line += ` C ${mx} ${a.y}, ${mx} ${b.y}, ${b.x} ${b.y}`;
    }
    svg += `<path d="${line} L ${chartPts[chartPts.length - 1].x} ${base} L ${chartPts[0].x} ${base} Z" fill="url(#areaG)"/>`;
    svg += `<path d="${line}" fill="none" stroke="${m.color}" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>`;
    chartPts.forEach((p, i) => {
        const last = i === chartPts.length - 1;
        svg += `<circle cx="${p.x}" cy="${p.y}" r="${last ? 5 : 3.5}" fill="#fff" stroke="${m.color}" stroke-width="2"/>`;
        svg += `<text x="${p.x}" y="${CH - 10}" text-anchor="middle" font-size="11" fill="${last ? m.color : '#94a3b8'}" font-weight="${last ? 700 : 500}">${p.month.label}</text>`;
    });
    svg += `<line id="hover-line" x1="0" x2="0" y1="${PT}" y2="${base}" stroke="${m.color}" stroke-opacity="0.35" stroke-dasharray="3 3" style="display:none"/>`;
    svg += `<circle id="hover-dot" r="6" fill="${m.color}" stroke="#fff" stroke-width="2" style="display:none"/>`;
    $('chart-svg').innerHTML = svg;
}
function chartHover(e) {
    if (!chartPts.length) return;
    const r = $('chart-svg').getBoundingClientRect(), vx = (e.clientX - r.left) / r.width * CW;
    let best = 0;
    chartPts.forEach((p, i) => { if (Math.abs(p.x - vx) < Math.abs(chartPts[best].x - vx)) best = i; });
    const p = chartPts[best], tip = $('chart-tip'), hl = $('hover-line'), hd = $('hover-dot');
    hl.setAttribute('x1', p.x); hl.setAttribute('x2', p.x); hl.style.display = '';
    hd.setAttribute('cx', p.x); hd.setAttribute('cy', p.y); hd.style.display = '';
    tip.innerHTML = `${METRIC[ui.metric].fmt(p.v)}<small>${p.month.full}</small>`;
    tip.style.left = (p.x / CW * r.width) + 'px'; tip.style.top = (p.y / CH * r.height) + 'px';
    tip.classList.add('show');
}
function chartLeave() {
    $('chart-tip').classList.remove('show');
    ['hover-line', 'hover-dot'].forEach(id => { const el = $(id); if (el) el.style.display = 'none'; });
}
function bar(label, count, total, cls) {
    const pct = total ? Math.round(count / total * 100) : 0;
    return `<div class="bd-row"><div class="bd-label"><span>${label}</span><span>${count} · ${pct}%</span></div><div class="bd-track"><div class="bd-fill ${cls}" style="width:${pct}%"></div></div></div>`;
}
function renderBreakdown() {
    const P = db.projects, Q = db.quotes, c = (arr, s) => arr.filter(x => x.status === s).length;
    const approved = c(Q, 'approved'), decided = approved + c(Q, 'rejected');
    $('breakdown').innerHTML =
        `<div class="breakdown-title">PROJECTS (${P.length})</div>` + bar('Active', c(P, 'active'), P.length, 'primary') + bar('Completed', c(P, 'completed'), P.length, 'success') + bar('On Hold', c(P, 'hold'), P.length, 'warning') +
        `<div class="bd-divider"></div><div class="breakdown-title">QUOTATIONS (${Q.length}) · APPROVAL RATE ${decided ? Math.round(approved / decided * 100) + '%' : '—'}</div>` +
        bar('Pending', c(Q, 'pending'), Q.length, 'warning') + bar('Approved', approved, Q.length, 'success') + bar('Rejected', c(Q, 'rejected'), Q.length, 'danger');
}
function renderEvents() {
    const rows = db.events.slice(0, ui.eventsShown);
    $('events-tbody').innerHTML = rows.length ? rows.map(e => `<tr>
        <td><span class="req-id">#EVT-${e.id}</span></td><td>${esc(e.desc)}</td><td>${esc(e.user)}</td><td>${fmtTime(e.time).main}</td>
        <td class="text-right"><span class="status-badge completed"><i class="fa-solid fa-circle-check"></i> Success</span></td></tr>`).join('') : emptyRow(5, 'No recent operations.');
}


function renderRevenueModal() {
    $('rev-list').innerHTML = lastMonths(12).reverse().map((m, i) => `
        <div class="item-row"><div class="item-info"><strong>${m.full}</strong><span>${i === 0 ? 'Current month' : ''}</span></div>
        <div class="item-actions"><strong style="font-size:13px;">${peso(monthRevenue(m.key))}</strong></div></div>`).join('');
}



/* ===================== Quotations ===================== */
const QBADGE = {
    pending: '<span class="status-badge pending"><i class="fa-solid fa-clock"></i> Pending</span>',
    approved: '<span class="status-badge approved"><i class="fa-solid fa-circle-check"></i> Approved</span>',
    rejected: '<span class="status-badge rejected"><i class="fa-solid fa-circle-xmark"></i> Rejected</span>'
};
const QLABEL = { pending: 'Pending', approved: 'Approved', rejected: 'Rejected' };
function renderQuotes() {
    const term = ui.q.search.toLowerCase();
    const searched = db.quotes.filter(x => (x.id + ' ' + x.client + ' ' + x.scope + ' ' + fmtDate(x.date) + ' ' + x.amount).toLowerCase().includes(term));
    const cnt = s => s === 'all' ? searched.length : searched.filter(x => x.status === s).length;
    $('q-tabs').innerHTML = ['all', 'pending', 'approved', 'rejected'].map(s =>
        `<button class="seg-btn ${ui.q.status === s ? 'active' : ''}" data-qs="${s}" role="tab">${s === 'all' ? 'All' : QLABEL[s]}<b>${cnt(s)}</b></button>`).join('');
    const list = searched.filter(x => ui.q.status === 'all' || x.status === ui.q.status).sort((a, b) => b.date - a.date);
    const pages = Math.max(1, Math.ceil(list.length / ui.perPage));
    if (ui.q.page > pages) ui.q.page = pages;
    $('q-tbody').innerHTML = list.length ? pageSlice(list, ui.q).map(x => {
        const view = `<button class="icon-action" title="${x.status === 'pending' ? 'Review quotation' : 'View quotation'}" aria-label="View quotation #${x.id}" data-qact="view" data-id="${x.id}"><i class="fa-solid fa-eye" aria-hidden="true"></i></button>`;
        const actions = x.status === 'approved'
            ? view + (x.sentAt
                ? `<button class="icon-action success" title="Sent to customer on ${fmtDate(x.sentAt)}" disabled><i class="fa-solid fa-check-double"></i></button>`
                : `<button class="icon-action send" title="Send to customer" data-qact="send" data-id="${x.id}"><i class="fa-solid fa-paper-plane"></i></button>`)
            : x.status === 'rejected' ? view
            : view;   // Approve, Edit and Reject are inside the quotation view, after reviewing it
        const note = x.status === 'rejected' && x.notes ? `<div class="note-line">${esc(x.notes)}</div>`
            : x.status === 'rejected' ? '<div class="note-line">Returned to the admin for changes</div>'
        : x.status === 'approved' ? `<div class="note-line">${x.sentAt ? 'Sent to customer · ' + fmtDate(x.sentAt) : 'Not yet sent to customer'}</div>` : '';
        return `<tr><td><span class="req-id">#${x.id}</span></td>
            <td><div class="client-cell">${badge(x.client)}<div class="client-info"><strong>${esc(x.client)}</strong><span>Project: ${esc(x.scope)}</span></div></div></td>
            <td>${fmtDate(x.date)}</td><td><strong>${peso(x.amount)}</strong></td><td>${QBADGE[x.status]}${note}</td>
            <td class="text-right"><div class="action-icons">${actions}</div></td></tr>`;
    }).join('') : emptyRow(6, 'No quotations match your search or filter.');
    pager('q-pager', ui.q, list.length, 'QUOTATIONS', renderQuotes);
}
function closePanels() { $('panel-revision').classList.remove('active'); $('panel-reject').classList.remove('active'); ui.activeQuote = null; }
const quoteById = id => db.quotes.find(q => q.id === id);
/* Quotation document: same letterhead + table template the admin side uses */
const ITEM_DESC = {
    '16-Channel DVR': 'Recorders & Storage', '8-Channel DVR': 'Recorders & Storage', '1TB Surveillance HDD': 'Recorders & Storage',
    'IP Camera (Dome)': 'Cameras', 'IP Camera (Bullet)': 'Cameras', 'Wi-Fi Indoor Camera': 'Cameras',
    'Power Adapter & Connectors': 'Power & Cabling', 'PoE Switch 8-Port': 'Power & Cabling', 'Cat6 Cable (305m Box)': 'Power & Cabling', 'UPS 650VA': 'Power & Cabling',
    'Fingerprint Door Lock': 'Access Control', 'Gate Access Controller': 'Access Control', 'Video Doorbell': 'Access Control',
    'Cabling & Installation': 'Labor and materials for cabling and mounting', 'System Configuration & Commissioning': 'Setup, testing and customer handover'
};
const CLIENT_ADDR = {
    'Apex Inc.': 'Rizal Ave., Caloocan City', 'Nova Retail': 'EDSA, Quezon City', 'Orion Clinic': 'Taft Ave., Manila',
    'Vortex Logistics': 'MacArthur Hwy., Valenzuela City', 'Helios Tower': 'Ayala Ave., Makati City', 'Atlas Factory': 'C-5 Road, Pasig City',
    'Harbor Hotel': 'Roxas Blvd., Pasay City', 'Zenith School': 'Katipunan Ave., Quezon City'
};
function quoteDocHTML(x) {
    const t = quoteCalc(x), adj = r2(x.amount - t.total), vd = x.validity || VALIDITY_DEFAULT;
    const rows = (x.items || []).map(i => ({ qty: i.qty + (i.qty > 1 ? ' pcs' : ' pc'), name: i.name, desc: i.desc || ITEM_DESC[i.name] || '', unit: i.price, amt: i.qty * i.price }));
    if (t.tr > 0) rows.push({ qty: '1 lot', name: 'Extra expenses', desc: '', unit: t.tr, amt: t.tr });
    (x.laborLines || []).forEach(w => rows.push({ qty: w.workers + ' pax', name: 'Labor: ' + w.role, desc: w.days + ' day(s) @ ' + peso(w.daily_rate) + ' per day', unit: w.days * w.daily_rate, amt: +w.amount }));
    const rowHTML = r => `<tr><td class="c">${esc(r.qty)}</td><td><b>${esc(r.name)}</b></td><td class="d">${esc(r.desc)}</td><td class="r">${peso(r.unit)}</td><td class="r">${peso(r.amt)}</td></tr>`;
    const table = list => `<table class="qd-tbl"><thead><tr><th>QTY</th><th>PRODUCT / SERVICE</th><th>DESCRIPTION</th><th class="r">UNIT PRICE</th><th class="r">AMOUNT</th></tr></thead><tbody>${list.map(rowHTML).join('') || '<tr><td colspan="5" class="c">No items listed.</td></tr>'}</tbody></table>`;
    const head = `<div class="qd-lh"><div class="wm">Beyond<span>wires</span></div><div class="sub">SECURITY SYSTEM SERVICES</div>
        <p>Rosal St., Tala, Caloocan City | beyondwires.info@gmail.com | +63945-329-6845<br>DTI-BRN: 6145128 | NON-VAT TIN: 421-649-525</p></div>
        <div class="qd-top"><span>${fmtDate(x.date)}</span><span>Quotation No. <b>${esc(x.id)}</b></span></div>
        <p class="qd-intro"><b>Dear Ma'am/Sir,</b><br>Thank you for your interest in doing business with BEYONDWIRES SECURITY SYSTEM SERVICES. Below are the items and overall price we curated for you.</p>
        <div class="qd-info"><div><span>Customer Name</span><b>${esc(x.client)}</b></div><div><span>Address</span><b>${esc(x.address || CLIENT_ADDR[x.client] || '—')}</b></div>
        <div><span>Project</span><b>${esc(x.scope)}</b></div><div><span>Scope of work</span><em>${esc(x.scopeText || 'Scope of work: supply and installation of CCTV and related accessories, including testing and commissioning.')}</em></div></div>`;
    const cont = `<div class="qd-lh slim"><div class="wm">Beyond<span>wires</span></div><span>Quotation ${esc(x.id)} (continued)</span></div>`;
    const notes = ['Prices are based on the items listed above. Changes in scope will be quoted separately.']
        .concat(String(x.quoteNotes || '').split('\n').map(s => s.trim()).filter(Boolean));
    const closing = `<div class="qd-totals"><div><span>Subtotal</span><b>${peso(t.sub + t.tr + t.lab)}</b></div><div><span>VAT (12%)</span><b>${peso(t.vat)}</b></div>
        ${Math.abs(adj) > 0.009 ? `<div><span>Price adjustment</span><b>${peso(adj)}</b></div>` : ''}<div class="g"><span>TOTAL PROJECT COST</span><b>${peso(x.amount)}</b></div></div>
        <div class="qd-meta"><div><span>Project Duration</span>${esc(x.duration || 'To be confirmed after site assessment')}</div>
        <div><span>Terms of Payment</span>Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)</div>
        <div><span>Validity</span>${vd} day${vd === 1 ? '' : 's'} from the date issued (until ${fmtDate(x.date + vd * 864e5)})</div></div>
        <ul class="qd-notes">${notes.map(n => `<li>${esc(n)}</li>`).join('')}</ul>
        <div class="qd-sign2"><div><small>Project In-charge:</small><u>${esc(x.incharge || profile.name)}</u><span>BeyondWires Representative</span></div>
        <div><small>Conformé:</small><u></u><span>${esc(x.client)} Representative</span></div></div>`;
    const pages = []; let rest = rows.slice(), first = true;
    for (;;) {
        const withClose = first ? 7 : 13, noClose = first ? 14 : 21;
        if (rest.length <= withClose) { pages.push((first ? head : cont) + table(rest) + closing); break; }
        const n = Math.min(noClose, rest.length - 1);
        pages.push((first ? head : cont) + table(rest.slice(0, n))); rest = rest.slice(n); first = false;
    }
    return '<div class="qd-scale">' + pages.map((p, i) => `<div class="qd-page qd-q">${p}<div class="qd-foot">Page ${i + 1} of ${pages.length}</div></div>`).join('') + '</div>';
}
async function viewQuote(id) {
    const x = quoteById(id); if (!x) return;
    try { await loadQuote(x); } catch (e) { return toast(e.message, 'error'); }
    $('qv-title').textContent = 'Quotation #' + x.id;
    $('qv-sub').innerHTML = QBADGE[x.status] + ' &nbsp;' + esc(x.client) + ' · ' + peso(x.amount);
    $('qv-docs').innerHTML = quoteDocHTML(x); $('qv-docs').scrollLeft = 0;
    $('qv-note').hidden = !x.notes; $('qv-note').textContent = x.notes ? 'Your comment: ' + x.notes : '';
    $('qv-send').hidden = !(x.status === 'approved' && !x.sentAt); $('qv-send').dataset.id = x.id;
    ['qv-reject', 'qv-revise', 'qv-approve'].forEach(b => { $(b).hidden = x.status !== 'pending'; $(b).dataset.id = x.id; });
    openModal('modal-viewquote');
}
/* Approving sends the quotation straight to the customer (the server publishes it and notifies the customer and the admin). */
async function approveQuote(id) {
    closePanels();
    const x = quoteById(id); if (!x) return;
    if (!(await window.BW.confirm({ title: 'Approve and send?', message: `Approve quotation #${id} (${peso(x.amount)}) and send it to ${x.client}?`, ok: 'Approve & send' }))) return;
    closeModal('modal-viewquote');
    run(() => api('/owner/quotations/' + x.dbId + '/approve', { body: {} }), `Quotation #${id} approved and sent to ${x.client}.`);
}
/* the review buttons in the quotation view (pending quotations only) */
['qv-reject', 'qv-revise', 'qv-approve'].forEach(b => document.getElementById(b) && document.getElementById(b).addEventListener('click', e => {
    const id = e.currentTarget.dataset.id;
    if (b === 'qv-approve') return approveQuote(id);
    closeModal('modal-viewquote');
    (b === 'qv-reject' ? openReject : openRevision)(id);
}));
function sendQuote(id) {
    const x = quoteById(id); if (!x) return;
    toast(x.sentAt ? `Quotation #${id} was sent to the customer on ${fmtDate(x.sentAt)}` : `Approve quotation #${id} to send it to the customer`, x.sentAt ? 'success' : 'error');
}
/* ---- edit validation ---- */
function revIssue(f, v) {
    if (f === 'qty') {
        if (!Number.isInteger(v)) return 'Enter a whole number';
        if (v < QTY_MIN) return 'Minimum is ' + QTY_MIN;
        if (v > QTY_MAX) return 'Maximum is ' + QTY_MAX + ' per item';
    } else if (f === 'price') {
        if (!isFinite(v)) return 'Enter a unit price';
        if (v < PRICE_MIN) return 'Minimum is ' + peso(PRICE_MIN);
        if (v > PRICE_MAX) return 'Maximum is ' + peso(PRICE_MAX);
        if (Math.abs(v * 100 - Math.round(v * 100)) > 1e-6) return 'Use up to 2 decimal places';
    } else if (f === 'transport') {
        if (!isFinite(v) || v < 0) return 'Cannot be negative';
        if (v > EXP_MAX) return 'Maximum is ' + peso(EXP_MAX);
        if (Math.abs(v * 100 - Math.round(v * 100)) > 1e-6) return 'Use up to 2 decimal places';
    } else if (f === 'validity') {
        if (!Number.isInteger(v)) return 'Enter whole days';
        if (v < VALIDITY_MIN || v > VALIDITY_MAX) return 'Must be ' + VALIDITY_MIN + ' to ' + VALIDITY_MAX + ' days';
    }
    return '';
}
const numVal = el => el.value.trim() === '' ? NaN : Number(el.value);
function markField(input, msg) {
    input.classList.toggle('invalid', !!msg);
    input.setAttribute('aria-invalid', msg ? 'true' : 'false');
    const field = input.closest('.field'); if (!field) return;
    let el = field.querySelector('.rv-err, .bw-live-err');   // the live check (JS/api.js) may have made one already
    if (!el) { el = document.createElement('small'); el.className = 'rv-err'; field.appendChild(el); }
    el.textContent = msg || '';
}
async function openRevision(id) {
    const x = quoteById(id); if (!x) return;
    try { await loadQuote(x); } catch (e) { return toast(e.message, 'error'); }
    ui.activeQuote = id; $('panel-reject').classList.remove('active');
    ui.draft = { items: (x.items || []).map(i => ({ product_id: i.product_id, name: i.name, qty: i.qty, price: i.price })), transport: x.transport || 0, labor: x.labor || 0, noVat: x.noVat };
    $('rev-title').textContent = 'Edit Quotation: #' + id;
    $('rev-transport').value = ui.draft.transport || '';
    $('rev-validity').value = x.validity || VALIDITY_DEFAULT;
    ['rev-transport', 'rev-validity'].forEach(k => markField($(k), ''));
    $('rev-notes').value = x.quoteNotes || ''; $('rev-notes').maxLength = 400;
    renderRevItems();
    $('panel-revision').classList.add('active');
    $('panel-revision').scrollIntoView({ behavior: 'smooth', block: 'nearest' });
}
function renderRevItems() {
    $('rev-items').innerHTML = `<label style="display:block;font-size:11px;font-weight:700;margin-bottom:6px">LINE ITEMS (QUANTITY ${QTY_MIN}&ndash;${QTY_MAX} / UNIT PRICE ${peso(PRICE_MIN)}&ndash;${peso(PRICE_MAX)})</label>` +
        ui.draft.items.map((it, i) => `<div class="form-row" style="align-items:flex-start;margin-bottom:6px"><div class="field" style="flex:2"><input type="text" value="${esc(it.name)}" disabled></div><div class="field" style="flex:.6"><input type="number" required data-check="int" min="${QTY_MIN}" max="${QTY_MAX}" step="1" data-rv="qty" data-i="${i}" value="${it.qty}" aria-label="Quantity"></div><div class="field" style="flex:1"><input type="number" required data-check="money" min="${PRICE_MIN}" max="${PRICE_MAX}" step="0.01" data-rv="price" data-i="${i}" value="${it.price}" aria-label="Unit price"></div></div>`).join('');
    updateRevTotals();
}
function updateRevTotals() {
    const t = quoteCalc({ items: ui.draft.items.map(i => ({ qty: +i.qty || 0, price: +i.price || 0 })), transport: +ui.draft.transport || 0, labor: ui.draft.labor });   // the server adds VAT on save
    $('rev-totals').innerHTML = `Subtotal: <b>${peso(t.sub)}</b> &nbsp;|&nbsp; Transport: <b>${peso(t.tr)}</b>${t.lab ? ` &nbsp;|&nbsp; Labor: <b>${peso(t.lab)}</b>` : ''} &nbsp;|&nbsp; VAT (12%): <b>${peso(t.vat)}</b> &nbsp;|&nbsp; New total: <b>${peso(t.total)}</b>`;
}
function openReject(id) {
    const x = quoteById(id); if (!x) return;
    ui.activeQuote = id; $('panel-revision').classList.remove('active');
    $('rej-title').textContent = 'Reject with Feedback: #' + id;
    $('rej-notes').value = ''; $('rej-notes').maxLength = 400; markField($('rej-notes'), '');
    $('rej-reason').value = ''; $('rej-other').value = ''; $('rej-other-wrap').hidden = true; markField($('rej-reason'), ''); markField($('rej-other'), '');
    $('panel-reject').classList.add('active');
    $('panel-reject').scrollIntoView({ behavior: 'smooth', block: 'nearest' });
}
function submitRevision() {
    const x = quoteById(ui.activeQuote); if (!x || !ui.draft) return;
    const issues = [];
    $$('#rev-items [data-rv]').forEach(inp => {
        const it = ui.draft.items[+inp.dataset.i], m = revIssue(inp.dataset.rv, numVal(inp));
        markField(inp, m); if (m) issues.push(it.name + ': ' + m);
    });
    const trIn = $('rev-transport'), tr = trIn.value.trim() === '' ? 0 : Number(trIn.value), trMsg = revIssue('transport', tr);
    markField(trIn, trMsg); if (trMsg) issues.push('Transport / other expenses: ' + trMsg);
    const vIn = $('rev-validity'), validity = numVal(vIn), vMsg = revIssue('validity', validity);
    markField(vIn, vMsg); if (vMsg) issues.push('Validity: ' + vMsg);
    const notesTxt = $('rev-notes').value.trim();
    if (notesTxt.length > 400) issues.push('Terms / scope notes: 400 characters or fewer');
    if (notesTxt.split('\n').length > 8) issues.push('Terms / scope notes: at most 8 lines');
    if (issues.length) { toast(issues[0] + (issues.length > 1 ? ` (+${issues.length - 1} more)` : ''), 'error'); return; }
    const same = ui.draft.items.every((it, i) => x.items[i] && +it.qty === +x.items[i].qty && Math.abs(+it.price - +x.items[i].price) < 0.009) &&
        Math.abs(r2(tr) - r2(x.transport || 0)) < 0.009 && validity === (x.validity || VALIDITY_DEFAULT) && notesTxt === String(x.quoteNotes || '').trim();
    if (same) { toast('No changes to save', 'error'); return; }
    /* unchanged extra expenses keep the admin's itemised list; a new amount becomes one "Extra expenses" line */
    const charges = Math.abs(r2(tr) - r2(x.transport || 0)) < 0.009 ? (x.charges || []).map(c => ({ label: c.label, amount: +c.amount })) : (tr > 0 ? [{ label: 'Extra expenses', amount: r2(tr) }] : []);
    const body = { items: ui.draft.items.map(i => ({ product_id: i.product_id, quantity: Math.round(i.qty), unit_price: r2(i.price) })), charges, validity_days: validity, notes: $('rev-notes').value.trim() };
    const id = x.id; closePanels();
    run(() => api('/owner/quotations/' + x.dbId, { method: 'PUT', body }), `Quotation #${id} updated`);
}
document.addEventListener('change', e => { if (e.target.id === 'rej-reason') { $('rej-other-wrap').hidden = e.target.value !== 'Others'; markField(e.target, ''); } });
function submitRejection() {
    const x = quoteById(ui.activeQuote); if (!x) return;
    const notes = $('rej-notes').value.trim(), pick = $('rej-reason').value, other = $('rej-other').value.trim();
    /* a reason from the list is required; "Others" needs the reason typed in */
    if (!pick) { markField($('rej-reason'), 'Choose a reason'); return toast('Choose a reason for rejecting', 'error'); }
    markField($('rej-reason'), '');
    if (pick === 'Others' && other.length < 3) { markField($('rej-other'), 'Type the reason'); return toast('Please specify the reason', 'error'); }
    markField($('rej-other'), '');
    if (notes && notes.length < 10) { markField($('rej-notes'), 'At least 10 characters'); return toast('Comment must be at least 10 characters', 'error'); }
    if (notes.length > 400) { markField($('rej-notes'), '400 characters or fewer'); return toast('Comment must be 400 characters or fewer', 'error'); }
    markField($('rej-notes'), '');
    const comment = (pick === 'Others' ? other : pick) + (notes ? ': ' + notes : '');
    const id = x.id; closePanels();
    run(() => api('/owner/quotations/' + x.dbId + '/reject', { body: { comment } }), `Quotation #${id} returned to the admin with your feedback`);
}

/* ===================== Projects ===================== */
const PSTATUS = {
    active: '<span class="status-badge progress">Active</span>',
    completed: '<span class="status-badge completed">Completed</span>',
    hold: '<span class="status-badge hold">On Hold</span>'
};
function projFiltered(ignoreStatus) {
    const t = ui.p.search.toLowerCase();
    const from = ui.p.from ? new Date(ui.p.from + 'T00:00:00').getTime() : -Infinity;
    const to = ui.p.to ? new Date(ui.p.to + 'T23:59:59').getTime() : Infinity;
    return db.projects.filter(p => (p.code + ' ' + p.client + ' ' + p.name + ' ' + fmtDate(p.start)).toLowerCase().includes(t)
        && p.start >= from && p.start <= to && (ignoreStatus || ui.p.status === 'all' || p.status === ui.p.status));
}
function renderProjectsTab() {
    const base = projFiltered(true), c = s => base.filter(p => p.status === s).length;
    $('p-counts').innerHTML = `<div class="count-chip"><span>TOTAL PROJECTS</span><strong>${base.length}</strong></div>
        <div class="count-chip active"><span>ACTIVE</span><strong>${c('active')}</strong></div>
        <div class="count-chip completed"><span>COMPLETED</span><strong>${c('completed')}</strong></div>
        <div class="count-chip hold"><span>ON HOLD</span><strong>${c('hold')}</strong></div>`;
    const list = projFiltered(false), pages = Math.max(1, Math.ceil(list.length / ui.perPage));
    if (ui.p.page > pages) ui.p.page = pages;
    $('p-tbody').innerHTML = list.length ? pageSlice(list, ui.p).map(p => `<tr>
        <td><span class="req-id">#${esc(p.code)}</span></td>
        <td><div class="client-cell">${badge(p.client)}<div class="client-info"><strong>${esc(p.client)}</strong><span>${esc(p.name)}</span></div></div></td>
        <td>${fmtDate(p.start)}</td><td>${PSTATUS[p.status] || ''}</td></tr>`).join('') : emptyRow(4, 'No projects match your filters.');
    pager('p-pager', ui.p, list.length, 'PROJECTS', renderProjectsTab);
}

/* ===================== Financial (cash basis, from /owner/finance/overview) =====================
   Cash received = confirmed payments; VAT is taken out of revenue; cash paid out = recorded expenses
   (voided ones excluded); receivables = approved quotations minus what was paid. */
const FIN_COLORS = ['#0077F6', '#0B132B', '#10b981', '#f59e0b', '#8b5cf6', '#64748b', '#ef4444', '#14b8a6'];
const fin = { period: 'YTD', data: null, expenses: [], meta: { categories: [], methods: [] }, editing: null, viewing: null, seq: 0 };
let finReady = false, finCharts = [];
const pesoK = v => '₱' + (Math.abs(v) >= 1000 ? Math.round(v / 1000).toLocaleString('en-US') + 'k' : Math.round(v));
const isoDay = d => d.getFullYear() + '-' + String(d.getMonth() + 1).padStart(2, '0') + '-' + String(d.getDate()).padStart(2, '0');
function periodRange(p) {
    const now = new Date(), y = now.getFullYear();
    const q = { Q1: [0, 2], Q2: [3, 5], Q3: [6, 8], Q4: [9, 11] }[p];
    if (!q) return [y + '-01-01', isoDay(now)];
    const to = new Date(y, q[1] + 1, 0);
    return [isoDay(new Date(y, q[0], 1)), isoDay(to > now ? now : to)];
}
function finQuery() {
    return { from: $('fin-from').value, to: $('fin-to').value, project: +$('fin-project').value || 0, category: $('fin-category').value };
}
function finError(msg) { $('fin-err').textContent = msg || ''; $('fin-err').hidden = !msg; }
async function loadFinance() {
    const q = finQuery(), seq = ++fin.seq;
    if (!q.from || !q.to) return finError('Choose a start and end date.');
    if (q.from > q.to) return finError('The start date must be on or before the end date.');
    finError('');
    try {
        const [ov, ex] = await Promise.all([api('/owner/finance/overview', { query: q }),
            api('/owner/expenses', { query: { from: q.from, to: q.to, project: q.project || '', category: q.category, status: $('fin-exp-status').value } })]);
        if (seq !== fin.seq) return;   // a newer filter change is already loading
        fin.data = ov; fin.expenses = ex; fin.meta = { categories: ov.categories, methods: ov.methods };
        renderFinance();
    } catch (e) { finError(e.message); }
}
function fillFinSelects() {
    const keepP = $('fin-project').value, keepC = $('fin-category').value;
    $('fin-project').innerHTML = '<option value="0">All projects</option>' + db.projects.map(p => `<option value="${p.dbId}">${esc(p.code + ' · ' + p.client)}</option>`).join('');
    $('fin-project').value = db.projects.some(p => String(p.dbId) === keepP) ? keepP : '0';
    const cats = Array.from(new Set((fin.meta.categories || []).concat((fin.data ? fin.data.by_category : []).map(c => c.category))));
    $('fin-category').innerHTML = '<option value="all">All categories</option>' + cats.map(c => `<option>${esc(c)}</option>`).join('');
    $('fin-category').value = cats.includes(keepC) ? keepC : 'all';
}
function renderFinance() {
    const d = fin.data; if (!d) return;
    const t = d.totals;
    $('fin-in').textContent = peso(t.cash_in); $('fin-out').textContent = peso(t.cash_out);
    $('fin-net').textContent = peso(t.net_cash); $('fin-net').classList.toggle('text-danger', t.net_cash < 0);
    $('fin-recv').textContent = peso(t.receivables);
    $('fin-rev').textContent = peso(t.revenue); $('fin-vat').textContent = 'VAT collected ' + peso(t.vat);
    $('fin-exp').textContent = peso(t.cash_out);
    $('fin-profit').textContent = peso(t.net_profit); $('fin-profit').classList.toggle('text-danger', t.net_profit < 0);
    $('fin-margin').textContent = t.margin == null ? 'Margin: — (no revenue yet)' : 'Margin: ' + t.margin.toFixed(1) + '%' + (t.net_profit < 0 ? ' (loss)' : '');
    $$('#fin-period .filter-tab').forEach(b => b.classList.toggle('active', b.dataset.period === fin.period));
    const cats = d.by_category;
    $('fin-donut-legend').innerHTML = cats.length ? cats.map((c, i) => `<div class="legend-row"><span><span class="dot" style="background:${FIN_COLORS[i % FIN_COLORS.length]}"></span> ${esc(c.category)}</span><strong>${peso(+c.total)}</strong></div>`).join('')
        : '<p class="modal-subtitle" style="margin:0">No expenses recorded for this range.</p>';
    $('fin-exp-tbody').innerHTML = fin.expenses.length ? fin.expenses.map(e => `<tr${e.status === 'Void' ? ' class="row-void"' : ''}><td>${fmtDate(ms(e.expense_date))}</td><td>${esc(e.category_name)}</td>
        <td>${esc(e.description || '')}</td><td>${e.project_id ? esc(e.project_name || window.BW.prjNo(e.project_id)) : '<span class="muted">—</span>'}</td><td><strong>${peso(+e.amount)}</strong></td>
        <td>${e.status === 'Void' ? '<span class="status-badge rejected">Voided</span>' : '<span class="status-badge approved">Active</span>'}</td>
        <td class="text-right"><button class="icon-action" data-exp="${e.expense_id}" title="View details" aria-label="View expense ${esc(e.description || '')}"><i class="fa-solid fa-eye" aria-hidden="true"></i></button></td></tr>`).join('')
        : emptyRow(7, 'No expenses match these filters.');
    $('fin-proj-tbody').innerHTML = d.projects.length ? d.projects.map(p => `<tr><td><strong>${esc(window.BW.prjNo(p.project_id))}</strong><small class="cell-sub">${esc(p.customer)} · ${esc(p.quotation_no)}</small></td>
        <td>${peso(p.contract)}</td><td>${peso(p.paid)}</td><td>${peso(p.balance)}</td><td>${peso(p.estimated_costs)}${p.cost_incomplete ? '<small class="cell-sub" title="This quotation was made before supplier prices were saved on each line">excl. product costs</small>' : ''}</td>
        <td class="${p.estimated_profit < 0 ? 'text-danger' : ''}">${peso(p.estimated_profit)}</td><td>${peso(p.actual_costs)}</td>
        <td class="${p.realized_profit < 0 ? 'text-danger' : 'text-success bold'}">${peso(p.realized_profit)}</td></tr>`).join('') : emptyRow(8, 'No approved projects yet.');
    $('fin-tbody').innerHTML = d.months.slice().reverse().map(m => `<tr><td><strong>${monthLabel(m.month)}</strong></td><td>${peso(m.cash_in)}</td><td>${peso(m.vat)}</td><td>${peso(m.revenue)}</td>
        <td class="text-danger">${peso(m.cash_out)}</td><td class="${m.net_profit < 0 ? 'text-danger' : 'text-success'} bold">${peso(m.net_profit)}</td><td>${peso(m.net_cash)}</td></tr>`).join('');
    fillFinSelects(); updateFinCharts();
}
const monthLabel = k => { const [y, m] = k.split('-').map(Number); return new Date(y, m - 1, 1).toLocaleString('en-US', { month: 'long', year: 'numeric' }); };
/* ===================== Export: PDF, Excel (.xlsx) or CSV =====================
   Each report is described once (title, details, tables) and written in the chosen format.
   The PDF and Excel tools load only when someone exports. */
const EXPORT_LIBS = { pdf: 'https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js', xlsx: 'https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js' };
const exportLoads = {};
function loadExportLib(k) {
    if (k === 'pdf' && window.html2pdf) return Promise.resolve();
    if (k === 'xlsx' && window.XLSX) return Promise.resolve();
    return exportLoads[k] || (exportLoads[k] = new Promise((res, rej) => {
        const sc = document.createElement('script'); sc.src = EXPORT_LIBS[k]; sc.onload = res;
        sc.onerror = () => { delete exportLoads[k]; rej(new Error('Could not load the export tool. Check your internet connection and try again.')); };
        document.head.appendChild(sc);
    }));
}
/* report = { title, file, details: [[label, value]], sections: [{ title, head: [...], rows: [[...]], money: [column indexes] }] } */
function finReport() {
    const d = fin.data, t = d.totals, q = finQuery();
    const proj = q.project ? (db.projects.find(p => p.dbId === q.project) || {}).code : 'All projects';
    return {
        title: 'Financial Report (cash basis)', file: `financial-report-${d.from}-to-${d.to}`,
        details: [['Period', fmtDate(ms(d.from)) + ' to ' + fmtDate(ms(d.to))], ['Project', proj || 'All projects'], ['Expense category', q.category === 'all' ? 'All categories' : q.category], ['Prepared by', profile.name], ['Generated', new Date().toLocaleString('en-US')]],
        sections: [
            { title: 'Cash', head: ['Item', 'Amount'], money: [1], rows: [['Cash received (confirmed payments)', t.cash_in], ['Cash paid out (expenses)', t.cash_out], ['Net cash movement', t.net_cash], ['Outstanding receivables', t.receivables]] },
            { title: 'Profit (cash basis)', head: ['Item', 'Amount'], money: [1], rows: [['Cash received', t.cash_in], ['Less: VAT collected', t.vat], ['Revenue (excl. VAT)', t.revenue], ['Less: expenses', t.cash_out], ['Net profit', t.net_profit], ['Margin', t.margin == null ? '—' : t.margin.toFixed(1) + '%']] },
            { title: 'Expenses by category', head: ['Category', 'Amount'], money: [1], rows: d.by_category.map(c => [c.category, +c.total]) },
            { title: 'Monthly breakdown', head: ['Month', 'Cash in', 'VAT', 'Revenue (excl. VAT)', 'Expenses', 'Net profit', 'Net cash'], money: [1, 2, 3, 4, 5, 6], rows: d.months.map(m => [monthLabel(m.month), m.cash_in, m.vat, m.revenue, m.cash_out, m.net_profit, m.net_cash]) },
            { title: 'Project profitability', head: ['Project', 'Customer', 'Contract', 'Paid', 'Balance', 'Est. costs', 'Est. profit', 'Actual costs', 'Realized profit'], money: [2, 3, 4, 5, 6, 7, 8],
              rows: d.projects.map(p => [window.BW.prjNo(p.project_id), p.customer, p.contract, p.paid, p.balance, p.estimated_costs, p.estimated_profit, p.actual_costs, p.realized_profit]) },
            { title: 'Expense list', head: ['Date', 'Category', 'Description', 'Project', 'Amount', 'Paid by', 'Status'], money: [4],
              rows: fin.expenses.map(e => [e.expense_date, e.category_name, e.description || '', e.project_id ? window.BW.prjNo(e.project_id) : '', +e.amount, e.payment_method || '', e.status === 'Void' ? 'Voided: ' + (e.void_reason || '') : 'Active']) }
        ]
    };
}
function dashReport() {
    const ms12 = lastMonths(12), prev = monthRevenue(lastMonths(2)[0].key), cur = curRevenue();
    return {
        title: 'Dashboard Summary', file: 'dashboard-' + isoDay(new Date()),
        details: [['As of', new Date().toLocaleString('en-US')], ['Prepared by', profile.name]],
        sections: [
            { title: 'Key figures', head: ['Figure', 'Value'], money: [], rows: [['Active projects', activeProjects()], ['Pending quotations', pendingQuotes()], ['Revenue this month (confirmed payments)', peso(cur)], ['Revenue last month', peso(prev)]] },
            { title: 'Last 12 months', head: ['Month', 'Revenue (confirmed payments)', 'New projects', 'Quotations sent for approval'], money: [1],
              rows: ms12.slice().reverse().map(m => [m.full, monthRevenue(m.key), (db.hProj[m.key] || 0), (db.hQuote[m.key] || 0)]) },
            { title: 'Recent activity', head: ['When', 'Who', 'Role', 'Activity'], money: [], rows: db.events.slice(0, 15).map(e => [new Date(e.time).toLocaleString('en-US'), e.name || '', e.user || '', e.desc || '']) }
        ]
    };
}
function exportCSV(r) {
    const rows = [['BEYONDWIRES - ' + r.title.toUpperCase()]].concat(r.details, [[]]);
    r.sections.forEach(sec => { rows.push([sec.title.toUpperCase()], sec.head); sec.rows.forEach(x => rows.push(x)); rows.push([]); });
    downloadCSV(r.file + '.csv', rows);
}
async function exportXLSX(r) {
    await loadExportLib('xlsx');
    const X = window.XLSX, wb = X.utils.book_new();
    const sum = [['BeyondWires Security System Services'], [r.title], []].concat(r.details);
    X.utils.book_append_sheet(wb, X.utils.aoa_to_sheet(sum), 'Report');
    r.sections.forEach(sec => {
        const ws = X.utils.aoa_to_sheet([sec.head].concat(sec.rows.length ? sec.rows : [['No data']]));
        ws['!cols'] = sec.head.map((h, c) => ({ wch: Math.min(48, Math.max(12, h.length + 2, ...sec.rows.map(x => String(x[c] == null ? '' : x[c]).length + 2))) }));
        // money columns: thousands separator and 2 decimals
        sec.rows.forEach((x, ri) => sec.money.forEach(c => { const cell = ws[X.utils.encode_cell({ r: ri + 1, c })]; if (cell && cell.t === 'n') cell.z = '#,##0.00'; }));
        X.utils.book_append_sheet(wb, ws, sec.title.replace(/[\\/?*[\]:]/g, '').slice(0, 31));
    });
    X.writeFile(wb, r.file + '.xlsx');
}
async function exportPDF(r) {
    await loadExportLib('pdf');
    const e = window.BW.esc, cell = (sec, v, c) => sec.money.includes(c) && typeof v === 'number' ? peso(v) : e(v == null ? '' : v);
    const html = `<div style="width:740px;padding:28px 26px;font-family:Arial,Helvetica,sans-serif;color:#0B132B;font-size:10.5px;background:#fff">
        <div style="display:flex;justify-content:space-between;align-items:flex-end;border-bottom:3px solid #0077F6;padding-bottom:10px;margin-bottom:12px">
          <div><div style="font-size:22px;font-weight:bold">Beyond<span style="color:#0077F6">wires</span></div><div style="font-size:9px;letter-spacing:2px;color:#1B49B8;font-weight:bold">SECURITY SYSTEM SERVICES</div></div>
          <div style="text-align:right"><div style="font-size:15px;font-weight:bold">${e(r.title)}</div><div style="color:#5A6B85">Tala, Caloocan City</div></div></div>
        <table style="border-collapse:collapse;margin-bottom:12px">${r.details.map(x => `<tr><td style="padding:2px 14px 2px 0;color:#5A6B85">${e(x[0])}</td><td style="padding:2px 0;font-weight:bold">${e(x[1])}</td></tr>`).join('')}</table>
        ${r.sections.map(sec => `<div style="page-break-inside:avoid;margin-top:12px"><div style="font-weight:bold;font-size:12px;margin-bottom:5px;color:#0B132B">${e(sec.title)}</div>
          <table style="width:100%;border-collapse:collapse"><thead><tr>${sec.head.map((h, c) => `<th style="background:#0B132B;color:#fff;padding:5px 6px;text-align:${sec.money.includes(c) ? 'right' : 'left'};font-size:9.5px">${e(h)}</th>`).join('')}</tr></thead>
          <tbody>${(sec.rows.length ? sec.rows : [['No data']]).map((x, i) => `<tr style="background:${i % 2 ? '#F4F8FC' : '#fff'}">${x.map((v, c) => `<td style="padding:4px 6px;border-bottom:1px solid #DCE8F2;text-align:${sec.money.includes(c) ? 'right' : 'left'}">${cell(sec, v, c)}</td>`).join('')}</tr>`).join('')}</tbody></table></div>`).join('')}
        <div style="margin-top:16px;color:#8A98AE;font-size:9px">Generated by the BeyondWires system. Cash basis: money counts when it is received or paid; VAT is not revenue.</div></div>`;
    const host = document.createElement('div'); host.style.cssText = 'position:fixed;left:-10000px;top:0'; host.innerHTML = html; document.body.appendChild(host);
    try {
        await window.html2pdf().set({ margin: [10, 8, 12, 8], filename: r.file + '.pdf', image: { type: 'jpeg', quality: 0.95 }, html2canvas: { scale: 2, backgroundColor: '#ffffff' },
            jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }, pagebreak: { mode: ['css', 'legacy'] } }).from(host.firstElementChild).save();
    } finally { host.remove(); }
}
async function runExport(kind, fmt) {
    if (kind === 'fin' && !fin.data) return toast('Open the Financial tab and load the report first', 'error');
    const r = kind === 'fin' ? finReport() : dashReport();
    const btn = $(kind + '-export'); btn.disabled = true; btn.classList.add('loading');
    try {
        if (fmt === 'pdf') await exportPDF(r); else if (fmt === 'xlsx') await exportXLSX(r); else exportCSV(r);
        toast((fmt === 'xlsx' ? 'Excel file' : fmt.toUpperCase()) + ' downloaded');
    } catch (e) { toast(e.message || 'Export failed', 'error'); }
    finally { btn.disabled = false; btn.classList.remove('loading'); }
}
function updateFinCharts() {
    if (finCharts.length < 2 || !fin.data) return;
    const d = fin.data, [tr, dn] = finCharts;
    tr.data.labels = d.months.map(m => monthLabel(m.month).slice(0, 3) + " '" + m.month.slice(2, 4));   // e.g. Oct '26
    tr.data.datasets[0].data = d.months.map(m => m.cash_in); tr.data.datasets[1].data = d.months.map(m => m.cash_out); tr.update();
    dn.data.labels = d.by_category.map(c => c.category); dn.data.datasets[0].data = d.by_category.map(c => +c.total);
    dn.data.datasets[0].backgroundColor = d.by_category.map((c, i) => FIN_COLORS[i % FIN_COLORS.length]); dn.update();
}
function initFinance() {
    if (!finReady && typeof Chart !== 'undefined') {
        finReady = true;
        finCharts.push(new Chart($('trendChart'), {
            type: 'line',
            data: { labels: [], datasets: [
                { label: 'Cash in', data: [], borderColor: '#0077F6', backgroundColor: 'rgba(0,119,246,0.06)', borderWidth: 3, tension: 0.35, fill: true, pointRadius: 3, pointBackgroundColor: '#0077F6' },
                { label: 'Cash out', data: [], borderColor: '#ef4444', backgroundColor: 'transparent', borderWidth: 2, tension: 0.35, pointRadius: 3, pointBackgroundColor: '#ef4444' }] },
            options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false }, tooltip: { callbacks: { label: c => c.dataset.label + ': ' + peso(c.parsed.y) } } },
                scales: { y: { beginAtZero: true, grid: { color: 'rgba(148,163,184,.2)' }, ticks: { callback: v => pesoK(v), color: '#94a3b8', font: { size: 11 } } }, x: { grid: { display: false }, ticks: { color: '#94a3b8', font: { size: 11 } } } } }
        }));
        finCharts.push(new Chart($('expenseDonutChart'), {
            type: 'doughnut',
            data: { labels: [], datasets: [{ data: [], backgroundColor: FIN_COLORS, borderWidth: 2, borderColor: '#ffffff' }] },
            options: { responsive: true, maintainAspectRatio: false, cutout: '72%', plugins: { legend: { display: false }, tooltip: { callbacks: { label: c => c.label + ': ' + peso(c.parsed) } } } }
        }));
    } else finCharts.forEach(c => c.resize());
    if (!$('fin-from').value) { const [f, t] = periodRange(fin.period); $('fin-from').value = f; $('fin-to').value = t; }
    loadFinance();
}
/* ---- expense form (add / edit) and details (view, then edit or void) ---- */
function openExpenseForm(e) {
    fin.editing = e || null;
    $('exp-title').textContent = e ? 'Edit expense' : 'Record expense';
    const cats = fin.meta.categories.slice(); if (e && !cats.includes(e.category_name)) cats.push(e.category_name);
    $('exp-cat').innerHTML = '<option value="">Choose a category</option>' + cats.map(c => `<option>${esc(c)}</option>`).join('');
    $('exp-method').innerHTML = '<option value="">Not specified</option>' + fin.meta.methods.map(m => `<option>${esc(m)}</option>`).join('');
    $('exp-proj').innerHTML = '<option value="0">Not tied to a project</option>' + db.projects.map(p => `<option value="${p.dbId}">${esc(p.code + ' · ' + p.client + ' · ' + p.name)}</option>`).join('');
    $('exp-date').max = isoDay(new Date());
    $('exp-date').value = e ? e.expense_date : isoDay(new Date()); $('exp-amount').value = e ? (+e.amount).toFixed(2) : '';
    $('exp-cat').value = e ? e.category_name : ''; $('exp-proj').value = e && e.project_id ? String(e.project_id) : '0';
    $('exp-desc').value = e ? e.description || '' : ''; $('exp-method').value = e ? e.payment_method || '' : ''; $('exp-ref').value = e ? e.reference_no || '' : '';
    $('exp-err').hidden = true; ['exp-date', 'exp-amount', 'exp-cat', 'exp-desc'].forEach(id => markField($(id), ''));
    openModal('modal-expense'); $('exp-amount').focus();
}
function expenseFormCheck() {
    const v = { expense_date: $('exp-date').value, amount: $('exp-amount').value, category_name: $('exp-cat').value, description: $('exp-desc').value.trim(),
        project_id: +$('exp-proj').value || null, payment_method: $('exp-method').value, reference_no: $('exp-ref').value.trim() };
    const errs = {
        'exp-date': !v.expense_date ? 'Choose the date' : v.expense_date > isoDay(new Date()) ? 'Cannot be in the future' : '',
        'exp-amount': !(+v.amount > 0) ? 'Enter an amount above 0' : +v.amount > 10000000 ? 'Up to 10,000,000' : /\.\d{3,}$/.test(v.amount) ? 'At most 2 decimals' : '',
        'exp-cat': v.category_name ? '' : 'Choose a category',
        'exp-desc': v.description.length < 3 ? 'Describe the expense' : ''
    };
    Object.keys(errs).forEach(id => markField($(id), errs[id]));
    return Object.values(errs).some(Boolean) ? null : v;
}
['exp-date', 'exp-amount', 'exp-cat', 'exp-desc'].forEach(id => document.getElementById(id) && document.getElementById(id).addEventListener('input', () => { if ($(id).classList.contains('invalid')) expenseFormCheck(); }));
async function saveExpense() {
    const v = expenseFormCheck(); if (!v) return;
    const btn = $('exp-save'); btn.disabled = true; btn.classList.add('loading');
    try {
        if (fin.editing) await api('/owner/expenses/' + fin.editing.expense_id, { method: 'PUT', body: v });
        else await api('/owner/expenses', { body: v });
        closeModal('modal-expense'); toast(fin.editing ? 'Expense updated' : 'Expense recorded'); await loadFinance();
    } catch (e) { $('exp-err').textContent = e.message; $('exp-err').hidden = false; }
    finally { btn.disabled = false; btn.classList.remove('loading'); }
}
async function viewExpense(id) {
    const e = fin.expenses.find(x => +x.expense_id === +id); if (!e) return;
    fin.viewing = e;
    const f = (l, v) => `<div><span>${l}</span><b>${v}</b></div>`;
    $('ev-title').textContent = 'Expense #' + e.expense_id;
    $('ev-grid').innerHTML = f('DATE PAID', fmtDate(ms(e.expense_date))) + f('AMOUNT', peso(+e.amount) + ' ' + esc(e.currency || 'PHP')) + f('CATEGORY', esc(e.category_name)) +
        f('PROJECT', e.project_id ? esc(window.BW.prjNo(e.project_id) + (e.project_name ? ' · ' + e.project_name : '')) : '—') + f('DESCRIPTION', esc(e.description || '—')) +
        f('PAID BY', esc(e.payment_method || '—')) + f('REFERENCE', esc(e.reference_no || '—')) + f('RECORDED BY', esc(e.recorded_by_name || '—') + (e.created_at ? ' · ' + fmtDate(ms(e.created_at)) : '')) +
        f('STATUS', e.status === 'Void' ? 'Voided' + (e.voided_by_name ? ' by ' + esc(e.voided_by_name) : '') + (e.void_reason ? ': ' + esc(e.void_reason) : '') : 'Active');
    $('ev-edit').hidden = $('ev-void').hidden = e.status === 'Void';
    $('ev-history').innerHTML = '<p class="modal-subtitle">Loading…</p>';
    openModal('modal-expview');
    try {
        const h = await api('/owner/expenses/' + e.expense_id + '/history');
        $('ev-history').innerHTML = h.length ? h.map(x => `<div class="ev-row"><b>${esc(x.action)}</b><span>${esc(x.details || '')}</span><small>${esc(x.changed_by_name || '')} · ${fmtDate(ms(x.created_at))}</small></div>`).join('')
            : '<p class="modal-subtitle">No history recorded (added before tracking started).</p>';
    } catch (err) { $('ev-history').innerHTML = '<p class="modal-subtitle">' + esc(err.message) + '</p>'; }
}
async function voidExpense() {
    const e = fin.viewing; if (!e) return;
    const done = await window.BW.reason({ title: 'Void this expense?', message: `${peso(+e.amount)} · ${e.description || e.category_name}. It stays in the records but no longer counts in the totals.`, danger: true, ok: 'Void expense',
        reasons: ['Duplicate entry', 'Wrong amount', 'Wrong date or category', 'Not a business expense'], onOk: v => api('/owner/expenses/' + e.expense_id + '/void', { body: v }) });
    if (!done) return;
    closeModal('modal-expview'); toast('Expense voided'); loadFinance();
}

/* ===================== Activity ===================== */
function avatar(name) {
    let h = 0; for (const c of name) h = (h * 31 + c.charCodeAt(0)) % 360;
    const svg = `<svg xmlns="http://www.w3.org/2000/svg" width="56" height="56"><rect width="56" height="56" fill="hsl(${h},55%,48%)"/><text x="50%" y="54%" font-family="Arial" font-size="22" font-weight="700" fill="#fff" text-anchor="middle" dominant-baseline="middle">${esc(initials(name))}</text></svg>`;
    return 'data:image/svg+xml;utf8,' + encodeURIComponent(svg);
}
const userCell = (name, sub, extra) => `<div class="user-cell"><div class="avatar-wrap"><img class="user-avatar" src="${avatar(name)}" alt=""></div>
    <div class="user-details"><strong>${esc(name)}${extra || ''}</strong><span>${esc(sub)}</span></div></div>`;

function renderLog() {
    const sel = $('l-admin'), roles = db.accounts.map(a => a.role).sort();
    sel.innerHTML = '<option value="all">All Administrators</option>' + roles.map(r => `<option value="${esc(r)}">${esc(r)}</option>`).join('');
    if (!roles.includes(ui.l.admin)) ui.l.admin = 'all';
    sel.value = ui.l.admin;
    const q = ui.l.search.toLowerCase();
    const list = db.events.filter(e => (ui.l.admin === 'all' || e.user === ui.l.admin) && (!q || (e.desc + ' ' + e.name + ' ' + e.user).toLowerCase().includes(q)));
    $('l-tbody').innerHTML = list.length ? pageSlice(list, ui.l).map(e => {
        const t = fmtTime(e.time);
        return `<tr><td>${userCell(e.name || e.user, e.user)}</td><td>${esc(e.desc)}</td><td><div class="timestamp-cell"><strong>${t.main}</strong><span>${t.sub}</span></div></td></tr>`;
    }).join('') : emptyRow(3, 'No activity matches your search or filter.');
    pager('l-pager', ui.l, list.length, 'ACTIVITIES', renderLog);
}
function renderAccounts() {
    const list = db.accounts, pages = Math.max(1, Math.ceil(list.length / ui.perPage));
    if (ui.a.page > pages) ui.a.page = pages;
    $('a-tbody').innerHTML = pageSlice(list, ui.a).map(a => {
        const t = fmtTime(a.lastActivity), self = a.id === ME;
        return `<tr><td>${userCell(a.name, a.email, self ? '<span class="you-tag">YOU</span>' : '')}</td><td>${esc(a.role)}</td>
            <td><div class="timestamp-cell"><strong>${t.main}</strong><span>${t.sub}</span></div></td>
            <td class="text-right"><button class="icon-btn" data-del="${a.id}" ${self ? 'disabled title="You cannot delete your own account"' : 'title="Delete account"'}><i class="fa-solid fa-trash-can"></i></button></td></tr>`;
    }).join('');
    pager('a-pager', ui.a, list.length, 'ACCOUNTS', renderAccounts);
    TABS.activity.sub = `${db.events.length} logged activities · ${db.accounts.length} administrator accounts`;
    if (ui.tab === 'activity') $('page-sub').textContent = TABS.activity.sub;
}
const validName = v => /^\p{L}+(?:[\s.'-]\p{L}+)*$/u.test(v);
const validEmail = v => /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(v);
const validPass = v => v.length >= 8 && v.length <= 64 && /\d/.test(v) && /[A-Za-z]/.test(v) && !/\s/.test(v);   // 8-64 characters, a letter and a number, no spaces
function nextAdminRole() {
    const n = db.accounts.reduce((m, a) => Math.max(m, parseInt((a.role.match(/(\d+)$/) || [0, 0])[1], 10)), 0) + 1;
    return 'Administrator ' + n;
}
function openAdd() {
    ['add-name', 'add-email', 'add-pass'].forEach(i => $(i).value = '');
    ['fg-name', 'fg-email', 'fg-pass'].forEach(i => $(i).classList.remove('invalid'));
    openModal('modal-add'); setTimeout(() => $('add-name').focus(), 50);
}
function submitAdd() {
    const name = $('add-name').value.trim().replace(/\s+/g, ' '), email = $('add-email').value.trim(), pass = $('add-pass').value;
    const okE = validEmail(email) && email.length <= 100 && !/\.\./.test(email), dup = db.accounts.some(a => a.email.toLowerCase() === email.toLowerCase());
    const okN = validName(name) && name.length >= 2 && name.length <= 60;
    $('fg-name').classList.toggle('invalid', !okN);
    $('name-error').textContent = !name ? 'Please enter a name.' : !validName(name) ? 'Names can contain letters and spaces only.' : 'Name must be 2 to 60 characters.';
    $('email-error').textContent = dup ? 'This email already exists.' : 'Please enter a valid email.';
    $('fg-email').classList.toggle('invalid', !okE || dup);
    $('fg-pass').classList.toggle('invalid', !validPass(pass));
    if (!okN || !okE || dup || !validPass(pass)) return;
    // The server hashes and stores the password (it is never kept in the browser).
    const sp = name.lastIndexOf(' ');
    if (sp < 1) { $('fg-name').classList.add('invalid'); $('name-error').textContent = 'Please enter the first and last name.'; return; }
    const role = nextAdminRole();
    run(() => api('/owner/users', { body: { first_name: name.slice(0, sp), last_name: name.slice(sp + 1), email, password: pass, role: 'admin' } }), `Account added: ${name} (${role})`)
        .then(ok => { if (!ok) return; ui.l = { page: 1, search: '', admin: 'all' }; $('l-search').value = ''; closeModal('modal-add'); });
}
function openDeleteList() {
    const items = db.accounts.filter(a => a.id !== ME);
    $('delete-list').innerHTML = items.length ? items.map(a => `<div class="item-row pick" data-pick="${a.id}"><div class="item-info"><strong>${esc(a.name)}</strong><span>${esc(a.role)} · ${esc(a.email)}</span></div><i class="fa-solid fa-trash-can" style="color:#94a3b8"></i></div>`).join('') : '<div class="list-empty">No other accounts to delete.</div>';
    openModal('modal-delacct');
}
function askDeleteAccount(id) {
    const a = db.accounts.find(x => x.id === id); if (!a) return;
    if (id === ME) return toast('You cannot delete your own account.', 'error');
    closeModal('modal-delacct');
    confirmDelete(`Are you sure you want to permanently delete <strong>${esc(a.name)}</strong> (${esc(a.role)})? This cannot be undone.`, async () => {
        try { await api('/owner/users/' + a.id, { method: 'DELETE' }); }
        catch (e) {
            // accounts with history (quotations, logs) are disabled instead, so the records stay intact
            if (e.status === 409 && /disable/i.test(e.message) && await window.BW.confirm({ title: 'Disable this account instead?', message: e.message + '\n\nDisable this account now? The person will no longer be able to sign in.', ok: 'Disable account', danger: true }))
                return run(() => api('/owner/users/' + a.id + '/status', { body: { status: 'Disabled' } }), `Account disabled: ${a.name}`);
            return toast(e.message, 'error');
        }
        await commit(); toast(`Account deleted: ${a.name}`);
    });
}

/* ===================== Settings ===================== */
const validGmail = v => {
    const m = v.toLowerCase().match(/^([a-z0-9.]+)@gmail\.com$/); if (!m) return false;
    const u = m[1]; return u.length >= 6 && u.length <= 30 && !u.startsWith('.') && !u.endsWith('.') && !u.includes('..');
};
let savedTheme = readJSON(THEME_KEY, 'light'), selectedTheme = savedTheme;
const dirty = new Set();
function setErr(id, msg) { $(id).closest('.st-input').classList.toggle('invalid', !!msg); $(id + 'Err').textContent = msg || ''; }
function paintStatus() {
    const d = dirty.size > 0 || selectedTheme !== savedTheme;
    $('stStatus').classList.toggle('dirty', d);
    $('stStatus').firstElementChild.className = 'fa-solid ' + (d ? 'fa-circle-exclamation' : 'fa-circle-check');
    $('stStatusText').textContent = d ? 'Unsaved changes' : 'All settings up to date';
}
function applyTheme(t) { document.documentElement.setAttribute('data-theme', t); }
function paintTheme() {
    $$('.st-theme').forEach(b => {
        const t = b.dataset.themeOpt;
        b.classList.toggle('selected', t === selectedTheme); b.classList.toggle('is-active', t === savedTheme);
        b.setAttribute('aria-pressed', String(t === selectedTheme));
    });
    paintStatus();
}
function syncProfile() {
    const a = db.accounts.find(x => x.id === ME);
    if (a) { a.name = profile.name; a.email = profile.email; }
    $('top-name').textContent = profile.name;
    setDashSub();
    if (ui.tab === 'dashboard') $('page-sub').textContent = TABS.dashboard.sub;
}
function fillProfile() { $('stFullName').value = profile.name; $('stEmail').value = profile.email; }
function saveProfileField(field) {
    if (field === 'name') {
        const v = $('stFullName').value.trim().replace(/\s+/g, ' ');
        if (!v) return setErr('stFullName', 'Please enter your full name.');
        if (!validName(v)) return setErr('stFullName', 'Full name can contain letters and spaces only.');
        if (v.length > 60) return setErr('stFullName', 'Full name must be 60 characters or fewer.');
        if (v === profile.name) { setErr('stFullName', ''); return paintStatus(); }
        if (v.indexOf(' ') < 1) return setErr('stFullName', 'Please enter your first and last name.');
        profile.name = v;
    } else {
        const v = $('stEmail').value.trim().toLowerCase();
        if (!validGmail(v)) return setErr('stEmail', 'Enter a valid Gmail address (6–30 letters, numbers or periods before @gmail.com).');
        if (v === profile.email) { setErr('stEmail', ''); return paintStatus(); }
        profile.email = v;
    }
    const next = Object.assign({}, profile);
    api('/auth/profile', { body: { full_name: next.name, email: next.email } }).then(async () => {
        fillProfile(); syncProfile(); dirty.delete(field); paintStatus();
        await commit(); toast('Account details updated');
    }).catch(err => setErr(field === 'name' ? 'stFullName' : 'stEmail', err.message));
}
const EYE_ON = '<svg viewBox="0 0 24 24"><path d="M2 12s3.6-7 10-7 10 7 10 7-3.6 7-10 7S2 12 2 12Z"/><circle cx="12" cy="12" r="3"/></svg>';
const EYE_OFF = '<svg viewBox="0 0 24 24"><path d="M3 3l18 18"/><path d="M10.6 10.6a2 2 0 0 0 2.8 2.8"/><path d="M9.9 5.2A10.8 10.8 0 0 1 12 5c6.4 0 10 7 10 7a17 17 0 0 1-3.1 4.1"/><path d="M6.2 6.2C3.5 8 2 12 2 12s3.6 7 10 7c1.2 0 2.3-.2 3.3-.6"/></svg>';
/* Pricing: BeyondWires' markup on supplier prices (used by the admin's quotation builder) */
async function initMarkup() {
    const inp = $('stMarkup'); if (!inp) return;
    const hint = () => { const m = Number(inp.value); if (isFinite(m) && inp.value !== '' && m >= 0 && m <= 300) $('stMarkupHint').textContent = `Example: a ₱3,000 camera from the supplier is quoted at ${peso(3000 * (1 + m / 100))} with ${m}%. Existing quotations do not change.`; };
    inp.addEventListener('input', hint);
    try { inp.value = (await api('/owner/settings/markup')).markup_percent; hint(); } catch (e) { $('stMarkupErr').textContent = e.message; }
    $('stMarkupForm').addEventListener('submit', async () => {
        if (!window.BW.checkField(inp)) return;
        const btn = $('stMarkupSave'); btn.disabled = true; btn.classList.add('loading');
        try { const r = await api('/owner/settings/markup', { body: { markup_percent: Number(inp.value) } }); inp.value = r.markup_percent; hint(); toast('Markup saved: ' + r.markup_percent + '%'); }
        catch (e) { $('stMarkupErr').textContent = e.message; }
        finally { btn.disabled = false; btn.classList.remove('loading'); }
    });
}
function initSettings() {
    initMarkup();
    [['stFullName', 60], ['stEmail', 100], ['stCurPw', 64], ['stNewPw', 64], ['stConfPw', 64], ['add-name', 60], ['add-email', 100], ['add-pass', 64]].forEach(([id, n]) => { if ($(id)) $(id).maxLength = n; });
    { const pe = $('fg-pass') && $('fg-pass').querySelector('.form-error'); if (pe) pe.textContent = 'Use 8 to 64 characters with at least one letter and one number (no spaces).'; }
    fillProfile(); applyTheme(savedTheme); paintTheme();
    $$('#tab-settings .st-input input').forEach(inp => inp.addEventListener('input', () => {
        setErr(inp.id, '');
        dirty.add(inp.id === 'stFullName' ? 'name' : inp.id === 'stEmail' ? 'email' : 'pw'); paintStatus();
    }));
    ['stFullName', 'stEmail'].forEach(id => {
        const f = id === 'stFullName' ? 'name' : 'email';
        $(id).addEventListener('change', () => saveProfileField(f));
        $(id).addEventListener('keydown', e => { if (e.key === 'Enter') { e.preventDefault(); $(id).blur(); } });
    });
    $$('.st-theme').forEach(b => b.addEventListener('click', () => { selectedTheme = b.dataset.themeOpt; paintTheme(); }));
    $('stSaveTheme').addEventListener('click', () => {
        savedTheme = selectedTheme; writeJSON(THEME_KEY, savedTheme); applyTheme(savedTheme); paintTheme();
        toast(`${savedTheme === 'dark' ? 'Dark' : 'Light'} mode applied`);
    });
    $$('.st-eye').forEach(btn => {
        btn.innerHTML = EYE_ON;
        btn.addEventListener('click', () => {
            const input = $(btn.dataset.target), reveal = input.type === 'password';
            input.type = reveal ? 'text' : 'password'; btn.innerHTML = reveal ? EYE_OFF : EYE_ON;
            btn.setAttribute('aria-label', reveal ? 'Hide password' : 'Show password');
        });
    });
    $('stPwForm').addEventListener('submit', e => {
        e.preventDefault();
        const cur = $('stCurPw').value, nw = $('stNewPw').value, cf = $('stConfPw').value;
        let ok = true;
        if (!cur) { setErr('stCurPw', 'Please enter your current password.'); ok = false; }
        if (!validPass(nw)) { setErr('stNewPw', 'Use 8 to 64 characters with at least one letter and one number, and no spaces.'); ok = false; }
        else if (nw === cur) { setErr('stNewPw', 'New password must be different from the current one.'); ok = false; }
        if (!cf) { setErr('stConfPw', 'Please confirm your new password.'); ok = false; }
        else if (cf !== nw) { setErr('stConfPw', 'Passwords do not match.'); ok = false; }
        if (!ok) return;
        api('/auth/password', { body: { current_password: cur, new_password: nw, confirm_password: cf } }).then(async () => {
            $('stPwForm').reset();
            $$('.st-eye').forEach(b => { $(b.dataset.target).type = 'password'; b.innerHTML = EYE_ON; });
            dirty.delete('pw'); paintStatus();
            await commit(); toast('Password changed successfully');
        }).catch(err => setErr(err.status === 403 ? 'stCurPw' : 'stNewPw', err.message));
    });
}

/* ===================== Shared chrome ===================== */
/* Notifications come from the server. Clicking one opens the right place and marks it as read. */
let bell = null;
function renderNotifs() { if (bell) bell.load(); }
async function openLink(link) {
    const [kind, id] = String(link).split(':');
    if (kind === 'quotation') {
        if (!db.quotes.some(q => q.dbId === +id)) await commit();
        const x = db.quotes.find(q => q.dbId === +id);
        showTab('quotations');
        if (x) { ui.q = { page: 1, search: x.id, status: x.status }; $('q-search').value = x.id; renderQuotes(); viewQuote(x.id); }
        return;
    }
    showTab(kind === 'project' ? 'projects' : 'dashboard');
}
function renderAll() { renderKPIs(); renderStats(); renderBreakdown(); renderEvents(); renderNotifs(); renderQuotes(); renderProjectsTab(); renderLog(); renderAccounts(); renderFinance(); }
function closeDropdowns() { $$('.dropdown-menu').forEach(m => m.classList.remove('show')); }
function openModal(id) { closeDropdowns(); $(id).classList.add('active'); }
function closeModal(id) { $(id).classList.remove('active'); }
function confirmDelete(html, fn, title, yes) {
    ui.confirm = fn; $('confirm-text').innerHTML = html;
    $('modal-confirm').querySelector('.modal-header h3').textContent = title || 'Confirm Delete';
    $('confirm-yes').textContent = yes || 'Yes, Delete';
    openModal('modal-confirm');
}

function showTab(name) {
    if (!TABS[name]) name = 'dashboard';
    ui.tab = name;
    $$('.tab-panel').forEach(p => p.classList.toggle('active', p.id === 'tab-' + name));
    $$('.sidebar .nav-item').forEach(a => a.classList.toggle('active', a.dataset.tab === name));
    $('page-crumb').textContent = TABS[name].crumb;
    $('page-title').textContent = TABS[name].title;
    $('page-sub').textContent = TABS[name].sub;
    if (location.hash !== '#' + name) history.replaceState(null, '', '#' + name);
    closeDropdowns(); window.scrollTo(0, 0);
    if (name === 'financial') initFinance();
}
function setCollapsed(c) {
    $('app').classList.toggle('collapsed', c);
    $('sidebar-toggle').innerHTML = `<i class="fa-solid ${c ? 'fa-angles-right' : 'fa-angles-left'}"></i>`;
    $('sidebar-toggle').title = c ? 'Expand sidebar' : 'Minimize sidebar';
    $('sidebar-toggle').setAttribute('aria-label', $('sidebar-toggle').title);
    try { localStorage.setItem(SIDEBAR_KEY, c ? '1' : '0'); } catch (e) {}
    finCharts.forEach(ch => setTimeout(() => ch.resize(), 300));
}
const syncRange = () => $$('#range-tabs .seg-btn').forEach(x => x.classList.toggle('active', parseInt(x.dataset.range, 10) === ui.range));

/* ===================== Wiring ===================== */
async function init() {
    const user = await window.BW.guard('superadmin');
    ME = user.id; profile = { name: user.name, email: user.email };
    setDashSub();
    try { await load(); }
    catch (e) { document.body.innerHTML = '<div style="font:14px sans-serif;padding:40px;max-width:640px;margin:auto"><h2>Cannot load the dashboard</h2><p>' + esc(e.message) + '</p></div>'; return; }
    loadSettings();
    syncProfile();

    $('sidebar').addEventListener('click', e => { const a = e.target.closest('[data-tab]'); if (a) { e.preventDefault(); showTab(a.dataset.tab); } });
    window.addEventListener('hashchange', () => showTab(location.hash.slice(1)));
    $('sidebar-toggle').onclick = () => setCollapsed(!$('app').classList.contains('collapsed'));
    let startCollapsed = false; try { startCollapsed = localStorage.getItem(SIDEBAR_KEY) === '1'; } catch (e) {}
    setCollapsed(startCollapsed);

    // header dropdowns
    $$('[data-dd]').forEach(b => b.addEventListener('click', e => {
        e.stopPropagation();
        const el = $(b.dataset.dd), open = el.classList.contains('show');
        closeDropdowns(); if (!open) { el.classList.add('show'); renderNotifs(); }
    }));
    $$('.dropdown-menu[data-keep]').forEach(m => m.addEventListener('click', e => e.stopPropagation()));
    document.addEventListener('click', closeDropdowns);
    bell = window.BW.Notifications({ list: 'notif-list', dot: 'notif-dot', markAll: 'mark-read', close: closeDropdowns, toast: m => toast(m), open: openLink });
    $('my-profile').onclick = () => showTab('settings');
    $('logout').onclick = () => { closeDropdowns(); toast('Logged out successfully.'); window.BW.logout(LANDING); };

    // modals
    $$('[data-close]').forEach(b => b.addEventListener('click', () => closeModal(b.dataset.close)));
    $$('.modal-overlay').forEach(o => o.addEventListener('click', e => { if (e.target === o) o.classList.remove('active'); }));
    document.addEventListener('keydown', e => { if (e.key === 'Escape') { $$('.modal-overlay.active').forEach(o => o.classList.remove('active')); closeDropdowns(); } });
    $('confirm-yes').onclick = () => { closeModal('modal-confirm'); const f = ui.confirm; ui.confirm = null; if (f) f(); };

    // dashboard
    const press = (id, fn) => { $(id).addEventListener('click', fn); $(id).addEventListener('keydown', e => { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); fn(); } }); };
    press('kpi-projects', () => showTab('projects'));
    press('kpi-quotes', () => showTab('quotations'));
    press('kpi-revenue', () => { renderRevenueModal(); openModal('modal-revenue'); });
    $('view-activity').onclick = e => { e.preventDefault(); showTab('activity'); };
    $('metric-tabs').addEventListener('click', e => {
        const b = e.target.closest('[data-metric]'); if (!b) return;
        ui.metric = b.dataset.metric; $$('#metric-tabs .seg-btn').forEach(x => x.classList.toggle('active', x === b)); renderStats();
    });
    $('range-tabs').addEventListener('click', e => { const b = e.target.closest('[data-range]'); if (b) { ui.range = parseInt(b.dataset.range, 10); syncRange(); renderStats(); } });
    syncRange();
    $('chart-svg').addEventListener('mousemove', chartHover);
    $('chart-svg').addEventListener('mouseleave', chartLeave);
    $('chart-svg').addEventListener('touchstart', e => chartHover(e.touches[0]), { passive: true });
    $('chart-svg').addEventListener('touchmove', e => chartHover(e.touches[0]), { passive: true });


    // quotations
    $('q-search').addEventListener('input', e => { ui.q.search = e.target.value; ui.q.page = 1; renderQuotes(); });
    $('q-tabs').addEventListener('click', e => { const b = e.target.closest('[data-qs]'); if (b) { ui.q.status = b.dataset.qs; ui.q.page = 1; renderQuotes(); } });
    $('q-tbody').addEventListener('click', e => {
        const b = e.target.closest('[data-qact]'); if (!b || b.disabled) return;
        ({ view: viewQuote, approve: approveQuote, revise: openRevision, reject: openReject, send: sendQuote })[b.dataset.qact](b.dataset.id);
    });
    $$('[data-panel-close]').forEach(b => b.addEventListener('click', closePanels));
    $('rev-send').onclick = submitRevision;
    $('rev-items').addEventListener('input', e => {
        const f = e.target.dataset.rv; if (!f || !ui.draft) return;
        const v = numVal(e.target);
        ui.draft.items[+e.target.dataset.i][f] = v;
        markField(e.target, revIssue(f, v)); updateRevTotals();
    });
    $('rev-transport').addEventListener('input', e => {
        if (!ui.draft) return;
        const v = e.target.value.trim() === '' ? 0 : Number(e.target.value);
        ui.draft.transport = v; markField(e.target, revIssue('transport', v)); updateRevTotals();
    });
    $('rev-validity').addEventListener('input', e => markField(e.target, revIssue('validity', numVal(e.target))));
    $('qv-send').onclick = () => { const id = $('qv-send').dataset.id; closeModal('modal-viewquote'); sendQuote(id); };
    $('rej-send').onclick = submitRejection;

    // projects
    $('p-search').addEventListener('input', e => { ui.p.search = e.target.value; ui.p.page = 1; renderProjectsTab(); });
    $('p-status').addEventListener('change', e => { ui.p.status = e.target.value; ui.p.page = 1; renderProjectsTab(); });
    /* the From date can never be after the To date */
    $('p-from').addEventListener('change', e => { if (e.target.value && ui.p.to && e.target.value > ui.p.to) { e.target.value = ui.p.from; return toast('The From date cannot be after the To date', 'error'); } ui.p.from = e.target.value; ui.p.page = 1; renderProjectsTab(); });
    $('p-to').addEventListener('change', e => { if (e.target.value && ui.p.from && e.target.value < ui.p.from) { e.target.value = ui.p.to; return toast('The To date cannot be before the From date', 'error'); } ui.p.to = e.target.value; ui.p.page = 1; renderProjectsTab(); });
    $('p-reset').onclick = () => {
        ui.p = { page: 1, search: '', status: 'all', from: '', to: '' };
        $('p-search').value = ''; $('p-status').value = 'all'; $('p-from').value = ''; $('p-to').value = '';
        renderProjectsTab(); toast('Filters reset');
    };

    // financial
    $('fin-period').addEventListener('click', e => {
        const b = e.target.closest('[data-period]'); if (!b) return;
        fin.period = b.dataset.period; const [f, t] = periodRange(fin.period); $('fin-from').value = f; $('fin-to').value = t; loadFinance();
    });
    ['fin-from', 'fin-to'].forEach(id => $(id).addEventListener('change', () => { fin.period = ''; loadFinance(); }));
    ['fin-project', 'fin-category', 'fin-exp-status'].forEach(id => $(id).addEventListener('change', loadFinance));
    document.addEventListener('click', e => { const b = e.target.closest('[data-export]'); if (!b) return; closeDropdowns(); const [k, f] = b.dataset.export.split(':'); runExport(k, f); });
    $('fin-csv').onclick = () => {
        if (!fin.data) return;
        downloadCSV('monthly-breakdown.csv', [['Month', 'Cash in', 'VAT', 'Revenue (excl. VAT)', 'Expenses', 'Net profit', 'Net cash']].concat(fin.data.months.map(m => [monthLabel(m.month), m.cash_in, m.vat, m.revenue, m.cash_out, m.net_profit, m.net_cash])));
        toast('Monthly breakdown CSV downloaded');
    };
    $('fin-exp-add').onclick = () => openExpenseForm(null);
    $('exp-save').onclick = saveExpense;
    $('fin-exp-tbody').addEventListener('click', e => { const b = e.target.closest('[data-exp]'); if (b) viewExpense(b.dataset.exp); });
    $('ev-edit').onclick = () => { const e = fin.viewing; closeModal('modal-expview'); openExpenseForm(e); };
    $('ev-void').onclick = voidExpense;

    // activity
    $('act-add').onclick = openAdd;
    $('act-del').onclick = openDeleteList;
    $('confirm-add').onclick = submitAdd;
    ['add-name', 'add-email', 'add-pass'].forEach(i => $(i).addEventListener('keydown', e => { if (e.key === 'Enter') submitAdd(); }));
    $('l-search').addEventListener('input', e => { ui.l.search = e.target.value; ui.l.page = 1; renderLog(); });
    $('l-admin').addEventListener('change', e => { ui.l.admin = e.target.value; ui.l.page = 1; renderLog(); });
    $('l-reset').onclick = () => { ui.l = { page: 1, search: '', admin: 'all' }; $('l-search').value = ''; renderLog(); toast('Filters reset'); };
    $('a-tbody').addEventListener('click', e => { const b = e.target.closest('[data-del]'); if (b && !b.disabled) askDeleteAccount(+b.dataset.del); });
    $('delete-list').addEventListener('click', e => { const it = e.target.closest('[data-pick]'); if (it) askDeleteAccount(+it.dataset.pick); });

    initSettings();
    renderAll();
    showTab(location.hash.slice(1));
}

if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init); else init();
})();

/* ===== Shared: date limits (2019-2028, same as the customer page) + mobile drawer ===== */
(function () {
  'use strict';
  const MIN = '2019-01-01', MAX = '2028-12-31', MN = 2019, MX = 2028;
  const MON = ['January','February','March','April','May','June','July','August','September','October','November','December'];
  function toast(msg) {
    const t = document.createElement('div'); t.className = 'bw-toast'; t.textContent = msg;
    document.body.appendChild(t); setTimeout(() => t.remove(), 2800);
  }
  const limitInputs = () => document.querySelectorAll('input[type=date]').forEach(i => { i.min = MIN; i.max = MAX; });
  limitInputs();
  document.addEventListener('change', e => {
    const i = e.target;
    if (i.type === 'date' && i.value && (i.value < MIN || i.value > MAX)) { i.value = ''; toast('Please choose a date between 2019 and 2028.'); }
  }, true);

  const parse = t => { const m = /([A-Za-z]+)\s+(\d{4})/.exec(t || ''); const i = m ? MON.indexOf(m[1]) : -1; return i < 0 ? null : { m: i, y: +m[2] }; };
  const lock = (b, on) => {
    if (!b) return;
    if (on) { b.dataset.bwLock = 1; b.disabled = true; }
    else if (b.dataset.bwLock) { delete b.dataset.bwLock; b.disabled = false; }
  };
  function syncCals() {
    document.querySelectorAll('.si-cal-head,.cp-head').forEach(h => {
      const p = parse((h.querySelector('b') || {}).textContent); if (!p) return;
      const k = p.y * 12 + p.m;
      lock(h.firstElementChild, k <= MN * 12);
      lock(h.lastElementChild, k >= MX * 12 + 11);
    });
  }
  let raf; new MutationObserver(() => { cancelAnimationFrame(raf); raf = requestAnimationFrame(() => { limitInputs(); syncCals(); }); })
    .observe(document.body, { subtree: true, childList: true, characterData: true });
  syncCals();

  const mq = matchMedia('(max-width: 900px)');
  const bd = document.createElement('div'); bd.className = 'bw-backdrop'; document.body.appendChild(bd);
  const closeNav = () => document.body.classList.remove('nav-open');
  document.addEventListener('click', e => {
    if (mq.matches && e.target.closest('.sidebar-toggle')) {
      e.stopImmediatePropagation(); e.preventDefault(); document.body.classList.toggle('nav-open'); return;
    }
    if (e.target === bd || (mq.matches && e.target.closest('.sidebar .nav-item'))) closeNav();
  }, true);
  document.addEventListener('keydown', e => { if (e.key === 'Escape') closeNav(); });
  mq.addEventListener('change', closeNav);
})();