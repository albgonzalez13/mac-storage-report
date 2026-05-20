#!/bin/bash

REPORT="$HOME/Desktop/informe_espacio_mac.txt"

echo "=====================================" > "$REPORT"
echo " INFORME USO DE DISCO - macOS" >> "$REPORT"
echo " Fecha: $(date)" >> "$REPORT"
echo "=====================================" >> "$REPORT"
echo "" >> "$REPORT"

echo "====================================="
echo "Analizando espacio en disco..."
echo "Esto puede tardar varios minutos..."
echo "====================================="

#############################################
# INFORMACIÓN GENERAL
#############################################

echo "===== ESPACIO GENERAL =====" >> "$REPORT"
df -h >> "$REPORT"
echo "" >> "$REPORT"

#############################################
# CARPETAS MÁS GRANDES DEL HOME
#############################################

echo "===== TOP CARPETAS HOME =====" >> "$REPORT"

du -hd 1 "$HOME" 2>/dev/null | sort -hr | head -30 >> "$REPORT"

echo "" >> "$REPORT"

#############################################
# CARPETAS MÁS GRANDES SISTEMA
#############################################

echo "===== TOP CARPETAS SISTEMA =====" >> "$REPORT"

sudo du -hd 1 / 2>/dev/null | sort -hr | head -30 >> "$REPORT"

echo "" >> "$REPORT"

#############################################
# ARCHIVOS MÁS GRANDES
#############################################

echo "===== TOP ARCHIVOS (>500MB) =====" >> "$REPORT"

sudo find / \
  -type f \
  -size +500M \
  -not -path "/System/*" \
  -not -path "/private/var/vm/*" \
  -exec ls -lh {} \; 2>/dev/null \
  | awk '{ print $5, $9 }' \
  | sort -hr >> "$REPORT"

echo "" >> "$REPORT"

#############################################
# DOCKER
#############################################

echo "===== DOCKER =====" >> "$REPORT"

if command -v docker >/dev/null 2>&1; then
    docker system df >> "$REPORT" 2>/dev/null
else
    echo "Docker no instalado" >> "$REPORT"
fi

echo "" >> "$REPORT"

#############################################
# MAIL
#############################################

echo "===== MAIL =====" >> "$REPORT"

du -sh "$HOME/Library/Mail" 2>/dev/null >> "$REPORT"

echo "" >> "$REPORT"

#############################################
# CACHÉS
#############################################

echo "===== CACHES =====" >> "$REPORT"

du -sh "$HOME/Library/Caches" 2>/dev/null >> "$REPORT"

echo "" >> "$REPORT"

#############################################
# XCODE
#############################################

echo "===== XCODE =====" >> "$REPORT"

du -sh "$HOME/Library/Developer/Xcode" 2>/dev/null >> "$REPORT"

echo "" >> "$REPORT"

#############################################
# IOS BACKUPS
#############################################

echo "===== IPHONE BACKUPS =====" >> "$REPORT"

du -sh "$HOME/Library/Application Support/MobileSync" 2>/dev/null >> "$REPORT"

echo "" >> "$REPORT"

#############################################
# DOWNLOADS
#############################################

echo "===== DOWNLOADS =====" >> "$REPORT"

du -sh "$HOME/Downloads" 2>/dev/null >> "$REPORT"

echo "" >> "$REPORT"

#############################################
# NODE MODULES
#############################################

echo "===== NODE_MODULES =====" >> "$REPORT"

find "$HOME" \
  -type d \
  -name "node_modules" \
  -prune \
  -exec du -sh {} \; 2>/dev/null \
  | sort -hr \
  | head -50 >> "$REPORT"

echo "" >> "$REPORT"

#############################################
# ARCHIVOS PST/MBOX/MAILDIR
#############################################

echo "===== ARCHIVOS MAIL GRANDES =====" >> "$REPORT"

find "$HOME" \
  \( -iname "*.mbox" -o -iname "*.pst" -o -iname "*.ost" \) \
  -exec ls -lh {} \; 2>/dev/null \
  | awk '{ print $5, $9 }' \
  | sort -hr >> "$REPORT"

echo "" >> "$REPORT"

#############################################
# FINAL
#############################################

echo "====================================="
echo "Informe generado:"
echo "$REPORT"
echo "====================================="
