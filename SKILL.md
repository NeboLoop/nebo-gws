---
name: gws
description: "Use this skill to interact with Google Workspace: send and read Gmail, manage Calendar events, list and upload Drive files, read and write Sheets, create and edit Docs, and manage Chat spaces. Triggers include any mention of Gmail, Google Calendar, Google Drive, Google Sheets, Google Docs, Google Chat, or Google Meet."
plugins:
  - name: gws
    version: ">=0.22.0"
---

# Google Workspace CLI (gws)

Access Google Workspace APIs via the `gws` command-line tool. The binary path is available as `$GWS_BIN`.

## Authentication

Before first use, the user must authenticate:

```bash
$GWS_BIN auth login
```

This opens a browser for OAuth consent. Credentials are stored locally. To check auth status:

```bash
$GWS_BIN auth status
```

## Gmail

```bash
# List recent messages
$GWS_BIN gmail messages list --max-results 10

# Read a message
$GWS_BIN gmail messages get <message-id>

# Send an email
$GWS_BIN gmail messages send --to "user@example.com" --subject "Subject" --body "Body text"

# Search messages
$GWS_BIN gmail messages list --query "from:boss@company.com is:unread"

# List labels
$GWS_BIN gmail labels list
```

## Calendar

```bash
# List upcoming events
$GWS_BIN calendar events list --max-results 10

# Get today's agenda
$GWS_BIN calendar events list --time-min "$(date -u +%Y-%m-%dT00:00:00Z)" --time-max "$(date -u +%Y-%m-%dT23:59:59Z)"

# Create an event
$GWS_BIN calendar events insert --summary "Meeting" --start "2024-01-15T10:00:00" --end "2024-01-15T11:00:00" --attendees "user@example.com"

# Delete an event
$GWS_BIN calendar events delete <event-id>
```

## Drive

```bash
# List files
$GWS_BIN drive files list --max-results 20

# Search files
$GWS_BIN drive files list --query "name contains 'report'"

# Upload a file
$GWS_BIN drive files create --name "report.pdf" --file ./report.pdf

# Download a file
$GWS_BIN drive files get <file-id> --output ./downloaded-file

# Create a folder
$GWS_BIN drive files create --name "New Folder" --mime-type "application/vnd.google-apps.folder"
```

## Sheets

```bash
# Read a range
$GWS_BIN sheets spreadsheets values get <spreadsheet-id> --range "Sheet1!A1:D10"

# Append rows
$GWS_BIN sheets spreadsheets values append <spreadsheet-id> --range "Sheet1!A1" --values '[["Name","Score"],["Alice","95"]]'

# Update a range
$GWS_BIN sheets spreadsheets values update <spreadsheet-id> --range "Sheet1!A1:B2" --values '[["Updated","Data"]]'
```

## Docs

```bash
# Get document content
$GWS_BIN docs documents get <document-id>

# Create a new document
$GWS_BIN docs documents create --title "New Document"

# Insert text
$GWS_BIN docs documents batch-update <document-id> --requests '[{"insertText":{"location":{"index":1},"text":"Hello World"}}]'
```

## Chat

```bash
# List spaces
$GWS_BIN chat spaces list

# Send a message
$GWS_BIN chat spaces messages create <space-name> --text "Hello from gws"

# List messages in a space
$GWS_BIN chat spaces messages list <space-name>
```

## Safety Rules

1. **Always confirm before sending** emails, creating events with attendees, or modifying shared documents
2. **Use `--dry-run`** when available to preview changes before executing
3. **Never bulk-delete** without explicit user confirmation
4. **Show the user** the content of any email or message before sending
5. **Prefer read operations** — list/get before create/update/delete
6. **Respect rate limits** — avoid rapid repeated calls to the same API
