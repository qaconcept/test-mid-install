@echo off
FOR /F "tokens=2 delims==" %%a IN ('find "SN_IMAGE_NAME" ^<.env') DO SET sn_image_name=%%a
FOR /F "tokens=2 delims==" %%a IN ('find "SN_CONTAINER_NAME" ^<.env') DO SET sn_container_name=%%a

docker-compose build
docker run -i --name %sn_image_name %sn_container_name%
