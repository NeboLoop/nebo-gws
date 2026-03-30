---
name: gws
description: "Google Workspace CLI binary. Provides access to Gmail, Calendar, Drive, Sheets, Docs, Chat, Meet, Tasks, and Admin APIs. Skills depend on this plugin to get the gws binary via $GWS_BIN."
version: "0.22.3"
source: https://github.com/googleworkspace/cli
license: Apache-2.0
---

# gws — Google Workspace CLI

Managed binary wrapping [googleworkspace/cli](https://github.com/googleworkspace/cli). Reads Google's Discovery Service at runtime and builds its command surface dynamically, covering every Google Workspace API.

## Env Var

Skills access the binary path via `$GWS_BIN`.

## Supported APIs

Gmail, Calendar, Drive, Sheets, Docs, Chat, Meet, Tasks, Admin, Apps Script, and any API published via Google's Discovery Service.
