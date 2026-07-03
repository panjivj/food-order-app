# Food Order App

Food Order App adalah aplikasi pemesanan makanan sederhana berbasis Flutter. Pengguna dapat melihat daftar menu, menambahkan makanan atau minuman ke keranjang, menghapus pesanan, membatalkan seluruh pesanan, serta melakukan checkout. Total harga dan jumlah item diperbarui secara otomatis.

## Fitur

- Menampilkan daftar makanan dan minuman beserta harga.
- Menambahkan menu ke keranjang.
- Menampilkan jumlah item dan total harga dalam format rupiah.
- Menghapus satu item atau membatalkan seluruh pesanan.
- Menampilkan konfirmasi sebelum membatalkan pesanan.
- Melakukan checkout dan menampilkan total pembayaran.
- Tampilan responsif menggunakan Material Design 3.

## Identitas Pembuat

- Created By: **Panji Jaya Sutra**
- NIM: **20220801517**

## Teknologi

- Flutter 3.41.7 (stable)
- Dart 3.11.5
- Material Design 3
- Android SDK dan Java Development Kit (JDK) 17

## Persyaratan Environment

Siapkan perangkat berikut sebelum menjalankan proyek:

1. [Git](https://git-scm.com/downloads)
2. [Flutter SDK](https://docs.flutter.dev/get-started/install) versi stable
3. [Android Studio](https://developer.android.com/studio) beserta Android SDK
4. JDK 17
5. Emulator Android atau perangkat Android fisik dengan USB debugging aktif

Pastikan perintah `flutter` dan `dart` sudah tersedia pada `PATH`. Periksa konfigurasi dengan:

```bash
flutter --version
flutter doctor
```

Jika lisensi Android belum diterima, jalankan:

```bash
flutter doctor --android-licenses
```

Ikuti instruksi hingga `flutter doctor` tidak menampilkan masalah penting pada bagian Flutter dan Android toolchain.

## Mengunduh dan Menjalankan Source Code

Clone repository dan masuk ke direktori proyek:

```bash
git clone https://github.com/panjivj/food-order-app.git
cd food-order-app
```

Unduh semua dependency:

```bash
flutter pub get
```

Hubungkan perangkat Android atau jalankan emulator, kemudian periksa perangkat yang tersedia:

```bash
flutter devices
```

Jalankan aplikasi dalam mode pengembangan:

```bash
flutter run
```

Jika terdapat beberapa perangkat, tentukan perangkat tujuan:

```bash
flutter run -d <device-id>
```

## Build APK Android

Buat APK release dengan perintah:

```bash
flutter build apk --release
```

APK akan dihasilkan di:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Untuk menghasilkan APK terpisah berdasarkan arsitektur perangkat agar ukuran file lebih kecil, gunakan:

```bash
flutter build apk --release --split-per-abi
```

## Instalasi APK

### Menggunakan ADB

Pastikan perangkat terdeteksi oleh `adb`, lalu jalankan:

```bash
adb devices
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

Opsi `-r` akan memperbarui instalasi yang sudah ada tanpa menghapus data aplikasi.

### Instalasi Manual

1. Salin `app-release.apk` ke perangkat Android.
2. Buka file APK melalui aplikasi pengelola berkas.
3. Izinkan instalasi dari sumber tidak dikenal jika diminta.
4. Tekan **Install**, lalu buka aplikasi **Pemesanan Makanan**.

## Pengujian dan Pemeriksaan Kode

Jalankan analisis statis dan seluruh widget test sebelum membuat APK:

```bash
flutter analyze
flutter test
```

## Struktur Utama

```text
lib/main.dart                 # Source code utama aplikasi
test/widget_test.dart         # Pengujian tampilan dan keranjang
android/                      # Konfigurasi native Android
pubspec.yaml                  # Metadata dan dependency Flutter
```

## Catatan

Aplikasi ini menyimpan isi keranjang sementara di memori. Data keranjang akan kembali kosong ketika aplikasi ditutup atau dimulai ulang.
