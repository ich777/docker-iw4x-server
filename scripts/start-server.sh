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

echo "---Sleep zZz---"
sleep infinity