echo OFF
cls
REM to test: ssh player@localhost -p 2222
echo Starting rlserver...
docker run -d --name rlserver -p 2222:22 rlserver