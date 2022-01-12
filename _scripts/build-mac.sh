flutter build macos --release

mkdir drops
test -f ./drops/Rocket-Installer.dmg && rm ./drops/Rocket-Installer.dmg
create-dmg \
  --volname "Rocket Installer" \
  --window-pos 200 120 \
  --window-size 800 529 \
  --icon-size 130 \
  --text-size 14 \
  --icon "rocket.app" 260 250 \
  --hide-extension "rocket.app" \
  --app-drop-link 540 250 \
  --hdiutil-quiet \
  "./drops/Rocket-Installer.dmg" \
  "../build/macos/Build/Products/Release/rocket.app"