#!/bin/bash
echo "---Checking if IW4x is installed---"
if [ ! -f ${DATA_DIR}/iw4x.exe ]; then
	if [ -f ${DATA_DIR}/iw4x_files.zip ]; then
		echo "---'iw4x_files.zip' found, extracting---"
		cd ${DATA_DIR}
		unzip -o ${DATA_DIR}/iw4x_files.zip
	else
		echo "---IW4x not found, downloading---"
		cd ${DATA_DIR}
		if wget -q -nc --show-progress --progress=bar:force:noscroll -O iw4x_files.zip "${IW4X_DL_URL}" ; then
			echo "---Successfully downloaded IW4x!---"
		else
			echo "-----------------------------------------------------------------------------"
			echo "---Something went wrong, can't download IW4x, putting server in sleep mode---"
			echo "-----------------------------------------------------------------------------"
			echo "---------------------------MANUAL INSTALLATION:------------------------------"
            echo "---You can also download the file 'iw4x_files.zip' manually and put it in----"
			echo "----------------------the main directory of the server-----------------------"
            echo "-----------------------------------------------------------------------------"
			sleep infinity
		fi
		unzip -o ${DATA_DIR}/iw4x_files.zip
	fi
fi

echo "---Checking if IW4x DLC is installed---"
if [ ! -f ${DATA_DIR}/main/iw_dlc3_00.iwd ]; then
	if [ -f ${DATA_DIR}/iw4x_dlc.zip ]; then
		echo "---'iw4x_dlc.zip' found, extracting---"
		cd ${DATA_DIR}
		unzip -o ${DATA_DIR}/iw4x_dlc.zip
	else
		echo "---IW4x DLC not found, downloading, please be patient this can take a very long time---"
		cd ${DATA_DIR}
		if wget -q -nc --show-progress --progress=bar:force:noscroll -O iw4x_dlc.zip "${IW4X_DLC_URL}" ; then
			echo "---Successfully downloaded IW4x DLC!---"
		else
			echo "---------------------------------------------------------------------------------"
			echo "---Something went wrong, can't download IW4x DLC, putting server in sleep mode---"
			echo "---------------------------------------------------------------------------------"
			echo "-----------------------------MANUAL INSTALLATION:--------------------------------"
            echo "------You can also download the file 'iw4x_dlc.zip' manually and put it in-------"
			echo "------------------------the main directory of the server-------------------------"
            echo "---------------------------------------------------------------------------------"
		sleep infinity
		fi
		unzip -o ${DATA_DIR}/iw4x_dlc.zip
	fi
fi

if [ "${FORCE_UPDATE}" == "true" ]; then
	echo "---Forcing update---"
	if [ -f ${DATA_DIR}/iw4x_files.zip ]; then
		echo "---'iw4x_files.zip' found, extracting---"
		cd ${DATA_DIR}
		unzip -o ${DATA_DIR}/iw4x_files.zip
	else
		echo "---Downloading IW4x---"
		cd ${DATA_DIR}
		if wget -q -nc --show-progress --progress=bar:force:noscroll -O iw4x_files.zip "${IW4X_DL_URL}" ; then
			echo "---Successfully downloaded IW4x!---"
		else
			echo "-----------------------------------------------------------------------------"
			echo "---Something went wrong, can't download IW4x, putting server in sleep mode---"
			echo "-----------------------------------------------------------------------------"
			echo "---------------------------MANUAL INSTALLATION:------------------------------"
            echo "---You can also download the file 'iw4x_files.zip' manually and put it in----"
			echo "----------------------the main directory of the server-----------------------"
            echo "-----------------------------------------------------------------------------"
			sleep infinity
		fi
		unzip -o ${DATA_DIR}/iw4x_files.zip
	fi
	if [ -f ${DATA_DIR}/iw4x_dlc.zip ]; then
		echo "---'iw4x_dlc.zip' found, extracting---"
		cd ${DATA_DIR}
		unzip -o ${DATA_DIR}/iw4x_dlc.zip
	else
		echo "---Downloading IW4x DLC---"
		cd ${DATA_DIR}
		if wget -q -nc --show-progress --progress=bar:force:noscroll -O iw4x_dlc.zip "${IW4X_DLC_URL}" ; then
			echo "---Successfully downloaded IW4x DLC!---"
		else
			echo "---------------------------------------------------------------------------------"
			echo "---Something went wrong, can't download IW4x DLC, putting server in sleep mode---"
			echo "---------------------------------------------------------------------------------"
			echo "-----------------------------MANUAL INSTALLATION:--------------------------------"
            echo "------You can also download the file 'iw4x_dlc.zip' manually and put it in-------"
			echo "------------------------the main directory of the server-------------------------"
            echo "---------------------------------------------------------------------------------"
		sleep infinity
		fi
		unzip -o ${DATA_DIR}/iw4x_dlc.zip
	fi
fi

echo "---Checking if gamefiles are in place---"
if [ ! -f ${DATA_DIR}/main/iw_00.iwd ]; then
	echo "---------------------------------------------------------"
	echo "---Gamefiles not found, putting server into sleep mode---"
	echo "----Please put your whole gamefiles into your server-----"
	echo "-----------directory and restart the container-----------"
	echo "----------------------ATTENTION:-------------------------"
	echo "----I recommend you to NOT replace any files if asked----"
	echo "---------------------------------------------------------"
	sleep infinity
else
	echo "---Gamefiles found!---"
fi

export WINEARCH=win32
export WINEPREFIX=/iw4x/WINE32
echo "---Checking if WINE workdirectory is present---"
if [ ! -d ${DATA_DIR}/WINE32 ]; then
	echo "---WINE workdirectory not found, creating please wait...---"
	mkdir ${DATA_DIR}/WINE32
else
	echo "---WINE workdirectory found---"
fi
echo "---Checking if WINE is properly installed---"
if [ ! -d ${DATA_DIR}/WINE32/drive_c/windows ]; then
	echo "---Setting up WINE---"
	cd ${DATA_DIR}
	winecfg > /dev/null 2>&1
	sleep 15
else
	echo "---WINE properly set up---"
fi

echo "---Prepare Server---"
if [ ! -d ${DATA_DIR}/players ]; then
	mkdir ${DATA_DIR}/players
fi
if [ ! -d ${DATA_DIR}/userraw ]; then
	mkdir ${DATA_DIR}/userraw
fi
echo "---Checking for 'server.cfg'---"
if [ -f ${DATA_DIR}/main/server.cfg ]; then
	echo "-------------------------------------------------------------------------------"
	echo "---------'server.cfg' in folder ${DATA_DIR}/main found, renaming it to---------"
	echo "---server.cfg.bak, please put server.cfg files in folder ${DATA_DIR}/players---"
	echo "-------------------------------------------------------------------------------"
	mv ${DATA_DIR}/main/server.cfg ${DATA_DIR}/main/server.cfg.bak
fi
if [ ! -f ${DATA_DIR}/players/server.cfg ]; then
	echo "---No 'server.cfg' found, downloading---"
    cd ${DATA_DIR}/players
	if wget -q -nc --show-progress --progress=bar:force:noscroll -O server.cfg https://raw.githubusercontent.com/ich777/docker-iw4x-server/master/config/server.cfg ; then
		echo "---Successfully downloaded 'server.cfg'!---"
	else
		echo "---Something went wrong, can't download 'server.cfg', putting server in sleep mode---"
		sleep infinity
	fi
else
	echo "---'server.cfg' found!---"
fi

echo "---Checking for 'playlists.info'---"
if [ ! -f ${DATA_DIR}/userraw/playlists.info ]; then
	echo "---No 'playlists.info' found, downloading---"
    cd ${DATA_DIR}/userraw
	if wget -q -nc --show-progress --progress=bar:force:noscroll -O playlists.info https://raw.githubusercontent.com/ich777/docker-iw4x-server/master/config/playlists.info ; then
		echo "---Successfully downloaded 'playlists.info'!---"
	else
		echo "---Something went wrong, can't download 'playlists.info', putting server in sleep mode---"
		sleep infinity
	fi
else
	echo "---'playlists.info' found!---"
fi
chmod -R ${DATA_PERM} ${DATA_DIR}

cd ${DATA_DIR}
wine iw4x.exe -dedicated +set net_port ${GAME_PORT} ${GAME_PARAMS}