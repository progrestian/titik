status=$(amixer get Master | grep -m 1 -oE '(\[on\]|\[off\])')

if [ "[off]" = "$status" ]; then
  echo "{ \"text\": \"--\" }" | jq --unbuffered --compact-output
else
  volume=$(amixer get Master | grep -m 1 -oE '[0-9]+%' | awk '{printf "%02d", substr($1, 1, length($1)-1)}')
  
  if [ "100" = "$volume" ]; then
    volume="**"
  fi

  echo "{ \"text\": \"$volume\" }" | jq --unbuffered --compact-output
fi

