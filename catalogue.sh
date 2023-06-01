echo -e "\e[34mTHis is the script for repo\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[34mInstalling nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[34mAdding User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[34mCreating a directory\e[0m"
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[34mDownload the application code to created app directory\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log

echo -e "\e[3434mInstalling nodejs dependencies\e[0m"
cd /app
npm install

cp catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload

systemctl enable catalogue
systemctl start catalogue

echo -e "\e[34minstall mongodb-client\e[0m"
cp  mongodb.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y

echo -e "\e[34mLoad Schema\e[0m"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js