# mac-storage-report

Script Bash para analizar el uso de disco en macOS y generar un informe con las carpetas, archivos y servicios que más espacio ocupan.

Está pensado para detectar rápidamente problemas de espacio provocados por Docker Desktop, cachés, backups, simuladores, descargas, `node_modules`, Mail, Xcode y otros directorios habituales en entornos de desarrollo.

## Qué analiza

- Espacio general del disco
- Carpetas más pesadas del usuario
- Carpetas principales del sistema
- Archivos grandes
- Docker Desktop
- Mail
- Cachés
- Xcode
- Backups de iPhone
- Descargas
- `node_modules`
- Archivos relacionados con correo

## Uso

```bash
chmod +x mac-storage-report.sh
./mac-storage-report.sh
