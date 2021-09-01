power=$(bt-adapter -i | grep 'Powered:' | awk '{print $2}')

if [ "1" = $power ]; then
  bt-adapter --set Powered 0
else
  bt-adapter --set Powered 1
fi
