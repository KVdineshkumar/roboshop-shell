source common.sh
echo -e "${color}Installing redis repo${nocolor}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${log_file}
yum module enable redis:remi-6.2 -y &>>${log_file}
stat_check $?


echo -e "${color}Installing redis ${nocolor}"
yum install redis -y &>>${log_file}
stat_check $?


echo -e "${color}Updating listing Address ${nocolor}"
sed -i -e 's/127.0.0.1/0.0.0.0/'  -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf  /etc/redis/redis.conf  &>>${log_file}
stat_check $?


echo -e "${color}Starting Redis ${nocolor}"
systemctl enable redis  &>>${log_file}
systemctl start redis  &>>${log_file}
stat_check $?




