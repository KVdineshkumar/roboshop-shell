sorce common.sh
component=cart
echo -e "${color}Executing repo file ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/roboshop.log

echo -e "${color}Installing NodeJS${nocolor}"
yum install nodejs -y  &>>/tmp/roboshop.log

echo -e "${color}Adding user${nocolor}"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${color}Removing old app foulder and creating new${nocolor}"
rm -rf ${app_apth}  &>>/tmp/roboshop.log
mkdir ${app_apth}    &>>/tmp/roboshop.log

echo -e "${color}Download the application code to created app directory${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>/tmp/roboshop.log
cd /app  &>>/tmp/roboshop.log
unzip /tmp/${component}.zip &>>/tmp/roboshop.log

echo -e "${color}Adding dependencies for nodejs${nocolor}"
cd ${app_apth}
npm install  &>>/tmp/roboshop.log

echo -e "${color}Setup Systemd Service${nocolor}"
cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service  &>>/tmp/roboshop.log

echo -e "${color}Strating cart server${nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable ${component} &>>/tmp/roboshop.log
systemctl start ${component} &>>/tmp/roboshop.log
