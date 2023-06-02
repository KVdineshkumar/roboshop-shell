echo -e "\e[31mInstalling Maven\e[0m"
yum install maven -y &>>/tmp/roboshop.log

echo -e "\e[31mAdding User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[31mRemoving and Adding directory\e[0m"
rm -rf /app  &>>/tmp/roboshop.log
mkdir /app   &>>/tmp/roboshop.log

echo -e "\e[31mDownload the application code to created app directory\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[31mdownload the dependencies & build the application\e[0m"
cd /app
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "\e[31mSetup SystemD Shipping Service\e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log

echo -e "\e[31mStarting Shipping Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl start shipping &>>/tmp/roboshop.log

echo -e "\e[31mInstalling mysql server\e[0m"
yum install mysql -y &>>/tmp/roboshop.log

echo -e "\e[31mLoad Schema\e[0m"
mysql -h mysql-dev.devopsd73.store -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[31mRestarting shipping\e[0m"
systemctl restart shipping &>>/tmp/roboshop.log