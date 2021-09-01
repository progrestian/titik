data=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | jc --upower | jq '.[0].detail')
text=$(echo "$data" | jq '.percentage')
state=$(echo "$data" | jq -r '.state')

if [ "100" = "$text" ]; then
  text="**"
fi

if [ "fully-charged" = "$state" ]; then
  tooltip='('"$state"')'
elif [ "charging" = "$state" ]; then
  tooltip=$(echo "$data" | jq -j '.time_to_full, " ", .time_to_full_unit, " ('"$state"')"')
elif [ "discharging" = "$state" ]; then
  tooltip=$(echo "$data" | jq -j '.time_to_empty, " ", .time_to_empty_unit, " ('"$state"')"')
fi

echo "{ \"text\": \"$text\", \"tooltip\": \"$tooltip\" }" | jq --unbuffered --compact-output

