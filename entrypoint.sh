#!/bin/sh

if [ "$(ls -A /home/chromium/.fonts/)" ]; then
  fc-cache -f -v
fi

dumb-init -- /usr/bin/chromium \
  --disable-background-networking \
  --disable-background-timer-throttling \
  --disable-default-apps \
  --disable-dev-shm-usage \
  --disable-gpu \
  --disable-extensions \
  --disable-search-engine-collection \
  --disable-sync \
  --disable-translate \
  --headless \
  --hide-scrollbars \
  --ignore-certificate-errors \
  --ignore-certificate-errors-spki-list \
  --ignore-ssl-errors \
  --metrics-recording-only \
  --mute-audio \
  --no-sandbox \
  --no-first-run \
  --remote-debugging-address=0.0.0.0 \
  --remote-debugging-port=9222 \
  --safebrowsing-disable-auto-update \
  --set-ipv6-probe-false \
  --user-data-dir=/home/chromium/