echo OFF
cls
REM this is a dev stop, because it stops and removes both the container and image, requiring a rebuild
echo Stopping rlserver and cleaning up...
docker container stop rlserver
docker container rm rlserver
docker image rm rlserver