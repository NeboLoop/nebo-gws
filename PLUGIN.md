---
name: gws
description: "Google Workspace CLI binary. Provides access to Gmail, Calendar, Drive, Sheets, Docs, Chat, Meet, Tasks, and Admin APIs. Skills depend on this plugin to get the gws binary via $GWS_BIN."
version: "0.22.3"
source: https://github.com/googleworkspace/cli
license: Apache-2.0
---

# gws — Google Workspace CLI

Managed binary wrapping [googleworkspace/cli](https://github.com/googleworkspace/cli). Reads Google's Discovery Service at runtime and builds its command surface dynamically, covering every Google Workspace API. Skills access the binary path via `$GWS_BIN`.

## Services

| Skill | Capability |
|-------|-----------|
| `gws-shared` | Shared auth, global flags, output formatting |
| `gws-gmail` | Send, read, and manage email |
| `gws-calendar` | Manage calendars and events |
| `gws-drive` | Manage files, folders, and shared drives |
| `gws-sheets` | Read and write spreadsheets |
| `gws-docs` | Read and write Google Docs |
| `gws-slides` | Read and write presentations |
| `gws-chat` | Manage Chat spaces and messages |
| `gws-meet` | Manage Google Meet conferences |
| `gws-tasks` | Manage task lists and tasks |
| `gws-people` | Manage contacts and profiles |
| `gws-forms` | Read and write Google Forms |
| `gws-keep` | Manage Google Keep notes |
| `gws-classroom` | Manage classes, rosters, and coursework |
| `gws-admin-reports` | Audit logs and usage reports |
| `gws-events` | Subscribe to Google Workspace events |
| `gws-script` | Manage Google Apps Script projects |
| `gws-modelarmor` | Filter content for safety |
| `gws-workflow` | Cross-service productivity workflows |

## Helpers

Shortcut skills for common actions:

| Skill | Action |
|-------|--------|
| `gws-gmail-send` | Send an email |
| `gws-gmail-read` | Read a message body or headers |
| `gws-gmail-reply` | Reply to a message |
| `gws-gmail-reply-all` | Reply-all to a message |
| `gws-gmail-forward` | Forward a message |
| `gws-gmail-triage` | Unread inbox summary |
| `gws-gmail-watch` | Watch for new emails (NDJSON stream) |
| `gws-calendar-agenda` | Show upcoming events across calendars |
| `gws-calendar-insert` | Create a new event |
| `gws-drive-upload` | Upload a file |
| `gws-sheets-read` | Read values from a spreadsheet |
| `gws-sheets-append` | Append a row to a spreadsheet |
| `gws-docs-write` | Append text to a document |
| `gws-chat-send` | Send a message to a space |
| `gws-script-push` | Upload files to an Apps Script project |
| `gws-events-subscribe` | Subscribe to Workspace events |
| `gws-events-renew` | Renew event subscriptions |
| `gws-modelarmor-sanitize-prompt` | Sanitize a user prompt |
| `gws-modelarmor-sanitize-response` | Sanitize a model response |
| `gws-modelarmor-create-template` | Create a Model Armor template |
| `gws-workflow-standup-report` | Today's meetings + tasks as standup |
| `gws-workflow-meeting-prep` | Prepare for next meeting |
| `gws-workflow-email-to-task` | Convert email to task |
| `gws-workflow-weekly-digest` | Weekly meeting + email summary |
| `gws-workflow-file-announce` | Announce a Drive file in Chat |

## Personas

Role-based agent personas that combine multiple services:

| Skill | Role |
|-------|------|
| `persona-exec-assistant` | Manage schedule, inbox, and communications |
| `persona-project-manager` | Track tasks, schedule meetings, share docs |
| `persona-team-lead` | Run standups, coordinate tasks, communicate |
| `persona-sales-ops` | Track deals, schedule calls, client comms |
| `persona-hr-coordinator` | Onboarding, announcements, employee comms |
| `persona-it-admin` | Monitor security, configure Workspace |
| `persona-event-coordinator` | Scheduling, invitations, logistics |
| `persona-content-creator` | Create and distribute content |
| `persona-customer-support` | Track tickets, respond, escalate |
| `persona-researcher` | Manage references, notes, collaboration |

## Recipes

Multi-step workflow templates:

| Skill | What it does |
|-------|-------------|
| `recipe-save-email-attachments` | Save Gmail attachments to Drive |
| `recipe-draft-email-from-doc` | Use a Doc as email body |
| `recipe-email-drive-link` | Share a Drive file via email |
| `recipe-create-gmail-filter` | Auto-label/categorize messages |
| `recipe-label-and-archive-emails` | Label and archive matching emails |
| `recipe-forward-labeled-emails` | Forward labeled emails |
| `recipe-create-vacation-responder` | Set up out-of-office reply |
| `recipe-save-email-to-doc` | Archive email body to a Doc |
| `recipe-create-events-from-sheet` | Create calendar events from spreadsheet rows |
| `recipe-schedule-recurring-event` | Create recurring events with attendees |
| `recipe-reschedule-meeting` | Move an event and notify attendees |
| `recipe-batch-invite-to-event` | Add attendees to an event |
| `recipe-block-focus-time` | Create recurring focus time blocks |
| `recipe-find-free-time` | Find meeting slots across calendars |
| `recipe-share-event-materials` | Share Drive files with event attendees |
| `recipe-plan-weekly-schedule` | Review calendar week and fill gaps |
| `recipe-bulk-download-folder` | Download all files from a Drive folder |
| `recipe-organize-drive-folder` | Create folder structure and move files |
| `recipe-find-large-files` | Find large files consuming quota |
| `recipe-share-folder-with-team` | Share a folder with collaborators |
| `recipe-create-shared-drive` | Create a Shared Drive with members |
| `recipe-watch-drive-changes` | Subscribe to Drive change notifications |
| `recipe-backup-sheet-as-csv` | Export a Sheet as CSV |
| `recipe-compare-sheet-tabs` | Compare two Sheet tabs for differences |
| `recipe-copy-sheet-for-new-month` | Duplicate a template tab for new month |
| `recipe-create-expense-tracker` | Set up expense tracking spreadsheet |
| `recipe-log-deal-update` | Append deal update to sales tracker |
| `recipe-generate-report-from-sheet` | Create a Docs report from Sheet data |
| `recipe-sync-contacts-to-sheet` | Export contacts to a spreadsheet |
| `recipe-create-doc-from-template` | Copy and fill a Doc template |
| `recipe-share-doc-and-notify` | Share a Doc and email collaborators |
| `recipe-create-presentation` | Create a Slides presentation |
| `recipe-collect-form-responses` | Retrieve Google Form responses |
| `recipe-create-feedback-form` | Create a feedback form and share via email |
| `recipe-create-classroom-course` | Create a Classroom course |
| `recipe-create-meet-space` | Create a Meet space and share link |
| `recipe-review-meet-participants` | Review Meet attendance |
| `recipe-create-task-list` | Set up a task list with initial tasks |
| `recipe-review-overdue-tasks` | Find past-due tasks |
| `recipe-post-mortem-setup` | Create post-mortem doc, schedule review, notify via Chat |
| `recipe-send-team-announcement` | Announce via Gmail and Chat |
