#!/bin/bash

# Ekran adı
SCREEN_NAME="mc"

# Yedek ayarları
WORLD_DIRS=("world" "world_nether" "world_the_end")
BACKUP_DIR="$HOME/Desktop/mc_yedek"
MAX_BACKUPS=2   # En fazla kaç eski yedek tutulacak (ör: 2 = 2 eski + 1 yeni = 3 toplam)

mkdir -p "$BACKUP_DIR"

# Screen zaten açık mı kontrol et
if screen -list | grep -q "$SCREEN_NAME"; then
  echo "Screen '$SCREEN_NAME' zaten açık."
else
  echo "Screen '$SCREEN_NAME' başlatılıyor..."
  screen -dmS $SCREEN_NAME bash -c '
    # === Yedekleme fonksiyonu ===
    backup_worlds() {
      TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
      BACKUP_FILE="$HOME/Desktop/mc_yedek/mc_backup_$TIMESTAMP.tar.gz"

      echo "📦 World klasörleri yedekleniyor: $BACKUP_FILE"
      tar -czf "$BACKUP_FILE" world world_nether world_the_end

      # Eski yedekleri sil (MAX_BACKUPS kadar bırak)
      MAX_BACKUPS=2
      BACKUP_COUNT=$(ls -1t $HOME/Masaüstü/mc_yedek/mc_backup_*.tar.gz 2>/dev/null | wc -l)
      if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
        OLDEST=$(ls -1t $HOME/Masaüstü/mc_yedek/mc_backup_*.tar.gz | tail -n +$(($MAX_BACKUPS + 1)))
        echo "🗑 Eski yedekler siliniyor:"
        echo "$OLDEST"
        rm -f $OLDEST
      fi
    }

    while true; do
      java -Xms6G -Xmx12G -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:+ParallelRefProcEnabled -jar paper.jar nogui

      # Sunucu kapandıktan sonra yedek al
      backup_worlds

      echo "Sunucu kapandı, 5 saniye sonra yeniden başlıyor..."
      sleep 5
    done
  '
  echo "Sunucu '$SCREEN_NAME' içinde başlatıldı."
fi