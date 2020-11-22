sudo apt-get update && sudo apt-get -y upgrade
#enable ssh via cli interface, if needed
#sudo systemctl enable ssh
#sudo systemctl start ssh

# install python 3
#sudo apt-get update
sudo apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev
wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz
sudo tar zxf Python-3.7.0.tgz
cd Python-3.7.0
sudo ./configure
sudo make -j 4
sudo make altinstall
python3.7 -V

#make python 3.7 the default version
alias python=python3

#check version
python -V

# create virtual environment
cd ~
sudo apt-get install virtualenv -y
sudo python3 -m venv venv

# turn on virtual environment
source venv/bin/activate

# install remote desktop
sudo apt-get install xrdp -y


# to setup temperature reading
##sudo nano /boot/config.txt
# add
##dtoverlay=w1-gpio,gpiopin=20 # 4 was default
##sudo reboot -h now

sudo sh -c 'echo dtoverlay=w1-gpio,gpiopin=20 >> /boot/config.txt'


#exit()
#cd /sys/bus/w1/devices
#cd 28#####
#ls
#cat w1_slave
# last #s after t = is temperature * 1000 in oC

cd ~
 
sudo mkdir dataLog
cd dataLog

# install mysql
sudo apt install mariadb-server -y
sudo mysql_secure_installation -y y y y
enter
y
pwerd
pwerd
#y y y y
sudo mysql -u root -p
pwerd
CREATE DATABASE 4_database;
#CREATE DATABASE alert_database;
SHOW DATABASES;
USE 4_database;

CREATE TABLE dataLog(datetime DATETIME NOT NULL, dist1 FLOAT(5,2) NOT NULL, dist2 FLOAT(5,2) NOT NULL, vib1 FLOAT(5,2) NOT NULL, vib2 FLOAT(5,2) NOT NULL);


#CREATE TABLE dataLog(datetime DATETIME NOT NULL, temperature FLOAT(5,2) NOT NULL);
#USE alert_database;
#CREATE TABLE dataLog(datetime DATETIME NOT NULL, alert FLOAT(5,2) NOT NULL);
DESCRIBE dataLog;
exit;

append 
sql_mode=""
to
/etc/mysql/my.cnf


#install mysqldb
# old sudo apt-get install python3-dev libmysqlclient-dev
sudo apt-get install python3-dev libmariadb-dev-compat libmariadb-dev -y
sudo pip3 install mysqlclient

sudo apt-get install python-mysqldb
sudo apt-get install python3-dev libmysqlclient-dev
sudo apt-get install python3-dev libmariadb-dev-compat libmariadb-dev
sudo pip3 install mysqlclient

#for remote desktop
#sudo apt-get install lxsession

sudo pip install mysql-connector-python

sudo mysql -u root -p
pwerd

#access error, to avoid in mysql
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'pwerd';
#GRANT type_of_permission ON database_name.table_name TO ‘username’@'localhost’;
#GRANT ALL PRIVILEGES ON 4_database.dataLog TO ‘root’@’localhost’;
FLUSH PRIVILEGES;
QUIT;



# trouble here
sudo service mysql restart
sudo mysql # logs in automatically into MariaDB
use mysql;
update user set plugin='' where user='your_user_name';
flush privileges;
exit;
sudo service mysql restart # restarts the mysql service

# check table’s columns
describe dataLog;

# to remove column
#ALTER TABLE table_name
#DROP COLUMN column_name;

sudo apt install php-mysql -y
sudo apt-get install apache2 php libapache2-mod-php -y
# then go to local IP on any web browser on the network, should see apache2 screen

sudo mysql -u root -p
pwerd
use 4_database;
ALTER TABLE dataLog ADD dist1 FLOAT(5,2) NOT NULL;
ALTER TABLE dataLog ADD SFloorStatus INT NOT NULL;
#?
ALTER TABLE dataLog ADD vib1 FLOAT(5,2) NOT NULL;
exit;

# to avoid “ImportError: No module named pandas error
sudo pip install pandas # takes many minutes
sudo apt-get install python3-pandas -y
sudo pip install bokeh
sudo pip3 install pandas-bokeh
sudo python3 -m pip install PyMySQL

# to restart mysql server
service mysql restart
# pi, not root
1
pwerd0

sudo apt-get install python3-pip
sudo pip3 install hcsr04sensor

# WinSCP setup
sudo apt-get install ssh -y
sudo /etc/init.d/ssh start

# mysql security
sudo mysql -u root -p
status
show databases;
use mysql;
show tables;
#SHOW COLUMNS FROM table_name;
describe db;
#?select Db from mysql.db;
describe user;
select Host,User,Password from user;
exit
sudo mysql -u root
set password for 'root'@'localhost' = password('YOUR PASSWORD');
#?set password for 'root'@’%’ = password('YOUR PASSWORD');
flush privileges;
exit
sudo mysql -u root -p
delete from mysql.db where Db like 'test%';
flush privileges;
# to remove anonymous MySQL account & test database
#?drop user ''@'localhost';
#?drop user ''@'localhost.localdomain';
#?drop database test;
exit
cd /etc/mysql
sudo rm $HOME/.mysql_history
sudo ln -s /dev/null $HOME/.mysql_history
sudo nano my.cnf
#php? under [client-server] add:
#skip-networking
sudo service mysql restart
sudo mysql -u root -p
update mysql.user set user="freddy" where user="root";
flush privileges;
exit;

GRANT ALL PRIVILEGES ON exampledb.* TO 'exampleuser'@'localhost';
flush privileges;
exit;
sudo service mysql restart
 
# if MySQLdb._exceptions.OperationalError: (2006, ‘MySQL server has gone away’)
mysqladmin variables -u user -p
SET GLOBAL max_allowed_packet=1072731894
sudo nano /etc/mysql/my.cnf
# then change to 1 GB
max_allowed_packet=1000M
sudo service mysql restart


# change default port
sudo cp /etc/ssh/ssh_config /etc/ssh/ssh_config.backup
sudo nano /etc/ssh/ssh_config
# change ‘Port 22’ to ‘Port 1818’
sudo /etc/init.d/ssh restart

crontab -e
chmod a+x file. Py

to send a text:
sudo apt-get install python-setuptools -y
sudo apt-get install python3-dev -y
sudo apt-get install python3-pip -y
sudo pip3 install twilio
sudo apt-get install rpi.gpio -y
#python send_sms.py
sudo apt-get install python-setuptools -y
sudo apt-get install python3-dev python3-rpi.gpio -y

in script:
from twilio.rest import Client

# Your Account SID from twilio.com/console
account_sid = "AC7079b1a0e061636592f4779a071cee93"
# Your Auth Token from twilio.com/console
auth_token  = "your_auth_token"

client = Client(account_sid, auth_token)

message = client.messages.create(
    to="+15558675309", 
    from_="+15017250604",
    body="Hello from Python!")

print(message.sid)

cd /c/Users/me/Documents/Python/djangostock

# sometimes remove .py
django-admin.py startproject stocks
# to create virtual environment
python -m venv myvenv

# turn on virtual environment
source venv/Scripts/activate

# turn off
cd Scripts
deactivate

run Git bash
pip install django
pip freeze



cd stocks
python manage.py runserver

source venv/Scripts
cd stocks
ls
# should see manage.py*

python manage.py runserver

#raspberry pi 4 cannot currently show the desktop
#change resolution in sudo raspi-config

#install live camera feed
sudo apt-get install motion -y
#to check if camera registered, should see name
Lsusb
sudo nano /etc/motion/motion.conf

# to run flask
env FLASK_ENV=development FLASK_APP=hello.py flask run

pip install virtualenv


Set environment variable
export MY_NEW_VAR="My New Var"
export PYTHONPATH='$NEW_VAR'

Use /etc/environment file for setting the environment variables. Then add the following line inside the /etc/environment file.
ABC="123"
Now the ABC variable will be accessible from all the user sessions. To test the variable output first refresh the environment variable using command
source /etc/environment
and run echo $ABC.

To reference:
os.system(‘echo $NEW_VAR’)
os.system(‘echo $USER1’)

