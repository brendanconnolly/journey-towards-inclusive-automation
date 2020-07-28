MY_IP=$(ipconfig getifaddr en0)
REMOTE_HOST_URL="http://$MY_IP:5555"
echo $REMOTE_HOST_URL
START_COMMAND_TEXT="selenium-server -role node -hubHost localhost -hubPort 4444 -port 5555 -remoteHost $REMOTE_HOST_URL"
echo $START_COMMAND_TEXT
$START_COMMAND_TEXT



