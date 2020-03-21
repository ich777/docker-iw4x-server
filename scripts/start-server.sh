#!/bin/bash
echo "---Checking if IW4x is installed---"
if [ ! -f ${DATA_DIR}/iw4x.exe ]; then
	echo "---IW4x not found, downloading---"
	if wget -q -nc --show-progress --progress=bar:force:noscroll -O iw4x_files.zip "${IW4X_DL_URL}" ; then
		echo "---Successfully downloaded IW4x!---"
	else
		echo "---Something went wrong, can't download IW4x, putting server in sleep mode---"
		sleep infinity
	fi
	unzip -o ${DATA_DIR}/iw4x_files.zip
	rm ${DATA_DIR}/iw4x_files.zip
fi

echo "---Checking if IW4x DLC is installed---"
if [ ! -f ${DATA_DIR}/iw4x.exe ]; then
	echo "---IW4x not found, downloading---"
	if wget -q -nc --show-progress --progress=bar:force:noscroll -O iw4x_dlc.zip "${IW4X_DLC_URL}" ; then
		echo "---Successfully downloaded IW4x DLC!---"
	else
		echo "---Something went wrong, can't download IW4x DLC, putting server in sleep mode---"
		sleep infinity
	fi
	unzip -o ${DATA_DIR}/iw4x_dlc.zip
	rm ${DATA_DIR}/iw4x_dlc.zip
fi

echo "---Checking if gamefiles are in place---"
if [ ! -f ${DATA_DIR}/main/iw_00.iwd ]; then
	echo "---Gamefiles not found, putting server into sleep mode---"
	sleep infinity
else
	echo "---Gamefiles found!---"
fi

export WINEARCH=win32
export WINEPREFIX=/iw4x/WINE32
echo "---Checking if WINE workdirectory is present---"
if [ ! -d ${DATA_DIR}/WINE32]; then
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

echo "---Sleep zZz---"
sleep infinity

cd ${DATA_DIR}
wine iw4x.exe -dedicated ${GAME_PARAMS}