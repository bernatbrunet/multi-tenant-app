@ echo off
echo Connection to database...
echo.

rem get the path to the .env file
set "env_file=%~dp0..\..\..\.env"

rem Read the .env file variables
for /f "tokens=1,* delims==" %%a in ('type "%env_file%"') do set "%%a=%%b"

rem Conexión SSH y ejecución del script en la máquina virtual
ssh root@%IP_CLOUDING% "cd /home/root/multi-tenant-app/scripts/artillery && ./clean.sh"

start  cmd /k "artillery run ./test/artillery/clouding-docker/stock-changeloca.yml --target http://%IP_CLOUDING%:3000"
start /WAIT cmd /k "artillery run ./test/artillery/clouding-docker/stock-changelocb.yml --target http://%IP_CLOUDING%:3000"

rem Conexión SSH y ejecución del script en la máquina virtual
ssh root@%IP_CLOUDING% "cd /home/root/multi-tenant-app/scripts/artillery && ./clean.sh"

start cmd /k "artillery run ./test/artillery/clouding-docker/stock-group.yml --target http://%IP_CLOUDING%:3000"
start /WAIT cmd /k "artillery run ./test/artillery/clouding-docker/stock-ungroup.yml --target http://%IP_CLOUDING%:3000"

rem Conexión SSH y ejecución del script en la máquina virtual
ssh root@%IP_CLOUDING% "cd /home/root/multi-tenant-app/scripts/artillery && ./clean.sh"

start cmd /k "artillery run ./test/artillery/clouding-docker/stock-create.yml --target http://%IP_CLOUDING%:3000"
start /WAIT cmd /k "artillery run ./test/artillery/clouding-docker/stock-divide.yml --target http://%IP_CLOUDING%:3000"

rem Conexión SSH y ejecución del script en la máquina virtual
ssh root@%IP_CLOUDING% "cd /home/root/multi-tenant-app/scripts/artillery && ./clean.sh"

start /WAIT cmd /k "artillery run ./test/artillery/clouding-docker/stock-update.yml --target http://%IP_CLOUDING%:3000"

rem Conexión SSH y ejecución del script en la máquina virtual
ssh root@%IP_CLOUDING% "cd /home/root/multi-tenant-app/scripts/artillery && ./clean.sh"

start /WAIT cmd /k "artillery run ./test/artillery/clouding-docker/stock-get.yml --target http://%IP_CLOUDING%:3000"