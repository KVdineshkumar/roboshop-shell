# To add the repo file in manual process we use VIM  but Automation we creating a file server-name.repo(mongodb.repo) and add the configuration
# BY using CP we copying the configuration giving a file name as shown in below .
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tem/roboshop.log

eco -e "\e[33mInstalling MongoDB server \e[0m"
yum install mongodb-org -y &>>/tem/roboshop.log

# here we want Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf
eco -e "\e[34mUpdate listen address \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /ect/mongodb.conf &>>/tem/roboshop.log

eco -e "\e[35mStart  MongoDB server \e[0m"
systemctl enable mongod &>>/tem/roboshop.log
systemctl restart mongod &>>/tem/roboshop.log