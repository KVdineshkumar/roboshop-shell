echo -e "\e[31mExecuting repo file\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/roboshop.log

echo -e "\e[31mInstalling NodeJS\e[0m"
yum install nodejs -y  &>>/tmp/roboshop.log

echo -e "\e[31mAdding user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[31mRemoving old app foulder and creating new\e[0m"
rm -rf /app  &>>/tmp/roboshop.log
mkdir /app   &>>/tmp/roboshop.log

echo -e "\e[31mDownload the application code to created app directory\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip  &>>/tmp/roboshop.log
cd /app  &>>/tmp/roboshop.log
unzip /tmp/cart.zip &>>/tmp/roboshop.log

echo -e "\e[31mAdding dependencies for nodejs\e[0m"
cd /app
npm install &>>/tmp/roboshop.log

cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log



systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[31Strating cart\e[0m"
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log
