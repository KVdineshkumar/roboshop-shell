# CentOS-8 Comes with MySQL 8 Version by default, However our application needs MySQL 5.7. So lets disable MySQL 8 version.
echo -e "\e[33mDisabling mysql 8 version which is coming default\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log
echo -e "\e[31mInstalling repo file\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[32mInstalling MySQL server\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[31mStarting MySQL server\e[0m"
systemctl enable mysqld
systemctl start mysqld  &>>/tmp/roboshop.log

echo -e "\e[32mchange the default root password \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1  &>>/tmp/roboshop.log







