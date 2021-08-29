text=$(bt-adapter -i | grep "Powered:" | awk 'BEGIN {FS=" "}; {print $2}')

IFS=$'\n'
for line in $(bt-device -l | grep -v "Added devices:"); do
  info=$(echo $line | awk 'BEGIN {FS=" "}; {print $NF}' | sed 's/[()]//g')
  entry=$(bt-device -i $info | grep 'Name:\|Connected:' | sed 's/  //g;s/Name: //g;s/Connected: 1/ (Connected)/g;s/Connected: 0//g' | paste -d ""  - -)

  if [ -z $tooltip ]; then
    tooltip="$entry"
  else
    tooltip="$tooltip\n$entry"
  fi
done
unset IFS

if [ -z $text ]; then
  text="--"
fi

echo "{ \"text\": \"$text\", \"tooltip\": \"$tooltip\" }" | jq --unbuffered --compact-output
