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
  mongo --host mongodb-dev.devopsd73.store </app/schema/user.js &>>/tmp/roboshop.log
}