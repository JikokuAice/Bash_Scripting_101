
server_name=$(hostname)
current_time=$(date +"%r" )


echo "==========================================="

echo "DISK MONITORING "

echo "============================================"
df -h 

echo "------------------------------------------"
echo 'Memory'
echo "-----------------------------------------"

free -h -c 5 |  awk '/^Mem:/ {mem=$0} END {print mem}'

echo "-----------------------------"

echo "UPTIME OF Server "$server_name"  AT "$current_time" "

uptime -p

Days=$(uptime -p | grep -oE '[0-9]+'| head -n 1)
 
if [ -z "$Days" ]; then
	echo "________________:)"
fi

if [ "$Days" -gt 5 ];then 
zenity --error --text="Uptime Exceeded please Restart Server". 
fi

