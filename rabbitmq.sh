echo -e "\e[31mConfigure YUM Repos from the script provided by vendor\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "\e[31m Installing rabbitMQ\e[0m"
yum install rabbitmq-server -y bash &>>/tmp/roboshop.log

echo -e "\e[31m Starting rabbitMQ server\e[0m"
systemctl enable rabbitmq-server &>>/tmp/roboshop.log
systemctl start rabbitmq-server &>>/tmp/roboshop.log

echo -e "\e[31m  create one user for the application\e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log

echo -e "\e[31m  create one user for the application\e[0m"


