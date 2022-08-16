#!/bin/bash

#functions

create_vcardstart()	{
cat >> /home/pi/vcardstart.sh << EOF
#!/bin/bash

#function to restart vCard POS
while :
        do
                if pgrep vcardpos.sh > /dev/null 2>&1;
                        then
                                echo "POS Running!"
                                sleep 5
                        else
                                echo "POS NOT Running!!!"
                                /home/pi/vcard/vcardpos.sh > /dev/null 2>&1
                fi
done
EOF
}


#Script to remove previous tweaks to start vCard at boot

if [ -e /home/pi/.config/autostart/vcard.desktop ];
	then echo "vcard.desktop link found in /home/pi/.config/autostart! Removing.";
	rm /home/pi/.config/autostart/vcard.desktop;
	else echo "vcard.desktop link not found in /home/pi/.config/autostart"
fi

if [ -e /home/pi/runtest.sh ];
	then echo "vcard.desktop link found in /home/pi/.config/autostart! Removing.";
	rm /home/pi/runtest.sh;
	else echo "vcard.desktop link not found in /home/pi/.config/autostart"
fi

#Script to install and enable vCard autostart

if grep /home/pi/vcardstart.sh /etc/xdg/lxsession/LXDE-pi/autostart;
	then echo "Link to autostart script found.";
	else echo "Link to autostart IS NOT FOUND! Adding link.";
	if echo /home/pi/vcardstart.sh >> /etc/xdg/lxsession/LXDE-pi/autostart;
		then echo "Link to autostart has been created.";
		else echo "Link to autostart WAS NOT CREATED!"
	fi
fi

if [ -e /home/pi/vcardstart.sh ];
	then echo "vcardstart.sh script found.";
	else echo "vcardstart.sh script NOT FOUND! Creating now.";
	if create_vcardstart;
		then echo "vcardstart.sh script created.";
			 if chmod +x /home/pi/vcardstart.sh;
			 	then echo "vcardstart.sh script now executable";
			 	else echo "vcardstart.sh script NOT EXECUTABLE!"
			 fi
		else echo "vcardstart.sh scriipt NOT CREATED!"
	fi
fi

