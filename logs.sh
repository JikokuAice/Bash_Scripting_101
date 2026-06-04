#!/bin/bash

LOG_DIR="/home/aice/Desktop/logs"
APP_LOG_FILE="application.log"
SYSTEM_LOG_FILE="system.log"
ARR=("ERROR" "FATAL" "CRITICAL")
FILE_EXPORT="/home/aice/Desktop/logs/export_report.txt"
ALERT_EXPORT="/home/aice/Desktop/logs/alert_emergency.txt"

echo "===============" > "$FILE_EXPORT"
echo "Finding Errors in log files" > "$FILE_EXPORT"
echo "===============" > "$FILE_EXPORT"

echo ${ARR[0]} > "$FILE_EXPORT"
echo ${ARR[1]} >> "$FILE_EXPORT"
echo -e  "\nFinding log that has .log extension and been modified within 30  day file" >> "$FILE_EXPORT"
LOG_FILES=$(find "$LOG_DIR" -name "*.log" -mtime -30)
echo $LOG_FILES  >> "$FILE_EXPORT"

for LOG_FILE in $LOG_FILES;do
for PATTERN in ${ARR[@]};do
echo -e "\nFinding $PATTERN in $LOG_FILE file" >> "$FILE_EXPORT"
grep $PATTERN $LOG_FILE >> "$FILE_EXPORT"
echo -e "\nNumber of $PATTERN found $LOG_FILE file" >> "$FILE_EXPORT"

ERR_COUNT=$(grep -c "$PATTERN" "$LOG_FILE");


if [[ $ERR_COUNT -gt 10 ]];then
echo "Emergency there is more there too mny $PATTERN ERROR  in file" > "$ALERT_EXPORT"
fi	

grep -c $PATTERN $LOG_FILE >> "$FILE_EXPORT"
done
done


if [[ -z "$ALERT_EXPORT"  ]];then
rm $ALERT_EXPORT	
fi


