echo -e "\e[31mInstall Python 3.6\e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.login

echo -e "\e[31mAdding User\e[0m"
useradd roboshop &>>/tmp/roboshop.login

echo -e "\e[31mRemoving and Adding app directory\e[0m"
rm -rf /app &>>/tmp/roboshop.login
mkdir /app  &>>/tmp/roboshop.login

echo -e "\e[31mDownload the application code to created app directory\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip  &>>/tmp/roboshop.login
cd /app  &>>/tmp/roboshop.login
unzip /tmp/payment.zip &>>/tmp/roboshop.login

echo -e "\e[31mLets download the dependencies\e[0m"
cd /app &>>/tmp/roboshop.login
pip3.6 install -r requirements.txt &>>/tmp/roboshop.login

echo -e "\e[31mSetup SystemD Payment Service\e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.login

echo -e "\e[31mSetup Starting  Payment Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.login
systemctl enable payment &>>/tmp/roboshop.login
systemctl start payment &>>/tmp/roboshop.login