#!/bin/bash

SCREEN_NAME="mc"

while true
do
  # Screen zaten açık mı kontrol et
  if screen -list | grep -q "$SCREEN_NAME"; then
    echo "Screen '$SCREEN_NAME' zaten açık, durdurup yeniden başlatılıyor..."
    # Önce kapatıyoruz
    screen -S $SCREEN_NAME -X quit
    sleep 5
  fi

  echo "Screen '$SCREEN_NAME' başlatılıyor..."
  screen -dmS $SCREEN_NAME java -Xms2G -Xmx5G -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:+ParallelRefProcEnabled -jar paper.jar nogui

  # Screen oturumu kapandığında döngü yeniden başlayacak
  echo "Sunucu kapandı. 10 saniye sonra yeniden başlatılacak..."
  sleep 10
done
