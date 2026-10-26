# Flutter UI Fundamentals — Course Explorer

## Deskripsi Aplikasi
Course Explorer adalah aplikasi Flutter untuk menampilkan dan mengelola data mata kuliah. Aplikasi memiliki tampilan responsif, navigasi antarhalaman, fitur favorit, serta pengelolaan data mata kuliah.

## Fitur Utama
- Tampilan responsif untuk ukuran layar berbeda.
- Navigasi halaman Home, Courses, dan Profile.
- Menampilkan dan mengelola data mata kuliah.
- Menambahkan, mengubah, dan menghapus data mata kuliah.
- Menandai mata kuliah favorit.
- Pengujian penanganan HTTP 404, JSON mapping error, dan akses Supabase.
- Validasi kode mata kuliah duplikat pada data yang telah dimuat.

## Teknologi yang Digunakan
- Flutter dan Dart.
- Provider untuk pengelolaan state.
- Supabase sebagai backend dan database.
- Git dan GitHub untuk version control.

## Arsitektur Singkat
- `lib/models/`: model data mata kuliah.
- `lib/providers/`: pengelolaan state dan logika aplikasi.
- `lib/repositories/`: abstraksi akses data.
- `lib/services/`: komunikasi dengan sumber data.
- `lib/screens/`: halaman aplikasi.
- `lib/widgets/`: komponen antarmuka yang dapat digunakan kembali.
- `lib/main.dart`: entry point dan konfigurasi utama aplikasi.

## Cara Menjalankan
1. Instal Flutter SDK dan siapkan Android Emulator atau perangkat Android.
2. Clone repository ini.
3. Buka terminal di folder project.
4. Jalankan `flutter pub get`.
5. Konfigurasikan URL Supabase dan anon/publishable key sesuai kebutuhan project.
6. Jalankan `flutter run`.

## Keamanan
Jangan memasukkan password, access token, `service_role` key, atau credential rahasia ke repository. Terapkan Row Level Security (RLS) dan validasi pada backend sesuai kebutuhan aplikasi.

## Informasi Repository
Repository: https://github.com/enzywayan-web/flutter_ui_fundamentals

NIM: [2415051070]
Nama: [Ni Wayan Enzy Araintini]
Mata Kuliah: Pemrograman Berbasis Mobile