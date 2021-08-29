power=$(bt-adapter -i | grep "Powered:" | awk 'BEGIN {FS=" "}; {print $2}')

if [ $power == "1" ]; then
  bt-adapter --set Powered 0
else
  bt-adapter --set Powered 1
fi
