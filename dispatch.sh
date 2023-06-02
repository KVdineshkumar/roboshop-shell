echo -e "\e[31mInstalling golang\e[0m"
yum install golang -y &>>/tmp/roboshop.log

echo -e "\e[31mAdding user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[31mremoving and adding app directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app  &>>/tmp/roboshop.log

echo -e "\e[31mdependencies & build the software\e[0m"
cd /app &>>/tmp/roboshop.log
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "\e[31mSetup SystemD Payment Service\e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[31mStarting dispatch  Service\e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch
