source common.sh

component=catalogue
nodeJS
echo -e "${color}install mongodb-client${nocolor}"
cp  /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}
yum install mongodb-org-shell -y &>>${log_file}

echo -e "${color}Load Schema${nocolor}"
mongo --host mongodb-dev.devopsd73.store </app/schema/$component.js &>>${log_file}