if [ -z "$(pidof steam)" ]; then
  swaymsg "workspace steam; exec flatpak run com.valvesoftware.Steam;";
else
  swaymsg "workspace steam;";
fi
