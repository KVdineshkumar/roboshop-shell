color="\e[33m" # here we want to as \e[31m but it won't work becous "\" is an special charter we want denote by ""
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

stat_check() {
   if [ $? -eq 0 ]; then
           echo sucess
           else
             echo failure
           fi

}

app_presetup () {
    echo -e "${color}Adding User\e[0m"
    id roboshop   &>>${log_file}
     if [ $? -eq 1 ]; then
    useradd roboshop &>>${log_file}
     fi
 stat_check
     echo $?

    echo -e "${color}Creating a directory${nocolor}"
      rm -rf ${app_path}
      mkdir ${app_path} &>>${log_file}
       echo $?
         stat_check
    echo -e "${color}Download the application code to created app directory${nocolor}"
      curl  -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>${log_file}
       echo $?
        stat_check

    echo -e "${color}extracting application content${nocolor}"

      cd ${app_path}
      unzip /tmp/${component}.zip &>>${log_file}
       echo $?
          stat_check
       }



systemd_setup() {
      echo -e "${color}Setup SystemD Service${nocolor}"

    cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/payment.service &>>${log_file}
   sed -i -e "s/roboshop_app_password/${roboshop_app_password}/" /etc/systemd/system/payment.service &>>${log_file}
    echo -e "${color}Setup Starting  Payment Service${nocolor}"
    systemctl daemon-reload &>>${log_file}
    systemctl enable payment &>>${log_file}
    systemctl start payment &>>${log_file}
     echo $?
     stat_check
}


mongo_shema_setup() {
  echo -e "${color}install mongodb-client${nocolor}"
  cp  /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
  yum install mongodb-org-shell -y &>>/tmp/roboshop.log

  echo -e "\e[34mLoad Schema\e[0m"
  mongo --host mongodb-dev.devopsd73.store  </app/schema/${component}.js &>>/tmp/roboshop.log
}
mysql_shema_setup() {

  echo -e "${color}Installing mysql server${nocolor}"
  yum install mysql -y &>>${log_file}
  stat_check $?

  echo -e "${color}Load Schema${nocolor}"
  mysql -h mysql-dev.devopsd73.store -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${log_file}
  stat_check $?
}

nodeJS() {
  echo -e "${color} THis is the script for repo${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
  stat_check $?

  echo -e "${color}Installing nodejs${nocolor}"
  yum install nodejs -y &>>${log_file}
  stat_check $?

  app_presetup

  echo -e "${color}Creating a directory${nocolor}"
  rm -rf ${app_path}
  mkdir ${app_path} &>>${log_file}
  stat_check $?

  echo -e "${color}Download the application code to created app directory${nocolor}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>${log_file}
  cd ${app_path}
  unzip /tmp/${component}.zip &>>${log_file}
  stat_check $?

  echo -e "${color}Installing nodejs dependencies${nocolor}"
  cd /app
  npm install &>>${log_file}
  stat_check $?

  cp /home/centos/roboshop-shell/{component}.service /etc/systemd/system/{component}.service  &>>${log_file}
  stat_check $?

  echo -e "${color}Starting cart service${nocolor}"

  systemctl daemon-reload

  systemctl enable ${component}
  systemctl start ${component} &>>${log_file}
  stat_check $?

}


maven() {
  echo -e "${color}Installing Maven${nocolor}"
  yum install maven -y &>>${log_file}

app_presetup

  echo -e "${color}Removing and Adding directory${nocolor}"
  rm -rf ${app_path}  &>>${log_file}
  mkdir ${app_path}  &>>${log_file}

  echo -e "${color}Download the application code to created app directory${nocolor}"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>/tmp/roboshop.log
  cd ${app_path}
  unzip /tmp/${component}.zip &>>${log_file}

  echo -e "${color}download the dependencies & build the application${nocolor}"
  cd ${app_path}
  mvn clean package &>>/tmp/roboshop.log
  mv target/${component}-1.0.jar ${component}.jar &>>${log_file}

  echo -e "${color}Setup SystemD Shipping Service${nocolor}"
  cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${log_file}

  echo -e "${color}Starting Shipping Service${nocolor}"
  systemctl daemon-reload
  systemctl enable ${component} &>>${log_file}
  systemctl start ${component} &>>${log_file}

mysql_shema_setup

  echo -e "${color}Restarting shipping service${nocolor}"
  systemctl restart ${component} &>>${log_file}
}

python() {
  echo -e "${color}Install Python 3.6${nocolor}"
  yum install python36 gcc python3-devel -y &>>${log_file}
  echo $?
stat_check

app_presetup

  echo -e "${color}Lets download the dependencies${nocolor}"
  cd /app &>>${log_file}
  pip3.6 install -r requirements.txt &>>${log_file}
   echo $?
     stat_check

 systemd_setup
 }