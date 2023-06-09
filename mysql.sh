# CentOS-8 Comes with MySQL 8 Version by default, However our application needs MySQL 5.7. So lets disable MySQL 8 version.
source common.sh
echo -e "${color}Disabling mysql 8 version which is coming default${nocolor}"
yum module disable mysql -y &>>${log_file}
stat_check $?

echo -e "${color}Installing repo file${nocolor}"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}
stat_check $?


echo -e "${color}Installing MySQL server${nocolor}"
yum install mysql-community-server -y &>>${log_file}
stat_check $?


echo -e "${color}Starting MySQL server${nocolor}"
systemctl enable mysqld
systemctl start mysqld  &>>${log_file}
stat_check $?


echo -e "${color}change the default root password ${nocolor}"
mysql_secure_installation --set-root-pass $1  &>>${log_file}
stat_check $?








