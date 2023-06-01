echo -e "\e[33minstalling nginx server roboshop\e[0m"
yum install nginx -y &>>/tmp/roboshop.log

echo -e "\e[34mHere we are removing old config to config new\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[35mDownloading frontend UI code content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[36mHere we are unzing the zip file\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[37mUpdating Frontend Configuration\e[0m"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf
systemctl enable nginx
systemctl restart nginx