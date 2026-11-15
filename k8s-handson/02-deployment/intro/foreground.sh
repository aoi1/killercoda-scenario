echo "準備しています。しばらくお待ちください..."
while [ ! -f /tmp/handson-ready ]; do sleep 1; done
cd ~/manifests
clear
echo "準備ができました！「START」を押してはじめましょう"
