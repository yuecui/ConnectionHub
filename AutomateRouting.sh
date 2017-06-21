#!/bin/bash
mapfile -t lines < <(ip addr | grep wlan.: |grep 'state UP' -A2 | awk '{print $2}' | cut -d: -f1  )
InterfaceNum=$(ip addr | grep wlan.: |grep 'state UP' -A2 | awk '{print $1}' | cut -d: -f1 | wc -l)
for (( i=0; i<$InterfaceNum; i++))
do 
	IP=$(ip addr | grep "${lines[$i]}"| grep 'state UP' -A2 | grep inet | awk '{ print $2}' | cut -f1 -d'/')
	echo ${lines[$i]}, $IP
	ip rule add from $IP table $((i+1))
	ip route add $(ip route show | grep "${lines[$i]}" | grep src | grep metric | awk '{print $1}') dev "${lines[$i]}" scope link table $((i+1))		
	ip route add default via $(echo $IP | cut -d"." -f1-3)".1" dev "${lines[$i]}" table $((i+1))
done
read -p "Which Interface you would like use?" interface
ip route add default scope global nexthop via $(ip addr | grep $interface |grep 'state UP' -A2 | grep inet | awk '{ print $2}' | cut -f1 -d'/') dev $interface
echo "Compeletd"
