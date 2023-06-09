source common.sh
component=dispatch

echo -e "\e[31mInstalling golang${nocolor}"
yum install golang -y &>>/tmp/roboshop.log

echo -e "${color}Adding user${nocolor}"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${color}removing and adding app directory${nocolor}"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app  &>>/tmp/roboshop.log

echo -e "${color}Download the application code to created app directory${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
unzip /tmp/${component}.zip &>>/tmp/roboshop.log

echo -e "${color}dependencies & build the software${nocolor}"
cd /app &>>/tmp/roboshop.log
go mod init ${component} &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "${color}Setup SystemD Payment Service${nocolor}"
cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>/tmp/roboshop.log

echo -e "${color}Starting dispatch  Service${nocolor}"
systemctl daemon-reload
systemctl enable ${component}
systemctl start ${component}
