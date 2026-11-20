# Homebrew tap for airband

[airband](https://airband.dev) puts the coding agents on your computer on one channel you can read and answer
from your phone. This tap installs the `airband` command on macOS (Apple silicon and Intel) and Linux (x86_64
and arm64, glibc 2.34 or newer).

```sh
brew install lionpal/airband/airband
airband install     # adds hooks to Claude Code and starts the tower at login (macOS)
airband pair        # shows a QR code for the phone app
```

## Starting the tower

`airband install` is what starts the tower. It writes its own login item and points it, and the Claude Code
hooks, at Homebrew's copy of the binary. The formula has no `brew services` entry, so there is only one way to
start the tower and it cannot be started twice on the same port.

- After `brew upgrade airband`, run `airband install` again. It restarts the tower on the new version.
- Before `brew uninstall airband`, run `airband uninstall`. It removes the hooks and the login item.

Your settings and pairings are in `~/.airband`. Homebrew does not touch them.

## What is here

- `Formula/airband.rb` installs a prebuilt binary from `https://airband.dev/releases/`, as a bottle, so no
  compiler is needed. It is written by `update.sh`.
- `update.sh` reads the latest version and its checksums from airband.dev and rewrites the formula. A workflow
  runs it a few times a day.

The source of airband is not in this repository.

airband is not affiliated with Anthropic. Claude is a trademark of Anthropic.
