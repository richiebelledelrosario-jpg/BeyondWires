<?php
/* ============ a. Quotation approval ============ */
route('GET', '/owner/quotations', ['superadmin'], function () {
    $st = $_GET['status'] ?? 'Pending Superadmin';
    out(all('SELECT q.quotation_id,q.quotation_no,q.total_amount,q.status,q.date_created,q.expiry_date,q.superadmin_comment,q.project_title,q.project_id, CONCAT(u.first_name," ",u.last_name) customer,
                    (SELECT MAX(e.created_at) FROM quotation_events e WHERE e.quotation_id=q.quotation_id AND e.event LIKE "Approved by superadmin%") sent_at
             FROM quotations q JOIN customers c USING(customer_id) JOIN users u ON u.user_id=c.user_id' . ($st !== 'all' ? ' WHERE q.status=?' : '') . ' ORDER BY q.quotation_id DESC LIMIT 300', $st !== 'all' ? [$st] : []));
});
/* a.2.2 owner can edit the quotation while it is pending (items, charges, validity, notes). The admin's labor lines are kept. */
route('PUT', '/owner/quotations/{id}', ['superadmin'], function ($u, $id) {
    $in = input();
    $q = one('SELECT * FROM quotations WHERE quotation_id=?', [$id]);
    if (!$q) fail('Quotation not found.', 404);
    if ($q['status'] !== 'Pending Superadmin') fail('Only quotations awaiting your approval can be edited.', 409);
    foreach ((array)($in['items'] ?? []) as $it) {
        $qty = $it['quantity'] ?? 0;
        if (!is_numeric($qty) || (int)$qty != $qty || $qty < 1 || $qty > 100) fail('Quantity must be a whole number from 1 to 100.');
        if (!is_numeric($it['unit_price'] ?? null) || $it['unit_price'] < 1) fail('Unit price must be at least PHP 1.');
    }
    $labor = all('SELECT role, workers, days FROM quotation_labor WHERE quotation_id=?', [$id]);
    [$lines, $ch, $sub, $ct, $lab, $lt, $vat] = quote_calc((array)($in['items'] ?? []), (array)($in['charges'] ?? []), $labor, !$labor);
    $expiry = $q['expiry_date'];
    if (isset($in['validity_days'])) {   // 1-30 days from the quotation date (from today if that has already passed)
        $vd = $in['validity_days'];
        if (!is_numeric($vd) || (int)$vd != $vd || $vd < 1 || $vd > 30) fail('Validity must be 1 to 30 days.');
        $expiry = date('Y-m-d', strtotime(substr($q['date_created'], 0, 10) . " +$vd days"));
        if ($expiry <= date('Y-m-d')) $expiry = date('Y-m-d', strtotime("+$vd days"));
    } elseif (isset($in['expiry_date'])) $expiry = quote_expiry($in['expiry_date']);
    tx(function () use ($id, $q, $lines, $ch, $sub, $ct, $lab, $lt, $vat, $in, $u, $expiry) {
        q('UPDATE quotations SET subtotal=?,other_charges_total=?,labor_total=?,vat_amount=?,total_amount=?,notes=?,expiry_date=?,pdf_path=NULL WHERE quotation_id=?',
          [$sub, $ct, $lt, $vat, round($sub + $ct + $lt + $vat, 2), array_key_exists('notes', $in) ? (s($in['notes'], 2000) ?: null) : $q['notes'], $expiry, $id]);
        quote_write($id, $lines, $ch);
        quote_event($id, 'Edited by superadmin');
        q('INSERT INTO quotation_revisions(quotation_id,adjusted_amount,revised_validity,scope_notes,revised_by) VALUES(?,?,?,?,?)', [$id, $sub + $ct, $q['expiry_date'], 'Edited by owner', $u['id']]);
    });
    audit('QUOTATION_EDITED_OWNER', "#$id");
    out(quote_detail($id));
});
/* a.1 approve -> goes straight to the customer, admin is notified too */
route('POST', '/owner/quotations/{id}/approve', ['superadmin'], function ($u, $id) {
    $q = one('SELECT * FROM quotations WHERE quotation_id=?', [$id]);
    if (!$q) fail('Quotation not found.', 404);
    if ($q['status'] !== 'Pending Superadmin') fail('This quotation is not awaiting approval.', 409);
    q('UPDATE quotations SET status="Sent to Customer", superadmin_comment=NULL WHERE quotation_id=?', [$id]);
    quote_event($id, 'Approved by superadmin. Sent to customer');
    publish_quote_doc($id);
    notify_customer((int)$q['customer_id'], 'New quotation', "Quotation {$q['quotation_no']} is ready for your review.", 'quotation:' . $id);
    notify_role('admin', 'Quotation approved', "{$q['quotation_no']} was approved and sent to the customer.", 'quotation:' . $id);
    audit('QUOTATION_APPROVED_OWNER', $q['quotation_no']);
    out(['status' => 'Sent to Customer']);
});
/* a.2 reject with a comment -> back to admin (Draft) */
route('POST', '/owner/quotations/{id}/reject', ['superadmin'], function ($u, $id) {
    $comment = s(input()['comment'] ?? '', 2000);
    if ($comment === '') fail('Please add a comment explaining what should change.');
    $q = one('SELECT * FROM quotations WHERE quotation_id=?', [$id]);
    if (!$q) fail('Quotation not found.', 404);
    if ($q['status'] !== 'Pending Superadmin') fail('This quotation is not awaiting approval.', 409);
    q('UPDATE quotations SET status="Draft", superadmin_comment=? WHERE quotation_id=?', [$comment, $id]);
    quote_event($id, 'Returned by superadmin: ' . $comment);
    notify_role('admin', 'Quotation rejected', "{$q['quotation_no']} needs changes: $comment", 'quotation:' . $id);
    audit('QUOTATION_REJECTED_OWNER', $q['quotation_no']);
    out(['status' => 'Draft']);
});

/* ============ Dashboard (KPIs, 12-month trends, status breakdown, recent events) ============ */
route('GET', '/owner/dashboard', ['superadmin'], function () {
    $from = (new DateTime('first day of this month'))->modify('-11 months')->format('Y-m-d');
    out([
        'active_projects'     => (int)one('SELECT COUNT(*) n FROM projects WHERE status NOT IN ("Done","Failed")')['n'],
        'projects_this_month' => (int)one('SELECT COUNT(*) n FROM projects WHERE DATE_FORMAT(created_at,"%Y-%m")=DATE_FORMAT(CURDATE(),"%Y-%m")')['n'],
        'pending_quotes'      => (int)one('SELECT COUNT(*) n FROM quotations WHERE status="Pending Superadmin"')['n'],
        'revenue'  => all('SELECT DATE_FORMAT(confirmed_at,"%Y-%m") m, SUM(amount_paid) v FROM payments WHERE status="Confirmed" AND confirmed_at>=? GROUP BY m', [$from]),
        'projects' => all('SELECT DATE_FORMAT(created_at,"%Y-%m") m, COUNT(*) v FROM projects WHERE created_at>=? GROUP BY m', [$from]),
        'quotes'   => all('SELECT DATE_FORMAT(date_created,"%Y-%m") m, COUNT(*) v FROM quotations WHERE date_created>=? GROUP BY m', [$from]),
        'project_status' => all('SELECT status, COUNT(*) n FROM projects GROUP BY status'),
        'quote_status'   => all('SELECT status, COUNT(*) n FROM quotations GROUP BY status'),
        'events' => all('SELECT a.log_id,a.action_type,a.details,a.timestamp, CONCAT(u.first_name," ",u.last_name) user_name, u.role FROM audit_logs a JOIN users u USING(user_id) ORDER BY a.log_id DESC LIMIT 10'),
    ]);
});

/* ============ b. Project summary ============ */
route('GET', '/owner/projects/summary', ['superadmin'], function () {
    out([
        'by_status' => all('SELECT status, COUNT(*) n FROM projects GROUP BY status'),
        'by_type'   => all('SELECT i.place_type, COUNT(*) n FROM projects p JOIN service_inquiries i USING(inquiry_id) GROUP BY i.place_type'),
        'contract_value' => (float)one('SELECT COALESCE(SUM(total_amount),0) s FROM quotations WHERE status="Approved"')['s'],
        'outstanding'    => (float)one('SELECT COALESCE(SUM(amount_due),0) s FROM payments WHERE status<>"Confirmed"')['s'],
        'failed_inquiries' => (int)one('SELECT COUNT(*) n FROM service_inquiries WHERE status="Failed"')['n'],
    ]);
});

/* ============ c. Financial summary ============ */
route('GET', '/owner/finance', ['superadmin'], function () {
    $y = (int)($_GET['year'] ?? date('Y'));
    if ($y < 2000 || $y > 2100) fail('Invalid year.');
    $rev = array_column(all('SELECT DATE_FORMAT(confirmed_at,"%Y-%m") m, SUM(amount_paid) v FROM payments WHERE status="Confirmed" AND YEAR(confirmed_at)=? GROUP BY m', [$y]), 'v', 'm');
    $exp = array_column(all('SELECT DATE_FORMAT(expense_date,"%Y-%m") m, SUM(amount) v FROM expenses WHERE YEAR(expense_date)=? AND status<>"Void" GROUP BY m', [$y]), 'v', 'm');
    $months = []; $tr = 0.0; $te = 0.0;
    for ($i = 1; $i <= 12; $i++) {
        $m = sprintf('%04d-%02d', $y, $i);
        $r = round((float)($rev[$m] ?? 0), 2); $e = round((float)($exp[$m] ?? 0), 2); $n = round($r - $e, 2);
        $mg = $r > 0 ? round($n / $r * 100, 2) : 0;
        $months[] = ['month' => $m, 'revenue' => $r, 'expenses' => $e, 'net_profit' => $n, 'margin' => $mg];
        $tr += $r; $te += $e;
        if ($r > 0 || $e > 0) {   // keep the financial_summaries snapshot table in sync
            q('INSERT INTO financial_summaries(month_year,gross_revenue,operating_expenses,net_profit,margin_percentage) VALUES(?,?,?,?,?)
               ON DUPLICATE KEY UPDATE gross_revenue=VALUES(gross_revenue),operating_expenses=VALUES(operating_expenses),net_profit=VALUES(net_profit),margin_percentage=VALUES(margin_percentage)', [$m, $r, $e, $n, $mg]);
            q('UPDATE expenses SET summary_id=(SELECT summary_id FROM financial_summaries WHERE month_year=?) WHERE DATE_FORMAT(expense_date,"%Y-%m")=?', [$m, $m]);
        }
    }
    out([
        'year' => $y, 'months' => $months,
        'totals' => ['revenue' => round($tr, 2), 'expenses' => round($te, 2), 'net_profit' => round($tr - $te, 2), 'margin' => $tr > 0 ? round(($tr - $te) / $tr * 100, 2) : 0],
        'expenses_by_category' => all('SELECT category_name, SUM(amount) total FROM expenses WHERE YEAR(expense_date)=? AND status<>"Void" GROUP BY category_name ORDER BY total DESC', [$y]),
        'receivables' => (float)one('SELECT COALESCE(SUM(amount_due),0) s FROM payments WHERE status IN ("Awaiting Payment","Under Review","Rejected")')['s'],
    ]);
});
/* Monthly revenue + expenses per category for the last 24 months (Financial tab and dashboard chart). */
route('GET', '/owner/ledger', ['superadmin'], function () {
    $from = (new DateTime('first day of this month'))->modify('-23 months')->format('Y-m-d');
    out([
        'revenue'  => all('SELECT DATE_FORMAT(confirmed_at,"%Y-%m") m, SUM(amount_paid) v FROM payments WHERE status="Confirmed" AND confirmed_at>=? GROUP BY m', [$from]),
        'expenses' => all('SELECT DATE_FORMAT(expense_date,"%Y-%m") m, category_name c, SUM(amount) v FROM expenses WHERE expense_date>=? AND status<>"Void" GROUP BY m, c', [$from]),
        'projects' => all('SELECT DATE_FORMAT(created_at,"%Y-%m") m, COUNT(*) v FROM projects WHERE created_at>=? GROUP BY m', [$from]),
        'quotes'   => all('SELECT DATE_FORMAT(date_created,"%Y-%m") m, COUNT(*) v FROM quotations WHERE date_created>=? AND status="Pending Superadmin" GROUP BY m', [$from]),
        'receivables' => (float)one('SELECT COALESCE(SUM(amount_due),0) s FROM payments WHERE status IN ("Awaiting Payment","Under Review","Rejected")')['s'],
    ]);
});
/* ============ Markup on supplier prices (Settings) ============
   Product prices are what the supplier charges; a new quotation line starts at supplier price + markup.
   Changing it never changes quotations that already exist. */
route('GET', '/owner/settings/markup', ['superadmin'], function () {
    out(['markup_percent' => markup_percent()]);
});
route('POST', '/owner/settings/markup', ['superadmin'], function ($u) {
    $v = input()['markup_percent'] ?? null;
    if (!is_numeric($v) || $v < 0 || $v > 300) fail('Enter a markup from 0 to 300 percent.');
    if (round((float)$v, 2) != (float)$v) fail('Use at most 2 decimal places.');
    $old = markup_percent();
    setting_set('markup_percent', (string)round((float)$v, 2));
    audit('MARKUP_CHANGED', $old . '% -> ' . round((float)$v, 2) . '%');
    out(['markup_percent' => round((float)$v, 2)]);
});

/* ============ Expenses: list, add, edit, void (never deleted) ============ */
function expense_filters(array $g, string $alias = 'e'): array {
    $w = []; $p = [];
    $from = (string)($g['from'] ?? ''); $to = (string)($g['to'] ?? '');
    if ($from !== '') { if (!valid_date($from)) fail('Invalid start date.'); $w[] = "$alias.expense_date>=?"; $p[] = $from; }
    if ($to !== '') { if (!valid_date($to)) fail('Invalid end date.'); $w[] = "$alias.expense_date<=?"; $p[] = $to; }
    if ($from !== '' && $to !== '' && $from > $to) fail('The start date must be on or before the end date.');
    if (($c = s($g['category'] ?? '', 80)) !== '' && $c !== 'all') { $w[] = "$alias.category_name=?"; $p[] = $c; }
    if (($pr = (int)($g['project'] ?? 0)) > 0) { $w[] = "$alias.project_id=?"; $p[] = $pr; }
    return [$w, $p];
}
route('GET', '/owner/expenses', ['superadmin'], function () {
    [$w, $p] = expense_filters($_GET);
    if (($st = $_GET['status'] ?? 'Active') !== 'all') { $w[] = 'e.status=?'; $p[] = $st === 'Void' ? 'Void' : 'Active'; }
    out(all('SELECT e.*, p.project_name, CONCAT(u.first_name," ",u.last_name) recorded_by_name, CONCAT(v.first_name," ",v.last_name) voided_by_name
             FROM expenses e LEFT JOIN projects p ON p.project_id=e.project_id LEFT JOIN users u ON u.user_id=e.recorded_by LEFT JOIN users v ON v.user_id=e.voided_by'
             . ($w ? ' WHERE ' . implode(' AND ', $w) : '') . ' ORDER BY e.expense_date DESC, e.expense_id DESC LIMIT 500', $p));
});
route('GET', '/owner/expenses/{id}/history', ['superadmin'], function ($u, $id) {
    out(all('SELECT h.action,h.details,h.created_at, CONCAT(u.first_name," ",u.last_name) changed_by_name FROM expense_history h LEFT JOIN users u ON u.user_id=h.changed_by WHERE h.expense_id=? ORDER BY h.history_id', [$id]));
});
route('POST', '/owner/expenses', ['superadmin'], function ($u) {
    $v = expense_input(input(), EXPENSE_CATS);
    $id = expense_add($v);
    audit('EXPENSE_ADDED', $v['category_name'] . ' ' . $v['amount']);
    out(['expense_id' => $id], 201);
});
route('PUT', '/owner/expenses/{id}', ['superadmin'], function ($u, $id) {
    $old = one('SELECT * FROM expenses WHERE expense_id=?', [$id]);
    if (!$old) fail('Expense not found.', 404);
    if ($old['status'] === 'Void') fail('A voided expense cannot be edited.', 409);
    // older rows may use a category from before; it can be kept when editing
    $v = expense_input(input(), array_unique(array_merge(EXPENSE_CATS, [(string)$old['category_name']])));
    $changes = [];
    foreach ($v as $k => $nv) {
        $ov = $old[$k] ?? null;
        $same = $k === 'amount' ? abs((float)$ov - (float)$nv) < 0.005 : (string)($ov ?? '') === (string)($nv ?? '');
        if (!$same) $changes[] = "$k: " . ($ov === null || $ov === '' ? '(none)' : $ov) . ' -> ' . ($nv === null || $nv === '' ? '(none)' : $nv);
    }
    if (!$changes) fail('Nothing changed.');
    tx(function () use ($id, $v, $changes) {
        q('UPDATE expenses SET category_name=?, description=?, amount=?, expense_date=?, project_id=?, payment_method=?, reference_no=?, updated_at=NOW() WHERE expense_id=?',
          [$v['category_name'], $v['description'], $v['amount'], $v['expense_date'], $v['project_id'], $v['payment_method'], $v['reference_no'], $id]);
        expense_log((int)$id, 'Edited', implode('; ', $changes));
    });
    audit('EXPENSE_EDITED', "#$id");
    out(['expense_id' => (int)$id]);
});
route('POST', '/owner/expenses/{id}/void', ['superadmin'], function ($u, $id) {
    $e = one('SELECT * FROM expenses WHERE expense_id=?', [$id]);
    if (!$e) fail('Expense not found.', 404);
    if ($e['status'] === 'Void') fail('This expense is already voided.', 409);
    $why = reason_text(input());
    tx(function () use ($id, $why) {
        q('UPDATE expenses SET status="Void", void_reason=?, voided_at=NOW(), voided_by=? WHERE expense_id=?', [$why, me()['id'], $id]);
        expense_log((int)$id, 'Voided', $why);
    });
    audit('EXPENSE_VOIDED', "#$id ($why)");
    out(['status' => 'Void']);
});

/* ============ Financial overview (cash basis) ============
   Money counts when it moves:
   - cash in   = payments the admin confirmed (confirmed_at in the period)
   - VAT       = the VAT part of those payments (12% belongs to the BIR, so it is not revenue)
   - revenue   = cash in minus VAT
   - cash out  = active (not voided) expenses dated in the period
   - net cash movement = cash in - cash out;  net profit = revenue - expenses (both cash basis)
   - receivables = approved quotation totals minus their confirmed payments (what customers still owe)
   - per project: contract, paid, balance, estimated costs,
     actual costs (expenses recorded on the project). A quotation is never counted as money received.
   - estimated costs = supplier cost of the quoted items + labor + extra expenses on the quotation */
route('GET', '/owner/finance/overview', ['superadmin'], function () {
    $from = (string)($_GET['from'] ?? date('Y-01-01')); $to = (string)($_GET['to'] ?? date('Y-m-d'));
    if (!valid_date($from) || !valid_date($to)) fail('Choose a valid date range.');
    if ($from > $to) fail('The start date must be on or before the end date.');
    if ((strtotime($to) - strtotime($from)) / 86400 > 1100) fail('Please keep the range to 3 years or less.');
    $proj = (int)($_GET['project'] ?? 0);
    $cat = s($_GET['category'] ?? '', 80); if ($cat === 'all') $cat = '';
    $pw = $proj ? ' AND q.project_id=?' : ''; $pp = $proj ? [$proj] : [];
    // payments with their VAT share (VAT is the same fraction of every payment as of the quotation total)
    $pay = 'FROM payments p JOIN quotations q ON q.quotation_id=p.quotation_id WHERE p.status="Confirmed" AND DATE(p.confirmed_at) BETWEEN ? AND ?' . $pw;
    $vatExpr = 'p.amount_paid * IF(q.total_amount>0, q.vat_amount/q.total_amount, 0)';
    $in = one("SELECT COALESCE(SUM(p.amount_paid),0) cash_in, COALESCE(SUM($vatExpr),0) vat $pay", array_merge([$from, $to], $pp));
    [$ew, $ep] = expense_filters(['from' => $from, 'to' => $to, 'category' => $cat, 'project' => $proj]);
    $ew[] = 'e.status="Active"';
    $ewhere = ' WHERE ' . implode(' AND ', $ew);
    $outSum = (float)one("SELECT COALESCE(SUM(e.amount),0) s FROM expenses e$ewhere", $ep)['s'];
    $cashIn = round((float)$in['cash_in'], 2); $vat = round((float)$in['vat'], 2); $rev = round($cashIn - $vat, 2); $cashOut = round($outSum, 2);
    // months in the range
    $mIn = array_column(all("SELECT DATE_FORMAT(p.confirmed_at,'%Y-%m') m, SUM(p.amount_paid) v, SUM($vatExpr) vat $pay GROUP BY m", array_merge([$from, $to], $pp)), null, 'm');
    $mOut = array_column(all("SELECT DATE_FORMAT(e.expense_date,'%Y-%m') m, SUM(e.amount) v FROM expenses e$ewhere GROUP BY m", $ep), 'v', 'm');
    $months = []; $d = new DateTime(substr($from, 0, 7) . '-01'); $end = substr($to, 0, 7);
    while ($d->format('Y-m') <= $end) {
        $m = $d->format('Y-m'); $ci = round((float)($mIn[$m]['v'] ?? 0), 2); $mv = round((float)($mIn[$m]['vat'] ?? 0), 2); $co = round((float)($mOut[$m] ?? 0), 2);
        $months[] = ['month' => $m, 'cash_in' => $ci, 'vat' => $mv, 'revenue' => round($ci - $mv, 2), 'cash_out' => $co, 'net_cash' => round($ci - $co, 2), 'net_profit' => round($ci - $mv - $co, 2)];
        $d->modify('+1 month');
    }
    // projects (all approved quotations, or the one chosen)
    $projects = all('SELECT pr.project_id, pr.project_name, pr.status, CONCAT(u.first_name," ",u.last_name) customer, q.quotation_no, q.total_amount, q.vat_amount, q.labor_total, q.other_charges_total,
                            (SELECT COALESCE(SUM(qi.cost_price*qi.quantity),0) FROM quotation_items qi WHERE qi.quotation_id=q.quotation_id) item_cost,
                            (SELECT COUNT(*) FROM quotation_items qi JOIN products pp ON pp.product_id=qi.product_id WHERE qi.quotation_id=q.quotation_id AND qi.cost_price IS NULL AND pp.item_type="product") no_cost_lines,
                            (SELECT COALESCE(SUM(p.amount_paid),0) FROM payments p WHERE p.quotation_id=q.quotation_id AND p.status="Confirmed") paid,
                            (SELECT COALESCE(SUM(e.amount),0) FROM expenses e WHERE e.project_id=pr.project_id AND e.status="Active") actual_costs
                     FROM projects pr JOIN quotations q ON q.project_id=pr.project_id AND q.status="Approved"
                     JOIN customers c ON c.customer_id=pr.customer_id JOIN users u ON u.user_id=c.user_id' . ($proj ? ' WHERE pr.project_id=?' : '') . ' ORDER BY pr.project_id DESC LIMIT 300', $pp);
    $recv = 0.0;
    foreach ($projects as &$r) {
        $total = (float)$r['total_amount']; $vatQ = (float)$r['vat_amount']; $paid = (float)$r['paid'];
        $exVat = $total - $vatQ; $est = (float)$r['item_cost'] + (float)$r['labor_total'] + (float)$r['other_charges_total']; $act = (float)$r['actual_costs'];
        $missing = (int)$r['no_cost_lines'] > 0;   // quotations made before supplier prices were saved on each line
        $paidExVat = $total > 0 ? $paid * $exVat / $total : 0;
        $r = ['project_id' => (int)$r['project_id'], 'name' => $r['project_name'], 'customer' => $r['customer'], 'status' => $r['status'], 'quotation_no' => $r['quotation_no'],
              'contract' => round($total, 2), 'vat' => round($vatQ, 2), 'paid' => round($paid, 2), 'balance' => round(max(0, $total - $paid), 2),
              'estimated_costs' => round($est, 2), 'estimated_profit' => round($exVat - $est, 2), 'cost_incomplete' => $missing,
              'actual_costs' => round($act, 2), 'realized_profit' => round($paidExVat - $act, 2)];
        $recv += $r['balance'];
    }
    unset($r);
    out([
        'from' => $from, 'to' => $to,
        'totals' => ['cash_in' => $cashIn, 'vat' => $vat, 'revenue' => $rev, 'cash_out' => $cashOut, 'net_cash' => round($cashIn - $cashOut, 2),
                     'net_profit' => round($rev - $cashOut, 2), 'margin' => $rev > 0 ? round(($rev - $cashOut) / $rev * 100, 1) : null, 'receivables' => round($recv, 2)],
        'by_category' => all("SELECT e.category_name category, SUM(e.amount) total FROM expenses e$ewhere GROUP BY e.category_name ORDER BY total DESC", $ep),
        'months' => $months, 'projects' => $projects,
        'categories' => EXPENSE_CATS, 'methods' => EXPENSE_METHODS,
    ]);
});

/* ============ d. Activity log ============ */
route('GET', '/owner/activity', ['superadmin'], function () {
    $page = max(1, (int)($_GET['page'] ?? 1)); $off = ($page - 1) * 200;
    if (($_GET['source'] ?? 'staff') === 'customer')
        out(all("SELECT l.log_id,l.activity_device,l.location,l.status,l.timestamp, CONCAT(u.first_name,' ',u.last_name) customer FROM customer_activity_logs l JOIN customers c USING(customer_id) JOIN users u ON u.user_id=c.user_id ORDER BY l.log_id DESC LIMIT 200 OFFSET $off"));
    out(all("SELECT a.log_id,a.user_id,a.action_type,a.details,a.ip_address,a.timestamp, CONCAT(u.first_name,' ',u.last_name) user_name, u.role FROM audit_logs a JOIN users u USING(user_id) ORDER BY a.log_id DESC LIMIT 200 OFFSET $off"));
});

/* ============ e. Manage users ============ */
route('GET', '/owner/users', ['superadmin'], function () {
    $role = $_GET['role'] ?? 'all';
    out(all('SELECT user_id,first_name,last_name,email,phone_number,role,status,created_at,(SELECT MAX(a.timestamp) FROM audit_logs a WHERE a.user_id=users.user_id) last_activity FROM users' . ($role !== 'all' ? ' WHERE role=?' : '') . ' ORDER BY user_id DESC LIMIT 500', $role !== 'all' ? [$role] : []));
});
route('POST', '/owner/users', ['superadmin'], function ($u) {
    $in = input();
    $fn = s($in['first_name'] ?? '', 60); $ln = s($in['last_name'] ?? '', 60);
    $email = strtolower(s($in['email'] ?? '', 120)); $pw = (string)($in['password'] ?? ''); $role = $in['role'] ?? '';
    if (!valid_name($fn) || !valid_name($ln)) fail('Names can contain letters and spaces only.');
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) fail('Enter a valid email address.');
    if (!strong_pw($pw)) fail('Password needs at least 8 characters and a number.');
    if (!in_array($role, ['customer', 'admin', 'superadmin'], true)) fail('Invalid role.');
    if (one('SELECT 1 FROM users WHERE email=?', [$email])) fail('That email is already registered.', 409);
    $id = tx(function () use ($fn, $ln, $email, $pw, $role, $in) {
        q('INSERT INTO users(first_name,last_name,email,password_hash,phone_number,role) VALUES(?,?,?,?,?,?)', [$fn, $ln, $email, password_hash($pw, PASSWORD_DEFAULT), s($in['phone_number'] ?? '', 30) ?: null, $role]);
        $id = lastId();
        if ($role === 'customer') q('INSERT INTO customers(user_id,avatar_initials) VALUES(?,?)', [$id, mb_strtoupper(mb_substr($fn, 0, 1) . mb_substr($ln, 0, 1))]);
        return $id;
    });
    audit('USER_CREATED', "$email ($role)");
    out(['user_id' => $id], 201);
});
route('POST', '/owner/users/{id}/status', ['superadmin'], function ($u, $id) {
    $st = input()['status'] ?? '';
    if (!in_array($st, ['Active', 'Disabled'], true)) fail('Invalid status.');
    if ($id === $u['id']) fail('You cannot change your own status.', 409);
    $t = one('SELECT * FROM users WHERE user_id=?', [$id]);
    if (!$t) fail('User not found.', 404);
    q('UPDATE users SET status=? WHERE user_id=?', [$st, $id]);
    audit('USER_STATUS', "{$t['email']} -> $st");
    out(['status' => $st]);
});
route('DELETE', '/owner/users/{id}', ['superadmin'], function ($u, $id) {
    if ($id === $u['id']) fail('You cannot delete your own account.', 409);
    $t = one('SELECT * FROM users WHERE user_id=?', [$id]);
    if (!$t) fail('User not found.', 404);
    if ($t['role'] === 'superadmin' && (int)one('SELECT COUNT(*) n FROM users WHERE role="superadmin" AND status="Active"')['n'] <= 1) fail('At least one active owner account must remain.', 409);
    try {
        tx(function () use ($id, $t) {
            if ($t['role'] === 'customer') q('DELETE FROM customers WHERE user_id=?', [$id]);
            q('DELETE FROM users WHERE user_id=?', [$id]);
        });
    } catch (PDOException $e) {
        if ($e->getCode() === '23000') { if (db()->inTransaction()) db()->rollBack(); fail('This account has linked records (inquiries, quotations, logs) and cannot be deleted. Disable it instead.', 409); }
        throw $e;
    }
    audit('USER_DELETED', $t['email']);
    out(['message' => 'Account deleted.']);
});
