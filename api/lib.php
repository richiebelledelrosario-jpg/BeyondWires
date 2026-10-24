<?php
declare(strict_types=1);

$GLOBALS['CFG'] = require __DIR__ . '/../config.php';
$GLOBALS['ROUTES'] = [];
date_default_timezone_set($GLOBALS['CFG']['timezone'] ?? 'Asia/Manila');

const IMG  = ['image/jpeg' => 'jpg', 'image/png' => 'png', 'image/webp' => 'webp'];
const PDFM = ['application/pdf' => 'pdf'];

function cfg(string $k) { return $GLOBALS['CFG'][$k] ?? null; }

/* ---------------- DB ---------------- */
function db(): PDO {
    if (!isset($GLOBALS['PDO'])) {
        $c = cfg('db');
        $GLOBALS['PDO'] = new PDO(
            "mysql:host={$c['host']};dbname={$c['name']};charset={$c['charset']}", $c['user'], $c['pass'],
            [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, PDO::ATTR_EMULATE_PREPARES => false]
        );
        $GLOBALS['PDO']->exec("SET time_zone='" . (new DateTime())->format('P') . "'");   // DB dates follow PHP's timezone
    }
    return $GLOBALS['PDO'];
}
function q(string $sql, array $p = []): PDOStatement { $st = db()->prepare($sql); $st->execute($p); return $st; }
function one(string $sql, array $p = []): ?array { $r = q($sql, $p)->fetch(); return $r ?: null; }
function all(string $sql, array $p = []): array { return q($sql, $p)->fetchAll(); }
function lastId(): int { return (int)db()->lastInsertId(); }
function tx(callable $fn) {
    db()->beginTransaction();
    try { $r = $fn(); db()->commit(); return $r; }
    catch (Throwable $e) { if (db()->inTransaction()) db()->rollBack(); throw $e; }
}

/* ---------------- Output ---------------- */
function out($data = [], int $code = 200): void {
    http_response_code($code);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['ok' => true, 'data' => $data], JSON_UNESCAPED_UNICODE);
    exit;
}
function fail(string $msg, int $code = 400): void {
    if (isset($GLOBALS['PDO']) && $GLOBALS['PDO']->inTransaction()) $GLOBALS['PDO']->rollBack();
    http_response_code($code);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['ok' => false, 'error' => $msg], JSON_UNESCAPED_UNICODE);
    exit;
}
function input(): array {
    static $d = null;
    if ($d === null) {
        $j = json_decode((string)file_get_contents('php://input'), true);
        $d = is_array($j) ? $j : $_POST;
    }
    return $d;
}
function s($v, int $max = 255): string { return mb_substr(trim((string)$v), 0, $max); }

/* ---------------- Dates, times, addresses (server-side copies of the page rules) ---------------- */
// Date range per feature: customer pages accept 2019-2028; admin and super admin pages accept 2026-2028.
const CUSTOMER_DATES = ['2019-01-01', '2028-12-31', 'Please choose a date from 2019 to 2028.'];
const STAFF_DATES    = ['2026-01-01', '2028-12-31', 'Please choose a date from 2026 to 2028.'];
function valid_date($v): bool {
    $d = DateTime::createFromFormat('!Y-m-d', (string)$v);
    return $d !== false && $d->format('Y-m-d') === $v;
}
/** Fails unless $v is a real YYYY-MM-DD date inside the given range (CUSTOMER_DATES / STAFF_DATES). */
function need_date($v, array $range, string $label = 'date'): string {
    $v = (string)$v;
    if (!valid_date($v)) fail("Please choose a valid $label.");
    if ($v < $range[0] || $v > $range[1]) fail($range[2]);
    return $v;
}
/** "9:00 AM" style times (what both calendars use). Returns the normalized text or null. */
function norm_time($t): ?string {
    if (!preg_match('/^\s*(1[0-2]|0?[1-9]):([0-5]\d)\s*(AM|PM)\s*$/i', (string)$t, $m)) return null;
    return (int)$m[1] . ':' . $m[2] . ' ' . strtoupper($m[3]);
}
function time_minutes(string $t): int {
    preg_match('/^(\d+):(\d+) (AM|PM)$/', $t, $m);
    return ((int)$m[1] % 12 + ($m[3] === 'PM' ? 12 : 0)) * 60 + (int)$m[2];
}
/** Metro Manila (NCR) only: the 16 cities plus Pateros. Same list as the customer page. */
function ncr_city(string $addr): ?string {
    $t = strtolower(preg_replace('/\s+/', ' ', trim(strtr($addr, ['ñ' => 'n', 'Ñ' => 'n']))));
    $list = ['Caloocan' => '/\bcaloocan\b/', 'Las Piñas' => '/\blas\s+pinas\b/', 'Makati' => '/\bmakati\b/', 'Malabon' => '/\bmalabon\b/',
             'Mandaluyong' => '/\bmandaluyong\b/', 'Manila' => '/\bmanila\b/', 'Marikina' => '/\bmarikina\b/', 'Muntinlupa' => '/\bmuntinlupa\b/',
             'Navotas' => '/\bnavotas\b/', 'Parañaque' => '/\bparanaque\b/', 'Pasay' => '/\bpasay\b/', 'Pasig' => '/\bpasig\b/', 'Pateros' => '/\bpateros\b/',
             'Quezon City' => '/\bquezon\s+city\b|\bq\.?\s?c\.?\b/', 'San Juan' => '/\bsan\s+juan\b/', 'Taguig' => '/\btaguig\b/', 'Valenzuela' => '/\bvalenzuela\b/'];
    foreach ($list as $city => $re) if (preg_match($re, $t)) return $city;
    return null;
}
/** PH mobile: +63 9XX XXX XXXX, 09XXXXXXXXX or 9XXXXXXXXX. Returns "+63 9XX XXX XXXX" or null. */
function ph_mobile($v): ?string {
    if (!preg_match('/^(?:\+?63|0)?(9\d{9})$/', preg_replace('/[\s\-().]/', '', (string)$v), $m)) return null;
    return '+63 ' . substr($m[1], 0, 3) . ' ' . substr($m[1], 3, 3) . ' ' . substr($m[1], 6);
}

/* ---------------- Auth / session ---------------- */
function start_session(): void {
    session_name(cfg('session_name'));
    session_set_cookie_params(['httponly' => true, 'samesite' => 'Lax', 'secure' => !empty($_SERVER['HTTPS'])]);
    session_start();
}
/** Idle timeout: a login ends after 30 minutes without activity (config.php 'session_idle_minutes' can change it).
    The automatic notification check every minute does not count as activity. */
function session_idle_check(bool $activity): void {
    if (empty($_SESSION['user'])) return;
    $limit = 60 * ((int)cfg('session_idle_minutes') ?: 30);
    if (time() - ($_SESSION['last_activity'] ?? time()) > $limit) { $_SESSION = []; session_regenerate_id(true); return; }
    if ($activity || !isset($_SESSION['last_activity'])) $_SESSION['last_activity'] = time();
}
function me(): ?array { return $_SESSION['user'] ?? null; }
/** need() = any logged-in user; need('admin') = only that role. Re-checks the account is still active. */
function need(string ...$roles): array {
    $u = me();
    if (!$u) fail('Please log in.', 401);
    $row = one('SELECT status, role FROM users WHERE user_id=?', [$u['id']]);
    if (!$row || $row['status'] !== 'Active') { $_SESSION = []; fail('Account is disabled.', 401); }
    if ($roles && !in_array($u['role'], $roles, true)) fail('You do not have access to this.', 403);
    return $u;
}

function route(string $method, string $path, ?array $roles, callable $fn): void {
    $re = '#^' . preg_replace('#\{(\w+)\}#', '(?P<$1>\d+)', $path) . '$#';
    $GLOBALS['ROUTES'][] = [$method, $re, $roles, $fn];
}

/* ---------------- Logging / notifications ---------------- */
function audit(string $action, string $details = ''): void {
    $u = me(); if (!$u) return;
    q('INSERT INTO audit_logs(user_id,action_type,details,ip_address) VALUES(?,?,?,?)', [$u['id'], $action, $details, $_SERVER['REMOTE_ADDR'] ?? '']);
}
/* $link tells the page what to open when the notification is clicked, e.g. "quotation:12", "project:3", "inquiry:5", "schedule" */
function notify(int $userId, string $title, string $msg, ?string $link = null): void {
    q('INSERT INTO notifications(user_id,title,message,link) VALUES(?,?,?,?)', [$userId, $title, $msg, $link]);
}
function notify_role(string $role, string $title, string $msg, ?string $link = null): void {
    q("INSERT INTO notifications(user_id,title,message,link) SELECT user_id,?,?,? FROM users WHERE role=? AND status='Active'", [$title, $msg, $link, $role]);
}
/* These customer notifications are also sent to the customer's email. The others stay in the bell only. */
const EMAIL_EVENTS = ['Inquiry received', 'Inquiry acknowledged', 'Inquiry not accepted', 'Site visit confirmed', 'Site visit schedule updated', 'New schedule proposed', 'New quotation',
                      'Payment confirmed', 'Payment proof rejected', 'Installation scheduled', 'Project completed', 'Installation certificate available', 'Changes requested'];
function notify_customer(int $customerId, string $title, string $msg, ?string $link = null): void {
    $r = one('SELECT c.user_id, u.email, u.first_name FROM customers c JOIN users u USING(user_id) WHERE c.customer_id=?', [$customerId]);
    if (!$r) return;
    notify((int)$r['user_id'], $title, $msg, $link);
    if (!in_array($title, EMAIL_EVENTS, true)) return;
    // sent after the request finishes, and only if it succeeded (a failed or undone action sends nothing)
    if (!isset($GLOBALS['MAIL_QUEUE'])) {
        $GLOBALS['MAIL_QUEUE'] = [];
        register_shutdown_function(function () {
            if (http_response_code() >= 400) return;
            foreach ($GLOBALS['MAIL_QUEUE'] as $m) send_mail(...$m);
        });
    }
    $login = rtrim((string)cfg('app_url'), '/') . '/HTML/LandingPage.html#login';
    $GLOBALS['MAIL_QUEUE'][] = [$r['email'], "BeyondWires: $title",
        '<p style="margin:0 0 12px">Hi ' . htmlspecialchars($r['first_name']) . ',</p><p style="margin:0">' . htmlspecialchars($msg) . '</p>' . email_button($login, 'Log in to see the details'),
        "Hi {$r['first_name']},\n\n$msg\n\nLog in to see the details: $login"];
}

/* ---------------- Files ---------------- */
function save_upload(string $field, array $allowed, string $sub): string {
    if (empty($_FILES[$field]) || $_FILES[$field]['error'] !== UPLOAD_ERR_OK) fail('File upload failed or missing.');
    $f = $_FILES[$field];
    if ($f['size'] > cfg('max_upload')) fail('File is too large (max 5 MB).');
    $mime = (new finfo(FILEINFO_MIME_TYPE))->file($f['tmp_name']);
    if (!isset($allowed[$mime])) fail('Unsupported file type.');
    $dir = cfg('upload_dir') . "/$sub";
    if (!is_dir($dir)) mkdir($dir, 0750, true);
    $name = bin2hex(random_bytes(16)) . '.' . $allowed[$mime];
    if (!move_uploaded_file($f['tmp_name'], "$dir/$name")) fail('Could not save the file.', 500);
    return "$sub/$name";
}
function stream_file(string $rel, string $downloadName): void {
    $base = realpath(cfg('upload_dir'));
    $full = realpath($base . '/' . $rel);
    if (!$full || !str_starts_with($full, $base . DIRECTORY_SEPARATOR) || !is_file($full)) fail('File not found.', 404);
    $mime = (new finfo(FILEINFO_MIME_TYPE))->file($full);
    header('Content-Type: ' . $mime);
    header('Content-Length: ' . filesize($full));
    header('Content-Disposition: inline; filename="' . preg_replace('/[^A-Za-z0-9._-]/', '_', $downloadName) . '"');
    header('X-Content-Type-Options: nosniff');
    readfile($full);
    exit;
}
function add_doc(int $cid, ?int $inq, string $type, string $title, string $path, ?int $qid = null, ?int $pid = null): void {
    if (one('SELECT 1 FROM customer_documents WHERE file_path=?', [$path])) return;
    q('INSERT INTO customer_documents(customer_id,inquiry_id,quotation_id,payment_id,document_type,title,file_path,date_issued) VALUES(?,?,?,?,?,?,?,CURDATE())',
      [$cid, $inq, $qid, $pid, $type, $title, $path]);
}
function publish_quote_doc(int $qid): void {
    $q = one('SELECT * FROM quotations WHERE quotation_id=?', [$qid]);
    if ($q && $q['pdf_path'] && in_array($q['status'], ['Sent to Customer', 'Approved'], true))
        add_doc((int)$q['customer_id'], (int)$q['inquiry_id'], 'Quotation', 'Quotation ' . $q['quotation_no'], $q['pdf_path'], $qid);
}

/* ---------------- Email ----------------
   Uses PHPMailer (api/PHPMailer) and the Gmail settings in config.php ('mail'). Returns true when sent.
   Every email gets the BeyondWires layout below (same colors as the website). Email programs ignore
   stylesheets and scripts, so the layout is tables with inline styles only. */
const BW_SUPPORT_EMAIL = 'beyondwires4demo@gmail.com';
const BW_SUPPORT_PHONE = '+63 951 001 0467';
/** A blue button for an email ($url is escaped here). */
function email_button(string $url, string $label): string {
    $u = htmlspecialchars($url, ENT_QUOTES);
    return '<table role="presentation" cellpadding="0" cellspacing="0" style="margin:22px 0 6px"><tr><td style="border-radius:10px;background:#0077F6">'
         . '<a href="' . $u . '" style="display:inline-block;padding:13px 26px;font-family:Arial,Helvetica,sans-serif;font-size:15px;font-weight:bold;color:#FFFFFF;text-decoration:none;border-radius:10px">'
         . htmlspecialchars($label) . '</a></td></tr></table>';
}
/** Wraps an email body (already escaped HTML) in the BeyondWires header, card and footer. */
function email_layout(string $title, string $body): string {
    $t = htmlspecialchars($title);
    $pre = htmlspecialchars(mb_substr(trim(preg_replace('/\s+/', ' ', strip_tags($body))), 0, 120));
    $mail = BW_SUPPORT_EMAIL; $tel = preg_replace('/[^+\d]/', '', BW_SUPPORT_PHONE); $phone = BW_SUPPORT_PHONE; $year = date('Y');
    return <<<HTML
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>$t</title></head>
<body style="margin:0;padding:0;background:#EEF4FA">
<div style="display:none;max-height:0;overflow:hidden;opacity:0">$pre</div>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#EEF4FA"><tr><td align="center" style="padding:24px 12px">
  <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:560px">
    <tr><td style="background:#0B132B;border-radius:16px 16px 0 0;padding:22px 28px;border-bottom:4px solid #0077F6">
      <div style="font-family:Arial,Helvetica,sans-serif;font-size:24px;font-weight:bold;color:#FFFFFF;letter-spacing:.3px">Beyond<span style="color:#4DA3FF">wires</span></div>
      <div style="font-family:Arial,Helvetica,sans-serif;font-size:10px;font-weight:bold;letter-spacing:2px;color:#93C5FD;margin-top:3px">SECURITY SYSTEM SERVICES</div>
    </td></tr>
    <tr><td style="background:#FFFFFF;padding:28px 28px 26px;font-family:Arial,Helvetica,sans-serif;font-size:15px;line-height:1.6;color:#24324A">
      <h1 style="margin:0 0 14px;font-size:20px;line-height:1.3;color:#0B132B">$t</h1>
      $body
    </td></tr>
    <tr><td style="background:#F8FAFC;border-radius:0 0 16px 16px;border-top:1px solid #DCE8F2;padding:18px 28px;font-family:Arial,Helvetica,sans-serif;font-size:12px;line-height:1.6;color:#5A6B85">
      <b style="color:#0B132B">BeyondWires Security System Services</b><br>
      Tala, Caloocan City &middot; serving mainland Luzon<br>
      <a href="mailto:$mail" style="color:#0077F6;text-decoration:none">$mail</a> &middot; <a href="tel:$tel" style="color:#0077F6;text-decoration:none">$phone</a><br>
      <span style="color:#8A98AE">This is an automated message from your BeyondWires account. &copy; $year BeyondWires</span>
    </td></tr>
  </table>
</td></tr></table>
</body></html>
HTML;
}
function send_mail(string $to, string $subject, string $html, string $text): bool {
    $html = email_layout(preg_replace('/^BeyondWires: /', '', $subject), $html);
    $text .= "\n\n--\nBeyondWires Security System Services\n" . BW_SUPPORT_EMAIL . ' | ' . BW_SUPPORT_PHONE;
    $m = cfg('mail');
    if (!$m || empty($m['pass'])) { error_log('[BW] Email not sent: set the Gmail App Password in config.php (mail > pass).'); return false; }
    require_once __DIR__ . '/PHPMailer/Exception.php';
    require_once __DIR__ . '/PHPMailer/PHPMailer.php';
    require_once __DIR__ . '/PHPMailer/SMTP.php';
    $mail = new PHPMailer\PHPMailer\PHPMailer(true);
    try {
        $mail->isSMTP();
        $mail->Host = $m['host']; $mail->Port = (int)$m['port']; $mail->SMTPAuth = true;
        $mail->Username = $m['user']; $mail->Password = $m['pass'];
        $mail->SMTPSecure = $m['secure'] ?? 'tls'; $mail->SMTPAutoTLS = ($m['secure'] ?? 'tls') !== '';
        $mail->CharSet = 'UTF-8';
        $mail->setFrom($m['user'], $m['from_name'] ?? 'BeyondWires');
        $mail->addAddress($to);
        $mail->isHTML(true); $mail->Subject = $subject; $mail->Body = $html; $mail->AltBody = $text;
        $mail->send();
        return true;
    } catch (Throwable $e) {
        error_log('[BW] Email not sent: ' . $mail->ErrorInfo);
        return false;
    }
}

/* ---------------- Scheduling ----------------
   One calendar for everybody: the admin publishes open slots (schedule_availability),
   customers can only book a published slot that nobody else holds. The unique key on
   installation_schedules.active_key still stops double bookings under race conditions. */
function slot_published(string $date, string $slot): bool {
    return (bool)one('SELECT 1 FROM schedule_availability WHERE available_date=? AND time_slot=?', [$date, $slot]);
}
function publish_slot(string $date, string $slot): void {
    q('INSERT IGNORE INTO schedule_availability(available_date,time_slot,created_by) VALUES(?,?,?)', [$date, $slot, me()['id'] ?? null]);
}
/** Validates a booking. Customers: published slot, from tomorrow up to N days ahead.
    Staff: any valid time from today up to the end of 2028; an unpublished time is published automatically. Returns the normalized time. */
function check_slot(string $date, string $slot, bool $staff = false): string {
    if (!valid_date($date)) fail('Invalid date.');
    $t = norm_time($slot);
    if (!$t) fail('Invalid time slot.');
    $today = date('Y-m-d');
    if ($staff) {
        need_date($date, STAFF_DATES);
        if ($date < $today) fail('That date has already passed.');
        publish_slot($date, $t);
        return $t;
    }
    if ($date <= $today) fail('Please choose a date from tomorrow onward.');
    if ($date > date('Y-m-d', strtotime('+' . (int)cfg('booking_days_ahead') . ' days'))) fail('Date is too far ahead.');
    need_date($date, CUSTOMER_DATES);
    if (!slot_published($date, $t)) fail('That time slot is not open for booking. Please choose another.', 409);
    return $t;
}
function reserve_slot(?int $quotationId, ?int $inquiryId, string $date, string $slot, string $type, bool $staff = false): int {
    $slot = check_slot($date, $slot, $staff);
    try {
        q('INSERT INTO installation_schedules(quotation_id,inquiry_id,scheduled_date,time_slot,activity_type,status) VALUES(?,?,?,?,?,"Requested")',
          [$quotationId, $inquiryId, $date, $slot, $type]);
        return lastId();
    } catch (PDOException $e) {
        if ($e->getCode() === '23000') fail('That time slot was just taken. Please choose another.', 409);
        throw $e;
    }
}
function move_slot(int $sid, string $date, string $slot, bool $staff = false): string {
    $slot = check_slot($date, $slot, $staff);
    try { q('UPDATE installation_schedules SET scheduled_date=?, time_slot=? WHERE schedule_id=?', [$date, $slot, $sid]); }
    catch (PDOException $e) { if ($e->getCode() === '23000') fail('That time slot is already booked.', 409); throw $e; }
    return $slot;
}
/** Every schedule change is kept in schedule_changes (update_2026_11.sql, section 3). */
function log_schedule_change(int $sid, string $kind, ?string $oldDate, ?string $oldSlot, ?string $newDate, ?string $newSlot, ?string $reason = null): void {
    q('INSERT INTO schedule_changes(schedule_id,kind,old_date,old_slot,new_date,new_slot,reason,changed_by) VALUES(?,?,?,?,?,?,?,?)',
      [$sid, $kind, $oldDate, $oldSlot, $newDate, $newSlot, $reason, me()['id'] ?? null]);
}
/** The admin proposes a new time for a booking. The new slot is held (status Requested, proposed_by "admin")
    until the customer accepts it or asks for another time. previous_date / previous_slot keep the time it replaces. */
function propose_slot(array $s, string $date, string $slot, string $reason): string {
    $t = move_slot((int)$s['schedule_id'], $date, $slot, true);
    q('UPDATE installation_schedules SET status="Requested", proposed_by="admin", previous_date=COALESCE(previous_date,?), previous_slot=COALESCE(previous_slot,?), change_reason=?, changed_at=NOW() WHERE schedule_id=?',
      [$s['scheduled_date'], $s['time_slot'], $reason, $s['schedule_id']]);
    log_schedule_change((int)$s['schedule_id'], 'Admin proposal', $s['scheduled_date'], $s['time_slot'], $date, $t, $reason);
    if ($s['activity_type'] === 'Site Inspection' && $s['inquiry_id'])
        q('UPDATE service_inquiries SET preferred_visit_at=? WHERE inquiry_id=?', [date('Y-m-d H:i:s', strtotime("$date $t")), $s['inquiry_id']]);
    return $t;
}
/** Reason picked from a list (or typed after "Others") plus an optional comment, stored as one line. */
function reason_text(array $in, bool $commentRequired = false): string {
    $r = preg_replace('/\s+/', ' ', s($in['reason'] ?? '', 100));
    $c = s($in['comment'] ?? '', 400);
    if ($r === '') fail('Please choose a reason.');
    if ($commentRequired && $c === '') fail('Please add a comment.');
    return $c !== '' ? "$r. $c" : $r;
}

/* ---------------- Expenses (money actually paid out; update_2026_11.sql, section 4) ---------------- */
const EXPENSE_CATS = ['Equipment & Materials', 'Labor & Personnel', 'Transportation & Fuel', 'Meals', 'Maintenance & Repair', 'Other'];
const PROJECT_EXPENSE_CATS = ['Equipment & Materials', 'Labor & Personnel', 'Transportation & Fuel', 'Meals'];   // what the admin can record on a project
const EXPENSE_METHODS = ['Cash', 'GCash', 'Bank transfer', 'Check', 'Other'];
/** Checks an expense form. Returns the clean values. */
function expense_input(array $in, array $cats): array {
    $d = (string)($in['expense_date'] ?? '');
    if (!valid_date($d)) fail('Enter the date the money was paid.');
    need_date($d, STAFF_DATES, 'expense date');
    if ($d > date('Y-m-d')) fail('An expense date cannot be in the future.');
    $cat = s($in['category_name'] ?? '', 80);
    if (!in_array($cat, $cats, true)) fail('Choose a category from the list.');
    $desc = preg_replace('/\s+/', ' ', s($in['description'] ?? '', 255));
    if (mb_strlen($desc) < 3) fail('Describe what the expense was for.');
    $amt = $in['amount'] ?? null;
    if (!is_numeric($amt) || $amt <= 0 || $amt > 10000000) fail('Enter an amount greater than 0 and up to 10,000,000.');
    if (round((float)$amt, 2) != (float)$amt) fail('The amount can have at most 2 decimal places.');
    $method = s($in['payment_method'] ?? '', 40);
    if ($method !== '' && !in_array($method, EXPENSE_METHODS, true)) fail('Choose a payment method from the list.');
    $ref = s($in['reference_no'] ?? '', 60);
    if ($ref !== '' && !preg_match('/^[A-Za-z0-9\- \/#]+$/', $ref)) fail('The reference number can contain letters, numbers, spaces and - / # only.');
    $pid = (int)($in['project_id'] ?? 0) ?: null;
    if ($pid && !one('SELECT 1 FROM projects WHERE project_id=?', [$pid])) fail('That project does not exist.');
    return ['expense_date' => $d, 'category_name' => $cat, 'description' => $desc, 'amount' => round((float)$amt, 2),
            'payment_method' => $method ?: null, 'reference_no' => $ref ?: null, 'project_id' => $pid];
}
function expense_add(array $v): int {
    q('INSERT INTO expenses(category_name,description,amount,expense_date,project_id,payment_method,reference_no,recorded_by,created_at,status) VALUES(?,?,?,?,?,?,?,?,NOW(),"Active")',
      [$v['category_name'], $v['description'], $v['amount'], $v['expense_date'], $v['project_id'], $v['payment_method'], $v['reference_no'], me()['id'] ?? null]);
    $id = (int)lastId();
    expense_log($id, 'Added', $v['category_name'] . ' ' . number_format($v['amount'], 2) . ' on ' . $v['expense_date']);
    return $id;
}
function expense_log(int $id, string $action, string $details): void {
    q('INSERT INTO expense_history(expense_id,action,details,changed_by) VALUES(?,?,?,?)', [$id, $action, $details, me()['id'] ?? null]);
}

/** Customer that owns a schedule row (site visit -> inquiry, installation -> quotation -> inquiry). */
function schedule_customer(array $s): ?int {
    $inq = $s['inquiry_id'] ?: (one('SELECT inquiry_id FROM quotations WHERE quotation_id=?', [$s['quotation_id']])['inquiry_id'] ?? null);
    $c = $inq ? one('SELECT customer_id FROM service_inquiries WHERE inquiry_id=?', [$inq]) : null;
    return $c ? (int)$c['customer_id'] : null;
}

/* ---------------- Settings kept in the database (app_settings; update_2026_11.sql, section 5) ---------------- */
function setting(string $key, ?string $default = null): ?string {
    $r = one('SELECT setting_value FROM app_settings WHERE setting_key=?', [$key]);
    return $r ? (string)$r['setting_value'] : $default;
}
function setting_set(string $key, string $value): void {
    q('INSERT INTO app_settings(setting_key,setting_value,updated_by,updated_at) VALUES(?,?,?,NOW()) ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value), updated_by=VALUES(updated_by), updated_at=NOW()', [$key, $value, me()['id'] ?? null]);
}
/** BeyondWires' markup on the supplier price (Super Admin > Settings). Prices of type "product" are supplier prices;
    services and packages are BeyondWires' own prices and get no markup. */
function markup_percent(): float { return (float)setting('markup_percent', '20'); }
/** Selling price of a product: supplier price + markup. */
function sell_price($supplier): float { return round((float)$supplier * (1 + markup_percent() / 100), 2); }

/* ---------------- Quotations ---------------- */
/** Server-side cart math: prices come from the DB (admin may override a unit price), nothing is trusted from the browser totals.
    A line's default price is the supplier price + markup; the supplier price is kept on the line as cost_price (never shown to customers).
    Total = items + extra expenses + labor (server labor rates), then VAT on all three. */
function quote_calc(array $items, array $charges, array $labor = [], bool $noLabor = true): array {
    if (!$items) fail('Add at least one item to the quotation.');
    $pmax = (float)cfg('price_max'); $qmax = (int)cfg('qty_max');
    $lines = []; $sub = 0.0;
    foreach ($items as $it) {
        $pid = (int)($it['product_id'] ?? 0); $qty = $it['quantity'] ?? 0;
        if (!is_numeric($qty) || (int)$qty != $qty || $qty < 1 || $qty > $qmax) fail("Quantity must be a whole number from 1 to $qmax.");
        $qty = (int)$qty;
        $p = one('SELECT product_id,name,unit_price,item_type FROM products WHERE product_id=?', [$pid]);
        if (!$p) fail("Unknown product #$pid.");
        // products are bought from a supplier: their catalog price is the cost and the markup is added.
        // services and packages are BeyondWires' own prices: no markup and no supplier cost.
        $isProduct = $p['item_type'] === 'product';
        $cost = $isProduct ? round((float)$p['unit_price'], 2) : null;
        $default = $isProduct ? sell_price($cost) : round((float)$p['unit_price'], 2);
        $price = (isset($it['unit_price']) && $it['unit_price'] !== '' && $it['unit_price'] !== null) ? $it['unit_price'] : $default;
        if (!is_numeric($price) || $price <= 0 || $price > $pmax) fail('Every line item needs a price above zero and no more than PHP ' . number_format($pmax) . '.');
        $price = round((float)$price, 2);
        $tot = round($price * $qty, 2); $sub += $tot;
        $lines[] = [$pid, $p['name'], $qty, $price, $tot, $cost];
    }
    $ch = []; $ct = 0.0;
    foreach ($charges as $c) {
        $label = s($c['label'] ?? '', 120);
        $amt = $c['amount'] ?? 0;
        if (($amt === '' || (float)$amt == 0.0) && $label === '') continue;                 // empty row
        if ($label === '') fail('Give every extra expense a name.');
        if (!is_numeric($amt) || $amt < 0) fail('Extra expense amounts cannot be negative.');
        $amt = round((float)$amt, 2);
        $ch[] = [$label, $amt]; $ct += $amt;
    }
    if ($ct > (float)cfg('expense_max')) fail('Extra expenses cannot exceed PHP ' . number_format((float)cfg('expense_max')) . ' in total.');
    $rates = cfg('labor_rates'); $lab = []; $lt = 0.0;
    if (!$noLabor) {
        if (!$labor) fail('Assign at least one worker, or choose "No labor needed".');
        foreach ($labor as $w) {
            $role = (string)($w['role'] ?? '');
            if (!isset($rates[$role])) fail('Unknown worker role.');
            $n = $w['workers'] ?? 0; $d = $w['days'] ?? 0;
            if (!is_numeric($n) || (int)$n != $n || $n < 1 || $n > cfg('labor_workers_max')) fail('Workers per line must be from 1 to ' . cfg('labor_workers_max') . '.');
            if (!is_numeric($d) || (int)$d != $d || $d < 1 || $d > cfg('labor_days_max')) fail('Work days must be from 1 to ' . cfg('labor_days_max') . '.');
            $amt = round((int)$n * (int)$d * $rates[$role], 2);
            $lab[] = [$role, (int)$n, (int)$d, (float)$rates[$role], $amt]; $lt += $amt;
        }
    }
    $sub = round($sub, 2); $ct = round($ct, 2); $lt = round($lt, 2);
    $vat = round(($sub + $ct + $lt) * (float)cfg('vat_rate'), 2);
    if ($sub + $ct + $lt <= 0) fail('Quotation total must be greater than zero.');
    return [$lines, $ch, $sub, $ct, $lab, $lt, $vat];
}
function quote_write(int $qid, array $lines, array $ch, ?array $lab = null): void {
    q('DELETE FROM quotation_items WHERE quotation_id=?', [$qid]);
    q('DELETE FROM quotation_charges WHERE quotation_id=?', [$qid]);
    foreach ($lines as [$pid, $name, $qty, $price, $tot, $cost])
        q('INSERT INTO quotation_items(quotation_id,product_id,description,quantity,unit_price,total_amount,cost_price) VALUES(?,?,?,?,?,?,?)', [$qid, $pid, $name, $qty, $price, $tot, $cost]);
    foreach ($ch as [$label, $amt])
        q('INSERT INTO quotation_charges(quotation_id,label,amount) VALUES(?,?,?)', [$qid, $label, $amt]);
    if ($lab !== null) {
        q('DELETE FROM quotation_labor WHERE quotation_id=?', [$qid]);
        foreach ($lab as [$role, $n, $d, $rate, $amt])
            q('INSERT INTO quotation_labor(quotation_id,role,workers,days,daily_rate,amount) VALUES(?,?,?,?,?,?)', [$qid, $role, $n, $d, $rate, $amt]);
    }
}
/** The optional text fields printed on the quotation. */
function quote_fields(array $in, array $old = []): array {
    $f = ['scope_of_work' => 2000, 'project_title' => 120, 'duration' => 60, 'site_address' => 160, 'project_incharge' => 60, 'payment_terms' => 120, 'notes' => 2000];
    $out = [];
    foreach ($f as $k => $max) $out[$k] = array_key_exists($k, $in) ? (s($in[$k], $max) ?: null) : ($old[$k] ?? null);
    return $out;
}
function quote_event(int $qid, string $text): void {
    q('INSERT INTO quotation_events(quotation_id,event,created_by) VALUES(?,?,?)', [$qid, mb_substr($text, 0, 160), me()['id'] ?? null]);
}
function quote_expiry($v): string {
    if (!$v) return (new DateTime('+' . (int)cfg('validity_days') . ' days'))->format('Y-m-d');
    $d = DateTime::createFromFormat('Y-m-d', (string)$v);
    if (!$d || $d->format('Y-m-d') !== $v || $d <= new DateTime('today')) fail('Expiry date must be a future date.');
    return $v;
}
function quote_detail(int $id): ?array {
    $q = one('SELECT q.*, i.place_type, i.installation_address, i.needs_site_visit, i.urgency_level, i.purchase_option, u.first_name, u.last_name, u.email, u.phone_number, c.company_name
              FROM quotations q JOIN service_inquiries i ON i.inquiry_id=q.inquiry_id JOIN customers c ON c.customer_id=q.customer_id JOIN users u ON u.user_id=c.user_id
              WHERE q.quotation_id=?', [$id]);
    if (!$q) return null;
    $q['items']     = all('SELECT qi.*, p.item_type, p.category, p.description product_description FROM quotation_items qi LEFT JOIN products p USING(product_id) WHERE qi.quotation_id=?', [$id]);
    $q['charges']   = all('SELECT * FROM quotation_charges WHERE quotation_id=?', [$id]);
    $q['labor']     = all('SELECT * FROM quotation_labor WHERE quotation_id=? ORDER BY labor_id', [$id]);
    $q['events']    = all('SELECT event, created_at FROM quotation_events WHERE quotation_id=? ORDER BY event_id DESC', [$id]);
    $q['approval']  = one('SELECT * FROM quotation_approvals WHERE quotation_id=? ORDER BY approval_id DESC LIMIT 1', [$id]);
    $q['payments']  = all('SELECT payment_id,installment,amount_due,amount_paid,payment_method,status FROM payments WHERE quotation_id=? ORDER BY payment_id', [$id]);
    $q['rejection'] = one('SELECT * FROM quotation_rejections WHERE quotation_id=? ORDER BY rejection_id DESC LIMIT 1', [$id]);
    return $q;
}

/* ---------------- Projects ---------------- */
function set_project(int $pid, string $status): void { q('UPDATE projects SET status=? WHERE project_id=?', [$status, $pid]); }
/* A project is Done only when the installation is completed, everything is paid and the installation
   certificate was sent. Called after each of those steps; returns true when the project became Done. */
function try_finish_project(int $pid): bool {
    $p = one('SELECT p.status, p.install_status, q.quotation_id FROM projects p JOIN quotations q ON q.project_id=p.project_id WHERE p.project_id=?', [$pid]);
    if (!$p || $p['status'] === 'Done' || $p['install_status'] !== 'Completed') return false;
    if (one('SELECT 1 FROM payments WHERE quotation_id=? AND status<>"Confirmed"', [$p['quotation_id']])) return false;
    if (!one('SELECT 1 FROM project_certificates WHERE project_id=? AND sent_at IS NOT NULL', [$pid])) return false;
    finish_project($pid);
    return true;
}
/* Done: every receipt is released to the customer, and one email lists all the documents. */
function finish_project(int $pid): void {
    $p = one('SELECT * FROM projects WHERE project_id=?', [$pid]);
    q('UPDATE projects SET status="Done", end_date=COALESCE(end_date,CURDATE()), install_status="Completed" WHERE project_id=?', [$pid]);
    if ($p['inquiry_id']) q('UPDATE service_inquiries SET status="Completed" WHERE inquiry_id=?', [$p['inquiry_id']]);
    send_project_documents($pid);
}
/* Releases every receipt of the project to the customer and sends one notification + email listing all the documents.
   Used when the project becomes Done, and when the certificate is sent for a project that was already Done. */
function send_project_documents(int $pid): void {
    $p = one('SELECT * FROM projects WHERE project_id=?', [$pid]);
    $qt = one('SELECT quotation_id, quotation_no FROM quotations WHERE project_id=?', [$pid]);
    $docs = [];
    if ($qt) {
        q('UPDATE receipts r JOIN payments p USING(payment_id) SET r.sent_at=COALESCE(r.sent_at,NOW()) WHERE p.quotation_id=?', [$qt['quotation_id']]);
        $docs[] = 'Quotation ' . $qt['quotation_no'];
        $rc = array_column(all('SELECT r.receipt_no FROM receipts r JOIN payments p USING(payment_id) WHERE p.quotation_id=? ORDER BY r.payment_id', [$qt['quotation_id']]), 'receipt_no');
        if ($rc) $docs[] = (count($rc) > 1 ? 'Receipts ' : 'Receipt ') . implode(' and ', $rc);
    }
    $docs[] = 'Installation certificate and accomplishment report';
    if ($p['inquiry_id'])
        foreach (all('SELECT title FROM customer_documents WHERE customer_id=? AND inquiry_id=? AND document_type="Other"', [$p['customer_id'], $p['inquiry_id']]) as $d) $docs[] = preg_replace('/ - .*$/', '', $d['title']);
    notify_customer((int)$p['customer_id'], 'Project completed', 'Your project "' . $p['project_name'] . '" is complete. All your documents are ready under Documents in your account: ' . implode('; ', $docs) . '. Thank you for choosing BeyondWires.', 'project:' . $pid);
}
function refresh_payment_status(int $qid): void {
    $r = one('SELECT q.total_amount, COALESCE(SUM(CASE WHEN p.status="Confirmed" THEN p.amount_paid END),0) paid FROM quotations q LEFT JOIN payments p ON p.quotation_id=q.quotation_id WHERE q.quotation_id=? GROUP BY q.quotation_id', [$qid]);
    $st = $r['paid'] <= 0 ? 'Unpaid' : ($r['paid'] + 0.005 >= $r['total_amount'] ? 'Paid' : 'Partial');
    q('UPDATE quotations SET payment_status=? WHERE quotation_id=?', [$st, $qid]);
}
function receipt_data(int $paymentId): ?array {
    $r = one('SELECT r.receipt_no, r.issued_at, p.payment_id, p.installment, p.amount_paid, p.payment_method, p.payment_agreement, p.reference_no, q.quotation_no, q.total_amount,
                     u.first_name, u.last_name, u.email, i.installation_address, ia.first_name issued_first, ia.last_name issued_last
              FROM receipts r JOIN payments p ON p.payment_id=r.payment_id JOIN quotations q ON q.quotation_id=p.quotation_id
              JOIN customers c ON c.customer_id=p.customer_id JOIN users u ON u.user_id=c.user_id JOIN service_inquiries i ON i.inquiry_id=q.inquiry_id
              JOIN users ia ON ia.user_id=r.issued_by WHERE r.payment_id=?', [$paymentId]);
    // receipts issued before this one for the same quotation (listed on the final receipt)
    if ($r) $r['earlier'] = all('SELECT r2.receipt_no, r2.issued_at, p2.installment, p2.amount_paid FROM payments p2 JOIN receipts r2 ON r2.payment_id=p2.payment_id
                                 WHERE p2.quotation_id=(SELECT quotation_id FROM payments WHERE payment_id=?) AND p2.status="Confirmed" AND p2.payment_id<? ORDER BY p2.payment_id', [$paymentId, $paymentId]);
    if ($r) $r['balance'] = round((float)$r['total_amount'] - (float)(one('SELECT COALESCE(SUM(amount_paid),0) s FROM payments WHERE quotation_id=(SELECT quotation_id FROM payments WHERE payment_id=?) AND status="Confirmed"', [$paymentId])['s']), 2);
    return $r;
}

set_exception_handler(function (Throwable $e) {
    error_log('[BW] ' . $e->getMessage() . ' @ ' . $e->getFile() . ':' . $e->getLine());
    fail('Something went wrong on the server.', 500);
});
