@'
# Dokumentasi Tahap 11 — Database Courses

## 1. Tujuan
Membuat tabel courses pada Supabase untuk menyimpan data mata kuliah.

## 2. Struktur Tabel

| Kolom | Tipe Data | Keterangan |
|---|---|---|
| id | BIGINT IDENTITY | Primary key |
| code | TEXT | Kode mata kuliah |
| title | TEXT | Judul mata kuliah |
| credits | INT | Jumlah SKS |
| status | TEXT | Status mata kuliah |
| created_at | TIMESTAMPTZ | Waktu pembuatan |

## 3. Data Awal
1. TIK19505 — Pemrograman Mobile — 3 SKS — active
2. TIK19506 — Manajemen dan Kepemimpinan — 2 SKS — active
3. TIK19504 — Pengolahan Citra Digital — 3 SKS — done

## 4. Aturan Status
Status dibatasi menjadi planned, active, atau done.

## 5. Keamanan Database
RLS diaktifkan pada tabel courses. Policy akses disesuaikan dengan kebutuhan praktikum. Policy permisif hanya untuk database latihan, bukan aplikasi produksi.

## 6. Pengujian
- Pembuatan tabel: isi sesuai hasil pemeriksaan.
- Data awal: isi sesuai hasil pemeriksaan.
- Pengujian akses: isi setelah diuji.
'@ | Set-Content -Path docs\tahap-11-database-courses.md -Encoding UTF8