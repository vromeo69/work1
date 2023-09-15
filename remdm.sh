#!/bin/bash
RED='\033[1;31m'
GRN='\033[1;32m'
BLU='\033[1;34m'
YEL='\033[1;33m'
PUR='\033[1;35m'
CYAN='\033[1;36m'
NC='\033[0m'

echo -e "${CYAN}*-------------------*---------------------*${NC}"
echo -e "${YEL}* Check MDM - Skip MDM Auto for MacOS by   *${NC}"
echo -e "${RED}*                                          *${NC}"
echo -e "${RED}*            GREENSAFE IT                  *${NC}"
echo -e "${CYAN}*-------------------*---------------------*${NC}"
echo ""
PS3='Please enter your choice: '
options=("Autobypass on Recovery" "Reboot")
select opt in "${options[@]}"; do
	case $opt in
	"Autobypass on Recovery")
		echo -e "${GRN}Bypass on Recovery"
		if [ -d "/Volumes/Macintosh HD - Data" ]; then
   			diskutil rename "Macintosh HD - Data" "Data"
		fi
		echo -e "${GRN}Create a new user"
        echo -e "${BLU}Press Enter to continue, Note: Leaving it blank will default to the automatic user"
  		echo -e "Enter the username (Default: Admin)"
		read realName
  		realName="${realName:= Admin}"
    	echo -e "${BLUE}username ${RED}WRITE WITHOUT SPACES"
      	read username
		username="${username:=Admin}"
  		echo -e "${BLUE}Enter the password (default: 1234)"
    	read passw
      	passw="${passw:=1234}"
		dscl_path='/Volumes/Data/private/var/db/dslocal/nodes/Default' 
        echo -e "${GREEN}Creating User /"
  		# Create user
    	dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username"
      	dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" UserShell "/bin/zsh"
	    dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" RealName "$realName"
	 	dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" RealName "$realName"
	    dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" UniqueID "501"
	    dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" PrimaryGroupID "20"
		mkdir "/Volumes/Data/Users/$username"
	    dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" NFSHomeDirectory "/Users/$username"
	    dscl -f "$dscl_path" localhost -passwd "/Local/Default/Users/$username" "$passw"
	    dscl -f "$dscl_path" localhost -append "/Local/Default/Groups/admin" GroupMembership $username
		echo "0.0.0.0 deviceenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
		echo "0.0.0.0 mdmenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
		echo "0.0.0.0 iprofiles.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
        echo -e "${GREEN}Successfully blocked host / Thành công chặn host${NC}"
		# echo "Remove config profile"
  	touch /Volumes/Data/private/var/db/.AppleSetupDone
        rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord
	rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound
	touch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled
	touch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound
	echo -e "${CYAN}------ Autobypass SUCCESSFULLY"
	echo -e "${CYAN}------ Exit Terminal , Reset Macbook and ENJOY ! ------${NC}"
		break
		;;
    "Disable Notification (SIP)")
    	echo -e "${RED}Please Insert Your Password To Proceed${NC}"
        sudo rm /var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord
        sudo rm /var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound
        sudo touch /var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled
        sudo touch /var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound
        break
        ;;
    "Disable Notification (Recovery)")
        rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord
	rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound
	touch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled
	touch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound

        break
        ;;
	"Check MDM Enrollment")
		echo ""
		echo -e "${GRN}Check MDM Enrollment. Error is success${NC}"
		echo ""
		echo -e "${RED}Please Insert Your Password To Proceed${NC}"
		echo ""
		sudo profiles show -type enrollment
		break
		;;
	"Exit")
 		echo "Rebooting..."
		reboot
		break
		;;
	*) echo "Invalid option $REPLY" ;;
	esac
done
