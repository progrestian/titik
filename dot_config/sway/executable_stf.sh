if [ -z "$(pidof firefox)" ]; then
  swaymsg "workspace firefox; exec firefox-wayland;";
else
  swaymsg "workspace firefox;";
fi
