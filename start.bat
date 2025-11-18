echo OFF
cls
REM to test: ssh player@localhost -p 2222
echo Starting rl-server...
docker run -d --name rl-server -p 2222:22 rl-server