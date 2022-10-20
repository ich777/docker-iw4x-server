# IW4x Docker optimized for Unraid
This Docker will download and install a simple IW4x Server.

**First Start:** Please keep in mind that on first start the container will pull the necessary game files and this can take some time depending on your internet connection.

**ATTENTION:** You need to copy over the files from your CoD:MW2 folder to the server directory otherwise the server will not start.

**DOWNLOAD NOTICE:** If a download fails or is not available you can simply put the .zip files in the server directory and the container will extract the files and start the server.

**WINE NOTICE:** Since this container runs with WINE i can't guarantee that it will not crash or other weird behavior.

## Example Env params
| Name | Value | Example |
| --- | --- | --- |
| SERVER_DIR | Server Files | /iw4x |
| GAME_PARAMS | Specify your Startup Parameters here. | +exec server.cfg +sv_maxclients 12 +set fs_game mods/bots +set playlistFilename playlists.info |
| FORCE_UPDATE | Set to 'true' (without quotes) to force an update. | empty |
| IW4X_DL_URL | Main IW4x Download URL (only change if you know what you are doing) | https://dss0.cc/updater/iw4x_files.zip |
| IW4X_DLC_URL | IW4x DLC Download URL (only change if you know what you are doing) | https://iw4x-my.sharepoint.com/:u:/g/personal/emosewaj_iw4x_onmicrosoft_com/EYnWYmCXExpEvn-bL2262Q0BSy0jVZF0FXslvpJEDPE5Fw?e=gPx8RF&download=1 |
| GAME_PORT | Change if you need another Game Port (please create a new TCP and UDP Port with the corresponding port number) | 28960 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | true |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name IW4x -d \
	-p 28960:28960 -p 28960:28960/udp \
	--env 'GAME_PARAMS=+exec server.cfg +sv_maxclients 12 +set fs_game mods/bots +set playlistFilename playlists.info' \
	--env 'IW4X_DL_URL=https://dss0.cc/updater/iw4x_files.zip' \
	--env 'IW4X_DLC_URL=https://iw4x-my.sharepoint.com/:u:/g/personal/emosewaj_iw4x_onmicrosoft_com/EYnWYmCXExpEvn-bL2262Q0BSy0jVZF0FXslvpJEDPE5Fw?e=gPx8RF&download=1' \
	--env 'GAME_PORT=28960' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/iw4x:/iw4x \
	ich777/iw4x-server
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/