source common.sh
echo -e "${color}installing nginx server roboshop${nocolor}"
yum install nginx -y &>>${log_file}
stat_check &>>${log_file}

echo -e "${color}Here we are removing old config to config new${nocolor}"
rm -rf /usr/share/nginx/html/* &>>${log_file}
stat_check

echo -e "${color}Downloading frontend UI code content${nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>>${log_file}
stat_check

echo -e "${color}Here we are unzing the zip file${nocolor}"
cd /usr/share/nginx/html &>>${log_file}
unzip /tmp/frontend.zip &>>${log_file}
stat_check

echo -e "${color}Updating Frontend Configuration${nocolor}"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
systemctl enable nginx
systemctl restart nginx &>>${log_file}
stat_check