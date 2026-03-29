# plugin-gws

Nebo plugin wrapping the [Google Workspace CLI](https://github.com/googleworkspace/cli) (`gws`).

Provides managed binary distribution for Gmail, Calendar, Drive, Sheets, Docs, Chat, and Meet.

## How it works

Nebo's plugin system auto-downloads the `gws` binary during skill install. Agents access it via the `$GWS_BIN` environment variable. Zero setup for end users.

## Updating to a new gws release

```bash
# Download binaries + update plugin.json hashes
make download VERSION=v0.22.3

# Verify manifest
make manifest

# Upload to NeboLoop (get TOKEN from binary-token MCP call)
SKILL_ID=... TOKEN=... make upload

# Clean up
make clean
```

To use the latest release automatically:

```bash
make download
```

## Platforms

| Nebo Platform   | Upstream Asset                          |
|-----------------|-----------------------------------------|
| macos-arm64     | aarch64-apple-darwin                    |
| macos-amd64     | x86_64-apple-darwin                     |
| linux-arm64     | aarch64-unknown-linux-gnu               |
| linux-amd64     | x86_64-unknown-linux-gnu                |
| windows-amd64   | x86_64-pc-windows-msvc                  |

> Note: windows-arm64 is not available upstream.

## License

Apache 2.0 (matching upstream gws license).
