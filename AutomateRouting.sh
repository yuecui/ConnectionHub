#!/bin/bash
<<<<<<< HEAD
#Author: YUE CUI
#Last Modified: 2017/07/01
#Descrption: This is a script that will automatically configure routing table for MPTCP.
#This function will print the current Ip routing table
PrintCurrentRoutingTable(){
	mapfile -t lines < <(ip addr | grep wlan.: |grep 'state UP'  | awk '{print $2}' | cut -d: -f1  )
	InterfaceNum=$(ip addr | grep wlan.: |grep 'state UP'  | awk '{print $1}' | cut -d: -f1 | wc -l)
	for (( j=0; j<$InterfaceNum; j++))
	do
		echo "============================"
		echo "|Current IP route table $((j+1)):|"
		echo "============================"
		ip route show table $((j+1))
	done
	echo "======================"
	echo "|Current IP rule is:|" 
	echo "======================"
	ip rule
}
#This function will flush the existed routing table and ip rule.
FlushExistedTable(){
	#get the ip address from ip rule look up table saved into the array rules
	mapfile -t rules < <(ip rule | grep -v "all" | cut -d: -f2| cut -d' ' -f2 ) 
	#get the corresoponding ip route table number from ip rule look up table
	mapfile -t tables < <(ip rule | grep -v "all" | cut -d: -f2| cut -d' ' -f4)
	#delete all look up rules
	for (( r=0; r<${#rules[@]}; r++ ))
	do
		ip rule del from ${rules[$r]} table ${tables[$r]}
	done	
	#flush ip routing tables
	for (( k=0; k<$InterfaceNum; k++ ))
	do
		if [ -n "$(ip route show table $((k+1)))" ]
		then
			ip route flush table $((k+1))
		fi
	done
}
#This function will create new ip routing table based on the current interfaces
CreateNewTable(){
	for (( i=0; i<$InterfaceNum; i++))
	do 
		#List the current avaliable interfaces
		IP=$(ip addr | grep "${lines[$i]}"| grep 'state UP' -A2 | grep inet | awk '{ print $2}' | cut -f1 -d'/')
		echo ${lines[$i]}, $IP		
		ip rule add from $IP table $((i+1))
		ip route add $(ip route show | grep "${lines[$i]}" | grep src | grep metric | awk '{print $1}') dev "${lines[$i]}" scope link table $((i+1))		
		ip route add default via $(echo $IP | cut -d"." -f1-3)".1" dev "${lines[$i]}" table $((i+1))

	done
	read -p "Which Interface you would like use?" interface
	ip route add default scope global nexthop via $(ip addr | grep $interface |grep 'state UP' -A2 | grep inet | awk '{ print $2}' | cut -f1 -d'/') dev $interface
	echo "Compeletd"
}

TakeOption(){
	read -p "Do you want to make any change to the rounting table?[y/n]" option
	if [ "$option" == "n" ]
	then
		echo "Nothing Changed"
	else
		FlushExistedTable
		CreateNewTable
		PrintCurrentRoutingTable
	fi
}

#Main part of the program
PrintCurrentRoutingTable
TakeOption

=======
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
>>>>>>> 9250e7697ec5c2eef6c903796035e5fee91fb3e7
