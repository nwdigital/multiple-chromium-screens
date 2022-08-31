# This script will launch 3 chromium browsers in fullscreen on different screens based on the sizes values
# sizes values must be in the format x,y format with one x,y per line
# The sites values must also be one url per line

sleep 10;

while true

do
  killall /snap/chromium/2051/usr/lib/chromium-browser/chrome # Kill all chromium sessions
  export DISPLAY=:0.0 # set the display to the logged in desktop

  GetTempDir()
  {
    rand=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w20 | head -n1)
    temp="/home/fcpadmin/chromium-tmp-$rand"
    mkdir $temp
  }

  LaunchBrowser()
  {
    chromium-browser \
      --start-fullscreen \
      --test-type \
      --ignore-certificate-errors \
      --disable-notifications \
      --hide-crash-restore-bubble \
      --no-first-run \
      --new-window \
      --disable-restore-session-state \
      --no-default-browser-check \
      --disable-java \
      --disable-client-side-phishing-detection \
      --window-size=1920,1080 \
      --window-position=$2 \
      --user-data-dir=$3 \
      --force-device-scale-factor=1 \
      --allow-http-background-page \
      --allow-insecure-localhost \
      --allow-running-insecure-content \
      --unsafely-treat-insecure-origin-as-secure=http://fcp.local,https://fcp.local,https://crn-pa-01.fcp.local \
    $1 &
  }

  sites=(
    "https://bclk.app/i/cc75a5e69d" # PRTG Top 10 Lists
    "https://bclk.app/i/dcbbc6105b" # PRTG Crandon Overview
    "https://bclk.app/i/119938b850" # Crandon vSphere - Overview
  )

  sizes=(
    0,0
    2000,0
    4000,0
  )

  dir=(
    "/home/fcpadmin/chrome-1"
    "/home/fcpadmin/chrome-2"
    "/home/fcpadmin/chrome-3"
  )

  for ((i = 0; i < ${#sites[@]}; ++i)); do
    #GetTempDir
    #echo "${sites[$i]}" "${sizes[$i]}"
    LaunchBrowser "${sites[$i]}" "${sizes[$i]}" "${dir[$i]}"
  done

  sleep 300

done
