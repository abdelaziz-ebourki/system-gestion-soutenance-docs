# Functional Requirements — Plateforme de Gestion des Soutenances Académiques (PFE, Mémoire, Thèse)

> **Scope:** All functional capabilities the system must provide, organized by domain.
> **Legend:** `[F-XXX]` = Function ID. Priority: **P0**=MVP (must-have), **P1**=v1.1 (should-have), **P2**=v2.0 (nice-to-have).
> **Status markers:** `— ✅` implemented, `— ⚠️ partial` partially implemented, no marker = not started.
> Functions marked with **✦** are additions beyond the original PRD.

---

# F1 — Authentication & Security

## F1.1 Login — ✅
User authenticates with email/username + password. System issues a JWT token with expiry.  
**Actor:** All | **Priority:** P0

## F1.2 Logout — ✅
User explicitly logs out; token is invalidated server-side.  
**Actor:** All | **Priority:** P0

## F1.3 Role-Based Access Control (RBAC) — ✅
Every endpoint and UI route enforces role permissions. Unauthorized access returns 403.  
**Actor:** System | **Priority:** P0

## F1.4 Password Reset ✦
User requests a password reset via email link. Link expires after 1 hour.  
**Actor:** All | **Priority:** P0

## F1.5 Account Verification ✦ — ✅
New users verify their email via a token sent at account creation. Unverified accounts cannot log in.  
**Actor:** System | **Priority:** P0

## F1.6 JWT Token Refresh ✦
Access tokens expire after configurable duration (default 24h). A refresh token (30-day expiry) allows silent renewal.  
**Actor:** System | **Priority:** P1

## F1.7 Multi-Factor Authentication ✦
Optional TOTP-based 2FA for admin accounts.  
**Actor:** Admin | **Priority:** P2

## F1.8 Session Management ✦
Users can view and revoke active sessions from their profile.  
**Actor:** All | **Priority:** P1

## F1.9 Password Strength Policy ✦ — ✅
System enforces minimum password strength (length ≥ 8, mixed case, digits, special chars). Uses zxcvbn or similar for scoring.  
**Actor:** System | **Priority:** P0

---

# F2 — Institution Structure Management

## F2.2 Manage Faculties/Universities/Schools — ✅
Admin manages University/Faculty/School (ie: name, logo, ...)  
**Actor:** Admin | **Priority:** P0

## F2.3 Manage Departments — ✅
CRUD for departments within a faculty.  
**Actor:** Admin | **Priority:** P0

## F2.4 Manage Majors/Filières — ✅
CRUD for academic majors/programs within a department.  
**Actor:** Admin | **Priority:** P0

## F2.5 Manage Study Levels ✦ — ✅
CRUD for academic levels (e.g., L1–L3, M1–M2) within a major.  
**Actor:** Admin | **Priority:** P1

## F2.6 Manage Rooms — ✅
CRUD for rooms/amphitheaters. Each room has capacity, equipment list, and building/location.  
**Actor:** Admin | **Priority:** P0

---

# F3 — User Management

## F3.1 Create User — ✅
Admin creates a user with role, email, name, and institutional affiliation. System sends account verification email.  
**Actor:** Admin | **Priority:** P0

## F3.2 Bulk Import Users ✦ — ✅
Admin imports users from CSV/Excel. System validates each row and reports errors per row (invalid email, missing field, duplicate). Partial imports allowed.  
**Actor:** Admin | **Priority:** P0

## F3.3 Bulk Export Users ✦
Admin exports filtered user list to CSV/Excel.  
**Actor:** Admin | **Priority:** P1

## F3.4 Edit User — ✅
Admin updates user profile fields, role, or status.  
**Actor:** Admin | **Priority:** P0

## F3.5 Deactivate / Activate User — ✅
Admin can suspend a user account. Suspended users cannot log in.  
**Actor:** Admin | **Priority:** P0

## F3.6 Delete User — ✅
Admin deletes a user. System blocks deletion if user has active dependencies (current defenses, evaluations). Soft-delete with audit trail.  
**Actor:** Admin | **Priority:** P0

## F3.7 Profile Management ✦ — ✅
Users update their own profile (name, contact info, photo). Teachers can set academic title and specializations.  
**Actor:** All | **Priority:** P0

## F3.8 User Search & Filtering ✦ — ✅
Admin can search users by name, email, role, department, status. Results paginated with server-side search.  
**Actor:** Admin | **Priority:** P0

---

# F4 — Session Management

## F4.1 Create Global Session — ✅
Admin creates a session (e.g., "Session Normale 2026") with start/end dates.  
**Actor:** Admin | **Priority:** P0

## F4.2 Edit Global Session — ✅
Admin modifies session metadata. Can only edit if no defenses are linked.  
**Actor:** Admin | **Priority:** P0

## F4.3 Archive Global Session — ✅
Admin archives a session. Archived sessions become immutable.  
**Actor:** Admin | **Priority:** P0

## F4.4 Clone Global Session ✦
Admin clones an existing session's configuration (rules, dates, settings) into a new session.  
**Actor:** Admin | **Priority:** P1

## F4.5 Create Defense Session — ✅
Coordinator creates a defense sub-session within a global session with specific dates, modification rules, and planning constraints.  
**Actor:** Coordinator | **Priority:** P0

## F4.6 Session Lifecycle Management — ✅
A defense session transitions through: Draft → Active → Scheduled → Completed → Archived. Actions are gated by current state.  
**Actor:** Coordinator, System | **Priority:** P0

## F4.7 Configure Session Rules — ✅
Coordinator sets per-session rules: enabled defense types (PFE, Mémoire, Thèse), max students per group, deadline for document submission, evaluation coefficients, jury size constraints, per-type defense duration.  
**Actor:** Coordinator | **Priority:** P0

---

# F5 — Group & Project Management

## F5.1 Create Group — ✅
Student creates a group (individual or team) within a session.  
**Actor:** Student | **Priority:** P0

## F5.2 Join Group ✦ — ✅
Student requests to join an existing group. Group leader (creator) accepts or rejects. System enforces max group size.  
**Actor:** Student | **Priority:** P0

## F5.3 Leave Group ✦ — ✅
Student leaves a group before project assignment. If leaving empties the group, group is deleted.  
**Actor:** Student | **Priority:** P0

## F5.4 Manage Groups (Admin) — ✅
Coordinator can create, edit, merge, split, or delete groups.  
**Actor:** Coordinator | **Priority:** P0

## F5.5 Create Project — ✅
Coordinator creates a project with title, description, keywords, required specializations, max students, and defense type (PFE, Mémoire, Thèse).  
**Actor:** Coordinator | **Priority:** P0

## F5.6 Assign Project to Group — ✅
Coordinator assigns a project to a group. A group can only have one project.  
**Actor:** Coordinator | **Priority:** P0

## F5.7 Assign Supervisor — ✅
Coordinator assigns a main supervisor and optionally co-supervisors (internal or external) to a group/project.  
**Actor:** Coordinator | **Priority:** P0

## F5.9 Group Dashboard ✦ — ✅
Group members see their project info, assigned supervisor(s), submission deadlines, and defense schedule.  
**Actor:** Student | **Priority:** P0

## F5.10 Student-Supervisor Support ✦ — ✅
A student (the specs of the student that can supervise are configurable) can also serve as a supervisor. The system handles this via:
- A `canSupervise: boolean` flag on the User entity, independent of primary role
- `Project.supervisorId` accepts any user ID, not just teachers
- Supervisor selection UI loads teachers + eligible students
- Student dashboard gains a "Supervised Projects" section when applicable
- RBAC checks supervision permission via relationship (`currentUser.id === Project.supervisorId`), not by role
**Actor:** System, Coordinator | **Priority:** P0

---

# F6 — Jury Management

## F6.1 Configure Jury Roles — ✅
Admin/Coordinator defines the jury structure template: roles (President, Rapporteur, Examinateur, Encadrant, Membre Externe) and count per role.  
**Actor:** Coordinator | **Priority:** P0

## F6.2 Assign Jury — ✅
Coordinator assigns teachers to jury roles for a specific defense. System enforces: no role conflicts (same person cannot hold two roles in one defense), no time conflicts (teacher assigned to two defenses at the same time).  
**Actor:** Coordinator | **Priority:** P0

## F6.3 Suggest Jury Automatically ✦
System suggests jury candidates based on specialization match, availability, and workload balancing. Coordinator can override.  
**Actor:** System | **Priority:** P1

## F6.4 View Jury Composition — ✅
Authorized users can see the jury for any published defense.  
**Actor:** All | **Priority:** P0

## F6.5 External Examiner Management ✦
Coordinator adds external examiners with name, affiliation, email. System generates temporal access for document review and evaluation submission.  
**Actor:** Coordinator | **Priority:** P1

## F6.6 Jury Workload Dashboard ✦
Coordinator sees a dashboard showing each teacher's jury assignment count per session to detect overloading.  
**Actor:** Coordinator | **Priority:** P1

## F6.7 Jury Edit/Delete ✦ — ✅
Coordinator can modify or remove an existing jury assignment. Editing preserves other jury members. Deleting a jury frees the associated teachers and notifies affected users. System enforces the same conflict rules as creation (no role cumul, no time conflict).  
**Actor:** Coordinator | **Priority:** P0

---

# F7 — Scheduling & Planning

## F7.1 Manual Scheduling — ✅
Coordinator drag-and-drops defenses onto a calendar view, assigning date, time slot, and room.  
**Actor:** Coordinator | **Priority:** P0

## F7.2 Automatic Scheduling
System generates a proposed schedule using priority-based heuristics, respecting: room capacity, teacher availability, no double-booking, session date bounds.  
**Actor:** System | **Priority:** P0

## F7.3 Conflict Detection — ✅
System detects and highlights conflicts: room double-booking, teacher double-booking, student double-booking, room capacity exceeded.  
**Actor:** System | **Priority:** P0

## F7.4 Conflict Resolution Dashboard ✦
Coordinator sees a dedicated view listing all detected conflicts with suggested resolutions. Each conflict can be resolved individually.  
**Actor:** Coordinator | **Priority:** P1

## F7.5 Declare Unavailability — ✅
Teachers mark date/time slots they are unavailable. Schedule planner takes these into account (both manual and auto).  
**Actor:** Teacher | **Priority:** P0

## F7.6 Bulk Unavailability Import ✦
Teachers can import unavailability from iCal or a CSV template.  
**Actor:** Teacher | **Priority:** P2

## F7.7 Publish Schedule
Coordinator publishes the defense schedule. Published schedule is visible to all actors. System sends notifications on publish.  
**Actor:** Coordinator | **Priority:** P0

## F7.8 Schedule Modification ✦
After publication, coordinator can submit a modification with a reason. System notifies all affected actors. Major changes (date/time change) require a confirmation step.  
**Actor:** Coordinator | **Priority:** P1

## F7.9 Schedule Modification Request (by Teacher) ✦
A teacher can request a schedule change, citing reason. Coordinator approves or rejects.  
**Actor:** Teacher | **Priority:** P1

## F7.10 Calendar Export ✦
Users can export their schedule to iCal/ICS format for external calendar integration (Google Calendar, Outlook).  
**Actor:** All | **Priority:** P1

## F7.11 Cancel Defense ✦
Coordinator cancels a scheduled defense. System notifies all affected actors and frees the time slot.  
**Actor:** Coordinator | **Priority:** P0

---

# F8 — Evaluation & Grading

## F8.1 Submit Evaluation — ✅
Jury members submit grades and remarks for each student in a defense. Uses configured evaluation criteria with custom coefficients.  
**Actor:** Teacher (Jury) | **Priority:** P0

## F8.2 Evaluation Criteria Configuration — ✅
Coordinator defines evaluation criteria within a session: criteria name, weight/coefficient, max score.  
**Actor:** Coordinator | **Priority:** P0

## F8.3 Automatic Grade Calculation — ✅
System calculates weighted average based on configured coefficients. Displays per-criteria breakdown.  
**Actor:** System | **Priority:** P0

## F8.4 Grade Validation Workflow ✦
Grades are initially provisional. Coordinator reviews and validates them. Validated grades are final and published to students.  
**Actor:** Coordinator | **Priority:** P1

## F8.5 Decision Assignment — ✅
Based on final grade, system assigns a decision: Admis, Admis avec corrections, Ajourné. Thresholds are configurable per session.  
**Actor:** System | **Priority:** P0

## F8.6 Grade Appeal ✦
Student can file a grade appeal within a configurable window after publication. Appeal includes reason and supporting documents. Coordinator reviews and either confirms or adjusts.  
**Actor:** Student | **Priority:** P1

## F8.7 Results Publication — ✅
Coordinator publishes results. Students can view their grades and decisions in their dashboard.  
**Actor:** Coordinator | **Priority:** P0

## F8.8 Anonymous Grading ✦
Optionally, jury members grade without seeing other jurors' scores. All scores become visible after validation.  
**Actor:** System | **Priority:** P2

---

# F9 — Document Management

## F9.1 Submit Document — ✅
Students upload documents (report/mémoire/thèse, slides, appendices) within the submission deadline. Document types required are determined by the defense type (PFE, Mémoire, Thèse). Supported formats: PDF, PPTX, DOCX, XLSX, ZIP.  
**Actor:** Student | **Priority:** P0

## F9.2 Document Deadline Enforcement — ✅
System blocks submissions after the configured deadline. A grace period (configurable) may be set with penalty flag.  
**Actor:** System | **Priority:** P0

## F9.3 View Documents — ✅
Jury members and supervisors can view/download submitted documents from the defense detail page.  
**Actor:** Teacher (Jury, Supervisor) | **Priority:** P0

## F9.4 Version Management ✦
Students can re-upload documents before the deadline. System keeps last N versions. All versions are visible to jury.  
**Actor:** Student, System | **Priority:** P1

## F9.5 Document Preview ✦
System generates in-browser preview for PDF and image files. Other formats show metadata with download prompt.  
**Actor:** System | **Priority:** P1

## F9.6 Maximum File Size ✦ — ✅
System enforces configurable per-file size limit (default 50 MB) and total per-group limit.  
**Actor:** System | **Priority:** P0

---

# F10 — Document Generation

## F10.1 Generate Convocation — ✅
System generates an individualized convocation PDF for each student, containing: date, time, room, jury composition. Uses a configurable template.  
**Actor:** Coordinator, System | **Priority:** P0

## F10.2 Generate Procès-Verbal (PV)
System generates a PV PDF for each defense session, containing: jury members, student names, project title, grades, decision, signatures.  
**Actor:** Coordinator, System | **Priority:** P0

## F10.3 Generate Certificate ✦
System generates a defense completion certificate with a configurable template for each student after successful defense (Admis decision).  
**Actor:** System | **Priority:** P1

## F10.4 Template Management ✦
Admin uploads and manages document templates (convocations, PVs, certificates) with placeholders for dynamic fields. With Defeault templates provided by the application  
**Actor:** Admin | **Priority:** P1

## F10.5 Bulk Document Generation ✦
Coordinator generates convocations or PVs for multiple defenses in one action. Download as individual files or a ZIP archive.  
**Actor:** Coordinator | **Priority:** P1

## F10.6 Generate Evaluation Sheets
System generates an evaluation sheet PDF for each defense, containing: evaluation criteria with weightings, per-juror scoring fields, remarks section. Uses a configurable template.  
**Actor:** Coordinator, System | **Priority:** P0

## F10.7 Generate Attendance Lists
System generates an attendance/presence list PDF for each defense session, listing all scheduled defenses with student names, jury members, time slots, and a signature column.  
**Actor:** Coordinator, System | **Priority:** P0

## F10.8 Generate Jury Convocations
System generates an individualized convocation PDF for each jury member, containing: student/project info, defense date/time/room, their assigned role. Separate from student convocation (F10.1).  
**Actor:** Coordinator, System | **Priority:** P0

## F10.9 Generate Printable Schedule
System generates a formatted PDF of the full defense schedule (calendar/grid view), suitable for posting or printing. Includes day-by-day breakdown with rooms and assigned juries.  
**Actor:** Coordinator, System | **Priority:** P0

---



# F11 — Notifications

## F11.1 In-App Notification — ✅
System displays notifications in the user's notification center (bell icon). Includes type, message, timestamp, read/unread status, and action link.  
**Actor:** System | **Priority:** P0

## F11.2 Email Notification
System sends transactional emails for key events: defense assignment, schedule publish, document deadline reminder, grade publication, schedule modification.  
**Actor:** System | **Priority:** P0

## F11.3 Automated Reminders ✦
System sends automated reminders: T-7 days for document submission deadline, T-24h for defense, T-1h for jury members. Configurable per session.  
**Actor:** System | **Priority:** P1

## F11.4 Notification Preferences ✦
Users configure which notification types they want to receive by email vs. in-app only.  
**Actor:** All | **Priority:** P1

## F11.5 Notification Templates ✦
Admin manages email notification templates with variable substitution.  
**Actor:** Admin | **Priority:** P2

---

# F12 — Reporting & Statistics

## F12.1 Statistics Dashboard — ✅
Coordinator sees aggregate stats: total defenses, pass rate, average grade, distribution of decisions, jury workload.  
**Actor:** Coordinator | **Priority:** P0

## F12.2 Configurable Reports ✦
Coordinator generates reports with filters: by session, department, major, supervisor, date range. Export to PDF/CSV.  
**Actor:** Coordinator | **Priority:** P1

## F12.3 Academic Performance Report ✦
Per-student or per-group report showing grades across all sessions.  
**Actor:** Coordinator | **Priority:** P2

## F12.4 Supervisor Workload Report ✦
Report showing number of supervised projects per teacher per session.  
**Actor:** Coordinator | **Priority:** P1

---

# F13 — Audit & Logging

## F13.1 Audit All Critical Operations — ✅
System logs every create, update, delete operation on: users, sessions, groups, projects, juries, schedules, grades, documents. Log includes: actor, action, timestamp, entity, old/new values.  
**Actor:** System | **Priority:** P0

## F13.2 Audit Log Viewer ✦ — ✅
Admin views, searches, and filters audit logs by: actor, entity type, action, date range. Results are paginated.  
**Actor:** Admin | **Priority:** P0

## F13.3 Audit Log Retention ✦
Logs are retained for a configurable period (default 1 year) then archived to cold storage.  
**Actor:** System | **Priority:** P1

## F13.4 Login History ✦
Admin can view login history for any user: timestamp, IP address, user agent, success/failure.  
**Actor:** Admin | **Priority:** P1

---

# F14 — Bulk Import & Export

## F14.1 Import Users ✦ — ✅
Admin imports users from CSV/Excel with columns: firstName, lastName, email, role, department, major. System validates and provides error report.  
**Actor:** Admin | **Priority:** P0

## F14.2 Import Projects
Coordinator imports projects from CSV/Excel.  
**Actor:** Coordinator | **Priority:** P1

## F14.3 Import Groups ✦
Coordinator imports group assignments from CSV/Excel.  
**Actor:** Coordinator | **Priority:** P1

## F14.4 Import Unavailability ✦
Teachers import their unavailability from CSV/Excel or iCal.  
**Actor:** Teacher | **Priority:** P2

## F14.5 Export All Data ✦
Admin exports selected entities (users, sessions, grades) to CSV/Excel with relational filters.  
**Actor:** Admin | **Priority:** P1

---

# F15 — Announcements ✦

## F15.1 Create Announcement
Coordinator creates an announcement (title, body, optional attachment).  
**Actor:** Coordinator | **Priority:** P1

## F15.2 Target Announcement
Coordinator targets announcement to specific actors (all students, students in a major, all teachers, jury members of a session).  
**Actor:** Coordinator | **Priority:** P1

## F15.3 View Announcements
Users see relevant announcements in their dashboard. Read/unread tracking.  
**Actor:** All | **Priority:** P1

---

# F16 — System Configuration ✦

## F16.1 General Settings — ✅
Admin configures: institution name, logo, academic year label, timezone, date format.  
**Actor:** Admin | **Priority:** P0

## F16.2 Session Defaults
Admin sets default values for new sessions: max group size, evaluation threshold, submission deadline policy.  
**Actor:** Admin | **Priority:** P1

## F16.3 Email Configuration ✦
Admin configures SMTP settings, sender name, reply-to address.  
**Actor:** Admin | **Priority:** P0

## F16.4 Document Configuration ✦ — ✅
Admin sets max file size, allowed file extensions, version limit.  
**Actor:** Admin | **Priority:** P0

## F16.5 Defense Type Configuration ✦
Admin enables/disables defense types (PFE, Mémoire, Thèse), configures their labels, default duration, required document types, and default jury role templates per type.  
**Actor:** Admin | **Priority:** P0

## F16.6 Terminology Customization ✦
Admin customizes domain-specific labels used throughout the UI: defense type names, role titles (e.g., "Rapporteur" → "Examinateur"), document category names, decision labels. Changes apply in real time without redeploy.  
**Actor:** Admin | **Priority:** P1

---

# F17 — UI & UX ✦

## F17.1 Responsive Design — ✅
All pages are usable on desktop (≥1024px). Key student and teacher pages are responsive down to tablet/phone.  
**Actor:** System | **Priority:** P0

## F17.2 Light / Dark Mode ✦ — ✅
Application supports theme toggle. Default follows system preference.  
**Actor:** All | **Priority:** P1

## F17.3 Multi-Language Support ✦
UI supports French and English. Language switcher in the header. Content added by admins (announcements, etc.) can be tagged with language.  
**Actor:** System | **Priority:** P2

## F17.4 Search Across Entities ✦
Global search bar accessible from the header. Searches users, projects, groups, sessions. Results are categorized.  
**Actor:** All | **Priority:** P1

## F17.5 Keyboard Navigation ✦
All interactive elements are keyboard-accessible. Calendar and scheduling views support keyboard drag-and-drop.  
**Actor:** System | **Priority:** P1

## F17.6 404 / Error Pages — ✅
User-friendly pages for 404 (not found), 403 (forbidden), and generic error states.  
**Actor:** System | **Priority:** P0

## F17.7 Loading, Empty, and Error States ✦ — ✅
Every list, detail, and dashboard page must handle three states beyond the happy path:
- **Loading:** Skeleton rows, spinner, or shimmer placeholder while data is being fetched (no flash of previous data)
- **Empty:** Contextual empty-state message with illustration and suggested action (e.g., "No sessions yet. Create your first session." instead of a generic "Aucun résultat.")
- **Error:** Error banner or inline alert with a retry button when an API call fails (no silent failure or white screen)
**Actor:** System | **Priority:** P0

---

# F18 — External Integrations ✦

## F18.1 Calendar Sync
Defense schedule can be exported to iCal format. Optionally, one-way sync to Google Calendar via OAuth.  
**Actor:** All | **Priority:** P2

## F18.2 LDAP / SSO ✦
Optional integration with university LDAP or SAML/SSO for authentication.  
**Actor:** Admin | **Priority:** P2

## F18.3 API for External Systems ✦
REST API documented with OpenAPI/Swagger. Rate-limited. API keys for machine-to-machine communication (e.g., integrating with university portal).  
**Actor:** System | **Priority:** P2

---

# F19 — Deployment & Packaging ✦

## F19.1 Docker Compose Deployment
Single `docker compose up` command to run the full stack (frontend, API, database, mail server). Includes `.env.example` with all configurable variables documented.  
**Actor:** Admin (DevOps) | **Priority:** P0

## F19.2 Seed Data & Defaults
Fresh installation comes with sensible seed data: default admin account, sample departments/majors, pre-configured defense types (PFE, Mémoire, Thèse) with appropriate defaults, sample jury role templates, and example document categories. Institution can go live immediately after changing the name/logo.  
**Actor:** System | **Priority:** P0

## F19.3 Health Check & Monitoring
Application exposes a `/health` endpoint. Docker health checks configured for all services. Prometheus metrics optional.  
**Actor:** System | **Priority:** P1

## F19.4 Backup & Restore
Automated database backup script (pg_dump / SQLite backup). Restore procedure documented. Backup before migrations.  
**Actor:** Admin (DevOps) | **Priority:** P1

## F19.5 Upgrade Migration Scripts
Database schema migrations with rollback support. Upgrade path between versions documented. Changelog per release.  
**Actor:** System | **Priority:** P1

## F19.6 First-Run Setup Wizard ✦ — ⚠️ partial
On first login (no admin exists), the app detects empty state and guides the admin through: password change, institution name/logo, timezone, date format, enabling defense types. After setup, the wizard never shows again.  
**Actor:** System | **Priority:** P0
