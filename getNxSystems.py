import mysql.connector
import csv

#Note:  You must grant SELECT privileges to the user runnging the script by doing the following:
# MariaDB> USE mysql;
# MariaDB> CREATE USER 'getNxSystems'@'localhost' IDENTIFIED BY '<ENTER PASSWORD HERE>';
# MariaDB> use nxlog-manager5;
# MariaDB> grant SELECT ON NXServerInfo TO 'getNxSystems'@'localhost';
# MariaDB> grant SELECT ON NXAgentInstance TO 'getNxSystems'@'localhost';
# MariaDB> FLUSH PRIVILEGES;

# This is the file that the script will create to be uploaded to Axonius
outputFile = 'NxDevices.csv'

mydb = mysql.connector.connect(
    user="getNxSystems",
    password="<ENTER PASSWORD HERE>",
    database="nxlog-manager5"
)

mycursor = mydb.cursor()
mycursor.execute("SELECT  NXAgentInstance.agent_id, NXServerInfo.agent_hostname, NXAgentInstance.address, NXServerInfo.agent_os, NXServerInfo.agent_version FROM NXAgentInstance, NXServerInfo WHERE NXAgentInstance.agent_id=NXServerInfo.agent_instance_id")
myresult = mycursor.fetchall()

fieldNames = ['hostname', 'ipaddress', 'osname', 'packages']
with open(outputFile, 'w', newline='') as csvFile:
    writer = csv.DictWriter(csvFile, fieldnames=fieldNames)
    
    writer.writeheader()
    for each in myresult:
        nxName = 'NxLog ' + each[4]
        writer.writerow({'hostname': each[1], 'ipaddress': each[2], 'osname': each[3], 'packages': nxName})
