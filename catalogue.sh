component=catalogue
color="\e[31m" # here we want to as \e[31m but it won't work becous "\" is an special charter we want denote by ""
nocolor="\e[0m"
echo -e "${color} THis is the script for repo${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "${color}Installing nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "${color}Adding User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${color}Creating a directory${nocolor}"
rm -rf /app
mkdir /app &>>/tmp/roboshop.log

echo -e "\${color}Download the application code to created app directory${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip  &>>/tmp/roboshop.log
cd /app
unzip /tmp/$component.zip &>>/tmp/roboshop.log

echo -e "${color}Installing nodejs dependencies${nocolor}"
cd /app
npm install &>>/tmp/roboshop.log

cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service  &>>/tmp/roboshop.log

systemctl daemon-reload

systemctl enable $component
systemctl start $component &>>/tmp/roboshop.log

echo -e "${color}install mongodb-client${nocolor}"
cp  /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "${color}Load Schema${nocolor}"
mongo --host mongodb-dev.devopsd73.store </app/schema/$component.js &>>/tmp/roboshop.log