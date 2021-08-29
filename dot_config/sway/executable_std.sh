if [ -z "$(pidof Discord)" ]; then
  swaymsg "workspace discord; exec flatpak run com.discordapp.Discord;";
else
  swaymsg "workspace discord;";
fi
