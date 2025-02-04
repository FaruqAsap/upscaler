#!/bin/bash

# Menampilkan pesan awal
echo "Selamat datang di FFmpeg Video Converter!"

# Meminta input untuk URL video input
read -p "Masukkan path video input (misal: input_video.mp4): " input_video

# Meminta input untuk nama file output
read -p "Masukkan nama file output (tanpa ekstensi): " output_filename

# Meminta input untuk preset encoding
echo "Pilih preset untuk x264 (lebih rendah berarti lebih cepat, lebih tinggi lebih baik kualitas):"
echo "1. ultrafast"
echo "2. superfast"
echo "3. veryfast"
echo "4. faster"
echo "5. fast"
echo "6. medium (default)"
echo "7. slow"
echo "8. slower"
echo "9. veryslow"

read -p "Masukkan nomor preset (1-9): " preset_choice

case $preset_choice in
  1) preset="ultrafast" ;;
  2) preset="superfast" ;;
  3) preset="veryfast" ;;
  4) preset="faster" ;;
  5) preset="fast" ;;
  6) preset="medium" ;;
  7) preset="slow" ;;
  8) preset="slower" ;;
  9) preset="veryslow" ;;
  *) echo "Pilihan tidak valid, menggunakan preset default: medium"; preset="medium" ;;
esac

# Meminta input untuk memilih bitrate video
read -p "Masukkan bitrate video (misal: 5M untuk 5Mbps): " maxrate

# Meminta input untuk memilih CRF
read -p "Masukkan nilai CRF (default: 18, lebih rendah = kualitas lebih baik): " crf
crf=${crf:-18}  # Jika kosong, gunakan default 18

# Meminta input untuk memilih FPS (hingga 360 fps)
echo "Pilih FPS untuk interpolasi (maksimal 360fps):"
read -p "Masukkan nilai fps: " fps
fps=${fps:-60}  # Jika kosong, default ke 60fps

# Validasi FPS (harus tidak lebih dari 360)
if [[ "$fps" -gt 360 ]]; then
  echo "FPS tidak boleh lebih dari 360. Menetapkan FPS ke 60."
  fps=60
fi

# Menampilkan opsi audio
echo "Menetapkan audio dengan codec AAC dan bitrate 192k."

# Menetapkan filter untuk interpolasi FPS sesuai pilihan pengguna
filter="minterpolate='fps=$fps'"

# Menjalankan perintah ffmpeg dengan input pengguna
echo "Mengonversi video dengan pengaturan berikut:"
echo "Preset: $preset"
echo "Bitrate: $maxrate"
echo "CRF: $crf"
echo "FPS: $fps"

ffmpeg -i "$input_video" -filter:v "$filter" -c:v libx264 -preset "$preset" -crf "$crf" -maxrate "$maxrate" -bufsize 10M -threads 0 -c:a aac -b:a 192k -strict experimental -f mp4 "$output_filename.mp4"

echo "Konversi selesai! File output disimpan sebagai $output_filename.mp4"
