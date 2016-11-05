#!/bin/bash

mysql_user={user}
mysql_pass={pass}
mysql_db={db}
backup_dir={backup_dir}

sqlBackupFile=`date +%Y.%m.%d-%H.%M.%S`.sql

# goto backup dir
cd $backup_dir

# backup
mysqldump -u $mysql_user -p$mysql_pass $mysql_db > ./$sqlBackupFile

# tar
tar -cf $sqlBackupFile.tar $sqlBackupFile
gzip $sqlBackupFile.tar

# rm sql
rm $sqlBackupFile

# kill backups older two month
find . -type f -mtime +60 -exec rm -f {} \;
