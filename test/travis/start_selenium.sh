mkdir -p $HOME/src
wget https://selenium-release.storage.googleapis.com/3.4/selenium-server-standalone-3.4.0.jar
nohup java -jar selenium-server-standalone-3.4.0.jar &
echo "Running with Selenium..."
sleep 10
