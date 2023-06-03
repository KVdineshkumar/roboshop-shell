echo -e "\e[31mInstalling redis repo/e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log

echo -e "\e[31mInstalling redis /e[0m"
yum install redis -y &>>/tmp/roboshop.log

echo -e "\e[31mUpdating listing Address /e[0m"
sed -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf &>>/tmp/roboshop.log

echo -e "\e[31mStarting Redis /e[0m"
systemctl enable redis  &>>/tmp/roboshop.log
systemctl start redis  &>>/tmp/roboshop.log




