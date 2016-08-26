
SET currentendyear=2017

sqlcmd -S server,port -U username -P password -W -d dbname -i guardians.sql -s"," | findstr /b /v /c:"----" > guardians.csv
sqlcmd -S server,port -U username -P password -W -d dbname -i schools.sql -s"," | findstr /b /v /c:"----" > schools.csv
sqlcmd -S server,port -U username -P password -W -d dbname -i studentgrades.sql -s"," | findstr /b /v /c:"----" > studentgrades.csv
sqlcmd -S server,port -U username -P password -W -d dbname -i studentguardians.sql -s"," | findstr /b /v /c:"----" > studentguardians.csv
sqlcmd -S server,port -U username -P password -W -d dbname -i students.sql -s"," | findstr /b /v /c:"----" > students.csv
sqlcmd -S server,port -U username -P password -W -d dbname -i studentschools.sql -s"," | findstr /b /v /c:"----" > studentschools.csv
sqlcmd -S server,port -U username -P password -W -d dbname -i teachers.sql -s"," | findstr /b /v /c:"----" > teachers.csv
sqlcmd -S server,port -U username -P password -W -d dbname -i classes.sql -s"," | findstr /b /v /c:"----" > classes.csv
sqlcmd -S server,port -U username -P password -W -d dbname -i enrollments.sql -s"," | findstr /b /v /c:"----" > enrollments.csv
sqlcmd -S server,port -U username -P password -W -d dbname -i lookups.sql -s"," | findstr /b /v /c:"----" > lookups.csv
winscp.com /script=winscp.txt /ini=nul
