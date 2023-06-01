echo -e "\e[31mExecuting repo file\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tem/roboshop.log

echo -e "\e[31mInstalling NodeJS\e[0m"
yum install nodejs -y  &>>/tem/roboshop.log

echo -e "\e[31mAdding user\e[0m"
useradd roboshop &>>/tem/roboshop.log

echo -e "\e[31mRemoving old app foulder and creating new\e[0m"
rm -rf /app  &>>/tem/roboshop.log
mkdir /app   &>>/tem/roboshop.log

echo -e "\e[31mDownload the application code to created app directory\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip  &>>/tem/roboshop.log
cd /app  &>>/tem/roboshop.log
unzip /tmp/cart.zip &>>/tem/roboshop.log

echo -e "\e[31mAdding dependencies for nodejs\e[0m"
cd /app
npm install &>>/tem/roboshop.log

cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tem/roboshop.log



systemctl daemon-reload &>>/tem/roboshop.log

echo -e "\e[31Strating cart\e[0m"
systemctl enable cart &>>/tem/roboshop.log
systemctl restart cart &>>/tem/roboshop.log
