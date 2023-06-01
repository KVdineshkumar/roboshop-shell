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
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/user.zip &>>/tmp/roboshop.log

echo -e "\e[31mInstalling nodejs dependencies\e[0m"
cd /app
npm install &>>/tmp/roboshop.log

cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service  &>>/tmp/roboshop.log

systemctl daemon-reload &>>/tmp/roboshop.log

systemctl enable user </app/schema/user.js &>>/tmp/roboshop.log
systemctl start user &>>/tmp/roboshop.log

echo -e "\e[31minstall mongodb-client\e[0m"
cp  /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[34mLoad Schema\e[0m"
mongo --host mongodb-dev.devopsd73.store </app/schema/user.js &>>/tmp/roboshop.log