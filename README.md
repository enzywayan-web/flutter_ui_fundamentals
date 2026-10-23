# Course Explorer — Flutter UI Fundamentals

Project ini merupakan aplikasi Flutter untuk pembelajaran mata kuliah Pemrograman Mobile. Project dikembangkan secara bertahap dari Course Explorer menjadi Course Data Manager dengan integrasi REST API.

## Getting Started

### Teknologi yang Digunakan
- Flutter
- Dart
- Package `http`
- REST API
- Git dan GitHub

## Tahap 1 — Membaca REST Endpoint dan JSON

### Informasi API
- **Base URL:** https://course-api-pearl.vercel.app
- **Endpoint:** https://course-api-pearl.vercel.app/courses
- **HTTP Method:** GET
- **Status Code:** 200 OK
- **Resource:** courses

### Fungsi Endpoint
Endpoint `/courses` digunakan untuk mengambil daftar mata kuliah dari REST API yang diberikan dosen.

### Struktur Response JSON
Respons API berupa array yang berisi data mata kuliah. Setiap data memiliki field berikut:

| Field | Keterangan |
|---|---|
| `id` | Identitas mata kuliah |
| `code` | Kode mata kuliah |
| `title` | Nama mata kuliah |
| `credits` | Jumlah SKS |
| `status` | Status mata kuliah |
| `created_at` | Waktu pembuatan data |

### Hasil Pengujian
Pengujian dilakukan menggunakan terminal VS Code dengan perintah:

```bash
curl.exe -i https://course-api-pearl.vercel.app/courses
```

Hasil pengujian menunjukkan status HTTP `200 OK`, yang berarti permintaan berhasil. Respons JSON yang diperoleh berisi 7 data mata kuliah pada saat pengujian dilakukan.

### Contoh Response JSON

```json
{
  "id": 1,
  "code": "MOB01",
  "title": "Git & GitHub",
  "credits": 2,
  "status": "active",
  "created_at": "2026-10-21T03:28:08.91197Z"
}
```

### Catatan
Tahap ini berfokus pada pengenalan endpoint REST API, HTTP method GET, status code, dan struktur JSON. Informasi tersebut menjadi dasar untuk proses pengambilan dan pengolahan data mata kuliah pada tahap berikutnya.