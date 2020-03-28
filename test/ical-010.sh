#!/bin/sh
# ical export: encoded summary TEXT (escaped characters).

. "${TEST_INIT:-./test-init.sh}"

if [ "$1" = 'actual' ]; then
  mkdir .calcurse || exit 1
  cp "$DATA_DIR/conf" .calcurse || exit 1
  cp "$DATA_DIR/apts-export" .calcurse/apts || exit 1
  cp "$DATA_DIR/todo-export" .calcurse/todo || exit 1
  "$CALCURSE" -D "$PWD/.calcurse" --export=ical | sed '/^PRODID/d'
  rm -rf .calcurse || exit 1
elif [ "$1" = 'expected' ]; then
  cat <<EOD
BEGIN:VCALENDAR
VERSION:2.0
BEGIN:VEVENT
DTSTART;VALUE=DATE:20200226
SUMMARY:Exported\, escaped characters in SUMMARY: \,(comma)\, \;(semicolon) \, and \\\\(escape).
END:VEVENT
BEGIN:VEVENT
DTSTART:20200226T070900
DURATION:P0DT0H1M0S
SUMMARY:Exported\, escaped characters in SUMMARY: \,(comma)\, \;(semicolon) \, and \\\\(escape).
END:VEVENT
BEGIN:VTODO
PRIORITY:1
SUMMARY:Exported\, escaped characters in SUMMARY: \,(comma)\, \;(semicolon) \, and \\\\(escape).
END:VTODO
END:VCALENDAR
EOD
else
  ./run-test "$0"
fi
