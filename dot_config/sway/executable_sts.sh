if [ -z "$(pidof steam)" ]; then
  swaymsg "workspace steam; exec flatpak run com.valvesoftware.Steam;";
else
  swaymsg "[class=\"Steam\" title=\"Friends List\"] resize set width 820px"
  swaymsg "workspace steam;";
fi
