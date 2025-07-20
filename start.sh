# Ekran adı (istediğini verebilirsin)
SCREEN_NAME="mc"

# Screen zaten açık mı kontrol et
if screen -list | grep -q "$SCREEN_NAME"; then
  echo "Screen '$SCREEN_NAME' zaten açık."
else
  echo "Screen '$SCREEN_NAME' başlatılıyor..."
  screen -dmS $SCREEN_NAME java -Xms2G -Xmx5G -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:+ParallelRefProcEnabled -jar paper.jar nogui
  echo "Sunucu '$SCREEN_NAME' içinde başlatıldı."
fi