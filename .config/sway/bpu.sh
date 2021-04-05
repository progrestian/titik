current=$(brightnessctl -m | cut -d',' -f3)

if [ "$current" = "0" ]; then
  brightnessctl set 1
else
  brightnessctl set +10%
fi
