FROM ich777/winehq-baseimage

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-iw4x-server"

RUN apt-get update && \
	apt-get -y install --no-install-recommends unzip && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/iw4x"
ENV GAME_PORT=27060
ENV GAME_PARAMS="+exec server.cfg +sv_maxclients 12 +set fs_game mods/bots +set playlistFilename playlists.info"
ENV FORCE_UPDATE=""
ENV IW4X_DL_URL="https://dss0.cc/updater/iw4x_files.zip"
ENV IW4X_DLC_URL="https://iw4x-my.sharepoint.com/:u:/g/personal/emosewaj_iw4x_onmicrosoft_com/EYnWYmCXExpEvn-bL2262Q0BSy0jVZF0FXslvpJEDPE5Fw?e=gPx8RF&download=1"
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV DATA_PERM=770
ENV USER="iw4x"

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]