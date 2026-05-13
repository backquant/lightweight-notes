# BackQuant Notes

An ultra-lightweight macOS notepad. Lives in a window and in the menu bar. Notes auto-save as plain `.md` files in `~/Documents/Notetaker/` so you own your data — open, edit, sync or back them up however you like.

## Features

- Sidebar of all your notes — click to open, double-click to rename, right-click for more
- Auto-save (~400ms after you stop typing)
- Resizable, collapsible sidebar
- Zoom (⌘+ / ⌘− / ⌘0) with size persisted
- In-note search (⌘F)
- Drag images into the editor to attach them (saved to `~/Documents/Notetaker/images/` and inserted as a markdown link)
- Lives in your menu bar too — click "NOTES" at the top of your screen
- Files are plain `.md` — open them in any other editor too

## Requirements

- macOS 26 (Tahoe) or newer
- Xcode installed (or Apple Command Line Tools with a working Swift toolchain)

To check Xcode is set as the active developer directory:
```bash
xcode-select -p
# Should print: /Applications/Xcode.app/Contents/Developer
```
If not, run:
```bash
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

## Install

```bash
git clone https://github.com/backquant/lightweight-notes.git
cd lightweight-notes
./build.sh
```

This produces `BackQuant Notes.app` in the project folder.

To install permanently, drag it into `/Applications`:
```bash
mv "BackQuant Notes.app" /Applications/
open "/Applications/BackQuant Notes.app"
```

To launch it on login: **System Settings → General → Login Items → +** and pick the app.

## Custom icon

Drop a PNG named `icon.png` (1024×1024 recommended) at the project root, then re-run `./build.sh`. It'll be turned into a proper macOS `.icns` and baked into the bundle.

## Keyboard shortcuts

| Shortcut | Action |
| --- | --- |
| ⌘F | Find in current note |
| ⌘+ / ⌘= | Zoom in |
| ⌘− | Zoom out |
| ⌘0 | Reset zoom |
| ⌃⌘S | Toggle sidebar |

## Where your notes live

```
~/Documents/Notetaker/
  ├── Note 2026-05-13 1830.md
  ├── Shopping list.md
  └── images/
      └── img-20260513-183245.png
```

You can back this folder up with iCloud Drive, Dropbox, git, rsync — it's just files.

## Uninstall

```bash
rm -rf "/Applications/BackQuant Notes.app"
# Your notes stay in ~/Documents/Notetaker/ — delete that too if you want
```

## Tech

SwiftUI, single executable (~1MB), no dependencies. Built with `swiftc` directly — no Xcode project needed. See [build.sh](build.sh).
