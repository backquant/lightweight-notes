#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

ARCH="$(uname -m)"
mkdir -p .build

swiftc -O \
  -target "${ARCH}-apple-macos26.0" \
  -parse-as-library \
  -o .build/Notetaker \
  Sources/Notetaker/*.swift

APP="BackQuant Notes.app"
rm -rf "Notetaker.app"
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS"
mkdir -p "$APP/Contents/Resources"
cp .build/Notetaker "$APP/Contents/MacOS/Notetaker"

ICON_SRC=""
for cand in icon.png AppIcon.png smalllogowhite.png; do
  if [ -f "$cand" ]; then ICON_SRC="$cand"; break; fi
done

ICON_LINE=""
if [ -n "$ICON_SRC" ]; then
  ISET=".build/AppIcon.iconset"
  rm -rf "$ISET"
  mkdir -p "$ISET"
  for spec in "16 16x16" "32 16x16@2x" "32 32x32" "64 32x32@2x" \
              "128 128x128" "256 128x128@2x" "256 256x256" \
              "512 256x256@2x" "512 512x512" "1024 512x512@2x"; do
    set -- $spec
    sips -z "$1" "$1" "$ICON_SRC" --out "$ISET/icon_$2.png" >/dev/null
  done
  iconutil -c icns "$ISET" -o "$APP/Contents/Resources/AppIcon.icns"
  ICON_LINE='  <key>CFBundleIconFile</key><string>AppIcon</string>'
fi

cat > "$APP/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleExecutable</key><string>Notetaker</string>
  <key>CFBundleIdentifier</key><string>com.backquant.notes</string>
  <key>CFBundleName</key><string>BackQuant Notes</string>
  <key>CFBundleDisplayName</key><string>BackQuant Notes</string>
${ICON_LINE}
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>CFBundleVersion</key><string>1</string>
  <key>CFBundleShortVersionString</key><string>1.0</string>
  <key>LSMinimumSystemVersion</key><string>26.0</string>
  <key>NSHighResolutionCapable</key><true/>
</dict>
</plist>
PLIST

codesign --force --deep --sign - "$APP" >/dev/null 2>&1 || true

echo "Built $APP"
echo "Run with: open $APP   (or move to /Applications)"
