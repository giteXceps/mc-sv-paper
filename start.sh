# Ekran adı (istediğini verebilirsin)
SCREEN_NAME="mc"

# Screen zaten açık mı kontrol et
if screen -list | grep -q "$SCREEN_NAME"; then
  echo "Screen '$SCREEN_NAME' zaten açık."
else
  echo "Screen '$SCREEN_NAME' başlatılıyor..."
  screen -dmS $SCREEN_NAME java -Xmx5G -Xms1G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=50 -jar paper.jar nogui
  echo "Sunucu '$SCREEN_NAME' içinde başlatıldı."
fi
