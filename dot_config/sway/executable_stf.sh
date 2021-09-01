if [ -z "$(pidof firefox)" ]; then
  swaymsg "workspace firefox; exec firefox;";
else
  swaymsg "workspace firefox;";
fi
