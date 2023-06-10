# To add the repo file in manual process we use VIM  but Automation we creating a file server-name.repo(mongodb.repo) and add the configuration
# BY using CP we copying the configuration giving a file name as shown in below .
source common.sh
echo -e "\e[33mCopy MongoDB repo \e[0m"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo  &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[33mInstalling MongoDB server \e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
stat_check $?


# here we want Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf
echo -e "\e[34mUpdate listen address \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[35mStart  MongoDB server \e[0m"
systemctl daemon-reload
systemctl restart mongod &>>/tmp/roboshop.log
stat_check $?



