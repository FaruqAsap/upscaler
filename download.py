import yt_dlp

def download_video(url, output_filename):
    # Menyusun opsi unduhan
    ydl_opts = {
        'format': 'best',  # Pilih resolusi tertinggi secara otomatis
        'outtmpl': f'{output_filename}.mp4',  # Nama file output
        'merge_output_format': 'mp4',  # Menggabungkan video dan audio dalam format mp4
    }

    # Mengunduh video
    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        ydl.download([url])

def main():
    # Input link video dari terminal
    video_url = input("Masukkan URL video YouTube: ")

    # Input nama file output
    output_filename = input("Masukkan nama file output (tanpa ekstensi): ")

    # Mengunduh video dengan pilihan resolusi tertinggi
    download_video(video_url, output_filename)
    print(f"Video telah diunduh dengan nama {output_filename}.mp4")

if __name__ == "__main__":
    main()
