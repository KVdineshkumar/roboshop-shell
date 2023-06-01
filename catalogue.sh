echo -e "\e[31mTHis is the script for repo\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[31mInstalling nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[31mAdding User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[31mCreating a directory\e[0m"
rm -rf /app
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[31mDownload the application code to created app directory\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip  &>>/tmp/roboshop.log
cd /app
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log

echo -e "\e[31mInstalling nodejs dependencies\e[0m"
cd /app
npm install &>>/tmp/roboshop.log

cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service  &>>/tmp/roboshop.log

systemctl daemon-reload

systemctl enable catalogue
systemctl start catalogue &>>/tmp/roboshop.log

echo -e "\e[31minstall mongodb-client\e[0m"
cp  /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[34mLoad Schema\e[0m"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js &>>/tmp/roboshop.log