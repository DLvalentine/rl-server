echo OFF
cls
REM this is a dev stop, because it stops and removes both the container and image, requiring a rebuild
echo Stopping rl-server and cleaning up...
docker container stop rl-server
docker container rm rl-server
docker image rm rl-server