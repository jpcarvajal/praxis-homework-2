#!/usr/bin/env bash
sudo yum install -y git

#Installation

#Go
wget -c https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && tar -C /usr/local -xvzf go1.17.2.linux-amd64.tar.gz
sudo sh -c "echo export PATH=$PATH:/usr/local/go/bin >> /etc/profile"
source /etc/profile

# Set go path
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
# Set port
echo "export PORT=4001" >> /etc/profile.d/sh.local

#Npm - node
curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
sudo yum install -y nodejs
node --version
npm --version
sudo npm install --g npm@latest

#Vue
sudo npm install -g @vue/cli
vue --version

rm -f /shared/vuego-demoapp
rm -f /shared/dist.tar.gz

cd
#Git
git clone https://github.com/jdmendozaa/vuego-demoapp.git

#Go
cd ~/vuego-demoapp/server/ 
/usr/local/go/bin/go build
cp vuego-demoapp /shared

#Vue
cd home/vagrant/vuego-demoapp/spa
sudo npm install 
sudo echo 'VUE_APP_API_ENDPOINT="http://10.0.0.8:4001/api"' >> .env.production
npm run build

#Zip the Vue app
tar -zcvf dist.tar.gz ./dist

#Move the Vue app to the shared dir
mv dist.tar.gz /shared/
