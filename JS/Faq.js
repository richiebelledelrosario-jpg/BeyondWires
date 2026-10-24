/* ==========================================================
   BeyondWires FAQ  |  JS/Faq.js
   Preset questions and answers (no AI). The landing page shows the 5 most-asked ones;
   the floating Help button (landing page and customer portal) opens the FAQ assistant with all of them.
   The answers follow the system's own rules (api/*.php, config.php) and the
   package details on the landing page. Edit the text here to change both pages.
   ========================================================== */
(function () {
    'use strict';

    const CATEGORIES = [
        { id: 'services',  label: 'Products & Services', fa: 'fa-video',            mi: 'videocam' },
        { id: 'packages',  label: 'Packages',            fa: 'fa-box-open',         mi: 'inventory_2' },
        { id: 'inquiries', label: 'Inquiries',           fa: 'fa-inbox',            mi: 'inbox' },
        { id: 'visits',    label: 'Site Inspections',    fa: 'fa-location-dot',     mi: 'location_on' },
        { id: 'quotes',    label: 'Quotations',          fa: 'fa-file-invoice',     mi: 'request_quote' },
        { id: 'payments',  label: 'Payments',            fa: 'fa-credit-card',      mi: 'payments' },
        { id: 'projects',  label: 'Project Status',      fa: 'fa-list-check',       mi: 'checklist' },
        { id: 'warranty',  label: 'Warranties',          fa: 'fa-shield-halved',    mi: 'verified_user' },
        { id: 'accounts',  label: 'Accounts',            fa: 'fa-user',             mi: 'person' },
        { id: 'resched',   label: 'Rescheduling',        fa: 'fa-calendar-days',    mi: 'event' }
    ];

    const ITEMS = [
        { cat: 'services', top: true, q: 'What do you install?',
          a: 'Our main work is CCTV: we supply cameras and recorders, install them with open wiring, molding or concealed rough-ins, and set up mobile viewing so you can watch your cameras from your phone. We also install access control and biometrics, smart door locks, intercoms and solar-powered lighting.' },
        { cat: 'services', q: 'Do you offer services after installation?',
          a: 'Yes. We retrieve and review recorded CCTV footage on request, for example for an investigation.' },
        { cat: 'services', top: true, q: 'Which areas do you serve?',
          a: 'We are based in Tala, Caloocan City and serve homes and businesses across mainland Luzon. The address list in the inquiry form only shows the places we cover.' },

        { cat: 'packages', q: 'What packages are available?',
          a: 'We offer 2-, 3- and 4-channel CCTV packages. Each one has cameras with built-in mic, a DVR, a 500GB hard drive and all accessories, with free installation. See the Packages section on the home page for the details of each package.' },
        { cat: 'packages', q: 'Can I add other items to a package?',
          a: 'Yes. When you choose "Package" in the inquiry form, you can also add extra products to the same inquiry.' },

        { cat: 'inquiries', top: true, q: 'How do I send an inquiry?',
          a: 'Log in, open My Inquiries and click New Inquiry. Enter the installation address, the type of place (residential or commercial) and what you are inquiring about. Then either ask for a site visit and pick a date and time, or choose the items you need and your budget range.' },
        { cat: 'inquiries', q: 'How many inquiries can I send?',
          a: 'You can add up to 5 inquiries in one submission (for example, one per address), and up to 10 inquiries per account.' },
        { cat: 'inquiries', top: true, q: 'How long until my inquiry is reviewed?',
          a: 'We review inquiries within 3 business days. You get a notification and an email once it is reviewed.' },
        { cat: 'inquiries', q: 'BeyondWires asked me to change my inquiry. What do I do?',
          a: 'Open the inquiry in My Inquiries and read the reason. Click Update my inquiry, change what was asked (for example the items or your budget) and send it again. It goes back to our team for review. You can also cancel it instead.' },
        { cat: 'inquiries', q: 'Can I cancel an inquiry?',
          a: 'Yes, until a quotation is sent to you. Open the inquiry in My Inquiries and click Cancel inquiry, then choose a reason. Any site visit you booked is released.' },

        { cat: 'visits', q: 'How do I request a site inspection?',
          a: 'In the inquiry form, answer "Yes" to "Would you like a site visit?" and pick one of the open dates and time slots. You can book from tomorrow up to 120 days ahead. The site visit is free.' },
        { cat: 'visits', q: 'How is the schedule confirmed?',
          a: 'We confirm your chosen time. If that time does not work for our team, we propose a new one with the reason, and you accept it or ask for another time. It is final only after you accept.' },
        { cat: 'visits', q: 'What happens after the site inspection?',
          a: 'We prepare your quotation based on what we saw on site. You will be notified when it is ready.' },

        { cat: 'quotes', q: 'How is my quotation prepared?',
          a: 'Our team prices the items, any extra expenses and the labor for your project. Management reviews it, and then it is sent to the Quotations page of your account and to your email.' },
        { cat: 'quotes', q: 'Does the price include VAT?',
          a: 'Yes. The quotation shows the 12% VAT on the items, extra expenses and labor, and the total you pay.' },
        { cat: 'quotes', q: 'How long is a quotation valid?',
          a: 'Up to 30 days from the date it is issued. The validity date is printed on the quotation.' },
        { cat: 'quotes', q: 'Why is my quotation higher than my budget?',
          a: 'The total depends on the items, extra expenses and labor your project needs. If it is above your budget, we add a note on the quotation with our recommendation, for example a smaller package that fits.' },
        { cat: 'quotes', q: 'What if I do not agree with the quotation?',
          a: 'Open it and choose Decline. You can ask for a revised quotation or tell us you are no longer interested. Either way, choose a reason so we know what to change.' },

        { cat: 'payments', top: true, q: 'How can I pay?',
          a: 'Online through GCash, UnionBank or MariBank (scan the QR code shown in your account), or over the counter. When you approve the quotation you choose half upon quotation or full upon quotation; for residential projects you can also choose full payment after installation.' },
        { cat: 'payments', q: 'How do I send my proof of payment?',
          a: 'Upload a screenshot or photo of your payment (JPG, PNG, WEBP or PDF, up to 5 MB) with the reference number. We check it and issue an acknowledgement receipt in your account.' },
        { cat: 'payments', q: 'When is the final payment due?',
          a: 'If you chose half upon quotation, the other half is due when the installation is completed. If you chose full payment after installation (residential only), the full amount is due then. You will get a notification when it is due.' },
        { cat: 'payments', q: 'What if my proof is rejected?',
          a: 'You will see the reason, for example an unclear screenshot or an amount that does not match. Upload a new proof for the same payment.' },

        { cat: 'projects', q: 'How do I check my project status?',
          a: 'Open My Projects. Each project shows its current step, from payment to installation to completion.' },
        { cat: 'projects', q: 'When is my project marked complete?',
          a: 'When the installation is done, everything is paid and we have sent your installation certificate. You then get one notification and email listing all your documents.' },
        { cat: 'projects', q: 'Where are my documents?',
          a: 'In Documents you can view and download your quotation, receipts, Memorandum of Agreement, job order and installation certificate as PDF.' },

        { cat: 'warranty', q: 'Is there a warranty?',
          a: 'Our CCTV packages come with a 1-year product warranty and a 90-day service warranty. For other items, ask us about the warranty before you approve your quotation.' },
        { cat: 'warranty', q: 'How do I claim my warranty?',
          a: 'Contact us: call or text +63 975 203 7668 or +63 945 329 6845, email beyondwires4demo@gmail.com, or message us on our Facebook page (BeyondWires CCTV). You can also find our contacts under Contact Us on the home page, or in Settings > Contacts in your account. Tell us your name, your project ID (for example PRJ-001) or quotation number, and what is wrong. A photo or video of the problem helps. We then schedule a check of your system.' },
        { cat: 'warranty', q: 'What does the warranty cover?',
          a: 'The 1-year product warranty covers factory defects in the devices we supplied, such as cameras, recorders and hard drives. The 90-day service warranty covers our installation work, for example a loose connection or wiring we installed that stops working.' },
        { cat: 'warranty', q: 'What is not covered by the warranty?',
          a: 'Damage from accidents, lightning or power surges, water or fire, and problems caused by repairs, moving or changes done by someone other than BeyondWires. If you are not sure, contact us and we will check.' },
        { cat: 'warranty', q: 'When does my warranty start?',
          a: 'On the day your installation is completed. That date is on your installation certificate in Documents.' },
        { cat: 'warranty', q: 'What do I need for a warranty claim?',
          a: 'Your acknowledgement receipt and installation certificate. Both are in Documents in your account, so you can view or download them anytime.' },

        { cat: 'accounts', q: 'How do I create an account?',
          a: 'Click Create Account and enter your name, birthday, gender, Gmail address and a password (at least 8 characters with a number). We email you a 6-digit code to activate the account. You must be at least 18 years old.' },
        { cat: 'accounts', q: 'I forgot my password. What should I do?',
          a: 'Click "Forgot password?" on the Log In form and enter your email or recovery email. The reset link works once and expires in 30 minutes.' },
        { cat: 'accounts', q: 'Can I change my details?',
          a: 'Yes. Open Settings to update your name, email, contact number, birthday and gender, your password, and a recovery email. Commercial clients can also add a contact person there.' },
        { cat: 'accounts', q: 'Why was I logged out or locked out?',
          a: 'For your security you are logged out after 30 minutes without activity, and 5 wrong passwords lock the account for 5 minutes.' },

        { cat: 'resched', q: 'How do I change my schedule?',
          a: 'On your Dashboard or in the inquiry details, click Change schedule, pick another open date and time, and give the reason. We confirm the new time.' },
        { cat: 'resched', q: 'BeyondWires proposed a new time. What do I do?',
          a: 'Open the inquiry or your Dashboard. Click Accept this time to confirm it, or Ask for another time to pick a different slot.' }
    ];

    const NO_MATCH = 'We could not find an answer for that. Send us an inquiry, or call or text +63 975 203 7668 or +63 945 329 6845, email beyondwires4demo@gmail.com, or message us on our Facebook page (BeyondWires CCTV), and our team will help you.';
    const esc = s => String(s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
    const match = (it, text) => !text || (it.q + ' ' + it.a).toLowerCase().includes(text.toLowerCase());

    /** Category chips + search box (shared by both layouts). iconKind: 'mi' (Material Icons) or 'fa' (Font Awesome). */
    function toolbar(iconKind, id) {
        const icon = c => iconKind === 'mi' ? '<span class="material-icons-round" aria-hidden="true">' + c.mi + '</span>' : '<i class="fa-solid ' + c.fa + '" aria-hidden="true"></i>';
        return '<div class="bwfaq-tools"><label class="bwfaq-search"><span class="bwfaq-sr">Search questions</span>' +
            '<input type="search" id="' + id + 'Search" placeholder="Search questions..." autocomplete="off"></label>' +
            '<div class="bwfaq-cats" role="group" aria-label="Categories"><button type="button" class="bwfaq-cat active" data-cat="all" aria-pressed="true">All</button>' +
            CATEGORIES.map(c => '<button type="button" class="bwfaq-cat" data-cat="' + c.id + '" aria-pressed="false">' + icon(c) + esc(c.label) + '</button>').join('') + '</div></div>';
    }
    function wire(host, render) {
        const st = { cat: 'all', text: '' };
        host.addEventListener('click', e => {
            const b = e.target.closest('.bwfaq-cat'); if (!b) return;
            st.cat = b.dataset.cat;
            host.querySelectorAll('.bwfaq-cat').forEach(x => { x.classList.toggle('active', x === b); x.setAttribute('aria-pressed', String(x === b)); });
            render(st);
        });
        host.querySelector('input[type="search"]').addEventListener('input', e => { st.text = e.target.value.trim(); render(st); });
        render(st);
    }
    const listFor = st => ITEMS.filter(it => (st.cat === 'all' || it.cat === st.cat) && match(it, st.text));

    /** Landing page: the 5 most-asked questions in the existing accordion (one answer open at a time). */
    function top(list) {
        const rows = ITEMS.filter(it => it.top);
        list.innerHTML = rows.map((it, i) => '<li class="faq-card"><h3 class="faq-card__heading">' +
            '<button class="faq-toggle" type="button" aria-expanded="false" aria-controls="faqPanel' + i + '" id="faqBtn' + i + '">' +
            '<span class="faq-toggle__num" aria-hidden="true">' + String(i + 1).padStart(2, '0') + '</span><span class="faq-toggle__text">' + esc(it.q) + '</span>' +
            '<span class="faq-toggle__icon material-icons-round" aria-hidden="true">expand_more</span></button></h3>' +
            '<div class="faq-panel" id="faqPanel' + i + '" role="region" aria-labelledby="faqBtn' + i + '"><div class="faq-panel__inner"><p>' + esc(it.a) + '</p></div></div></li>').join('');
    }

    /** FAQ assistant (the floating Help button on the landing page and in the customer portal): pick a question and its preset answer
        appears in the conversation. Every answer is written in this file; nothing is generated. */
    function chat(host, iconKind) {
        host.innerHTML = '<div class="bwfaq-log" aria-live="polite"><div class="bwfaq-msg bot">Hi! I can answer common questions about BeyondWires. Pick a question below, choose a category, or search.</div></div>' +
            '<div class="bwfaq-pick">' + toolbar(iconKind || 'fa', 'faqC' + Math.random().toString(36).slice(2, 6)) + '<div class="bwfaq-qs" role="list"></div></div>';
        const log = host.querySelector('.bwfaq-log'), qs = host.querySelector('.bwfaq-qs');
        const say = (cls, html) => { log.insertAdjacentHTML('beforeend', '<div class="bwfaq-msg ' + cls + '">' + html + '</div>'); log.scrollTop = log.scrollHeight; };
        qs.addEventListener('click', e => {
            const b = e.target.closest('.bwfaq-chip'); if (!b) return;
            const it = ITEMS[+b.dataset.i], c = CATEGORIES.find(x => x.id === it.cat);
            say('me', esc(it.q));
            say('bot', '<small>' + esc(c.label) + '</small>' + esc(it.a));
        });
        wire(host, st => {
            const rows = listFor(st);
            qs.innerHTML = rows.length ? rows.map(it => '<button type="button" class="bwfaq-chip" role="listitem" data-i="' + ITEMS.indexOf(it) + '">' + esc(it.q) + '</button>').join('')
                : '<p class="bwfaq-empty">' + esc(NO_MATCH) + '</p>';
        });
    }

    window.BWFaq = { CATEGORIES, ITEMS, top, chat };
})();
