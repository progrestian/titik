current=$(brightnessctl -m | cut -d',' -f4)

if [ "$current" = "10%" ]; then
  brightnessctl set 1
else
  brightnessctl set 10%-
fi
