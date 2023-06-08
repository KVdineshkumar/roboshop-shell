color="\e[33m" # here we want to as \e[31m but it won't work becous "\" is an special charter we want denote by ""
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

nodeJS() {
  echo -e "${color} THis is the script for repo${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

  echo -e "${color}Installing nodejs\e[0m"
  yum install nodejs -y &>>${log_file}

  echo -e "${color}Adding User\e[0m"
  useradd roboshop &>>${log_file}

  echo -e "${color}Creating a directory${nocolor}"
  rm -rf ${app_path}
  mkdir ${app_path} &>>${log_file}

  echo -e "${color}Download the application code to created app directory${nocolor}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>${log_file}
  cd ${app_path}
  unzip /tmp/${component}.zip &>>${log_file}

  echo -e "${color}Installing nodejs dependencies${nocolor}"
  cd /app
  npm install &>>${log_file}

  cp /home/centos/roboshop-shell/{component}.service /etc/systemd/system/{component}.service  &>>${log_file}

  echo -e "${color}Starting cart service${nocolor}"

  systemctl daemon-reload

  systemctl enable ${component}
  systemctl start ${component} &>>${log_file}

}

mongo_shema_setup() {
  echo -e "${color}install mongodb-client${nocolor}"
  cp  /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
  yum install mongodb-org-shell -y &>>/tmp/roboshop.log

  echo -e "\e[34mLoad Schema\e[0m"
  mongo --host mongodb-dev.devopsd73.store </app/schema/${component}.js &>>/tmp/roboshop.log
}

maven() {
  echo -e "${color}Installing Maven${nocolor}"
  yum install maven -y &>>${log_file}

  echo -e "${color}Adding User${nocolor}"
  useradd roboshop &>>/tmp${log_file}

  echo -e "${color}Removing and Adding directory${nocolor}"
  rm -rf ${app_path}  &>>${log_file}
  mkdir ${app_path}  &>>${log_file}

  echo -e "${color}Download the application code to created app directory${nocolor}"
  curl -L -o /tmp/${shipping}.zip https://roboshop-artifacts.s3.amazonaws.com/${shipping}.zip &>>/tmp/roboshop.log
  cd ${app_path}
  unzip /tmp/${shipping}.zip &>>${log_file}

  echo -e "${color}download the dependencies & build the application${nocolor}"
  cd ${app_path}
  mvn clean package &>>/tmp/roboshop.log
  mv target/${shipping}-1.0.jar ${shipping}.jar &>>${log_file}

  echo -e "${color}Setup SystemD Shipping Service${nocolor}"
  cp /home/centos/roboshop-shell/${shipping}.service /etc/systemd/system/${shipping}.service &>>${log_file}

  echo -e "${color}Starting Shipping Service${nocolor}"
  systemctl daemon-reload
  systemctl enable ${shipping} &>>${log_file}
  systemctl start ${shipping} &>>${log_file}

  echo -e "${color}Installing mysql server${nocolor}"
  yum install mysql -y &>>${log_file}

  echo -e "${color}Load Schema${nocolor}"
  mysql -h mysql-dev.devopsd73.store -uroot -pRoboShop@1 < /app/schema/${shipping}.sql &>>${log_file}

  echo -e "${color}Restarting shipping service${nocolor}"
  systemctl restart ${shipping} &>>${log_file}
}