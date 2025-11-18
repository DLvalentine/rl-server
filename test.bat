echo OFF
cls
del C:\Users\%USERNAME%\.ssh\known_hosts
ssh player@localhost -p 2222