Zhafira Uzma || 2406495451 || PBP C  

# **Tugas Individu 8**
## **1.  Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?**  
Kita perlu membuat model Dart saat mengambil/mengirim data JSON untuk mengubah data menjadi lebih terstruktur dan aman (type-safe dan null-safe) ketika ingin mengambil atau mengirim data dari/ke JSON. Jika kita hanya menggunakan pemetaan Map<String, dynamic> secara langsung yang akan terjadi adalah, pertama,  type safety hilang karena compiler hanya mengetahui nilai variable sebagai dynamic bukan spesifik type seperti int, String, double, dll. Kedua, perlu memeriksa secara manual mengenai null-safety setiap kali kita mengakses key. Ketiga, Sulitnya untuk melakukan refactor yang membuat maintabilitynya rendah. 

## **2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.**  
Dalam pengembangan aplikasi Flutter yang terintegrasi dengan layanan backend Django, package http dan kelas CookieRequest memiliki peran yang saling melengkapi namun berbeda secara fundamental. Package http berfungsi sebagai fondasi teknis utama untuk komunikasi jaringan. Package http menyediakan metode standar seperti GET, POST, PUT, dan DELETE yang memungkinkan aplikasi mengirim data ke server dan menerima responsnya. Namun, karakteristik utama dari http adalah sifatnya yang stateless yang berartinya, setiap kali user melakukan permintaan (seperti login akun), http menganggapnya sebagai kejadian yang baru, tanpa membawa informasi apa pun dari permintaan sebelumnya, termasuk status login Anda. Karena itu, peran vital CookieRequest diperlukan sebagai session manager. CookieRequest biasanya merupakan kelas kustom yang dibangun di atas http untuk menutupi kelemahan tersebut. Fungsi utamanya adalah menjadikan komunikasi bersifat stateful dengan cara menangkap dan menyimpan cookie yang dikirimkan server saat pengguna berhasil login. Untuk setiap permintaan data selanjutnya, CookieRequest akan secara otomatis menyisipkan kembali cookie yang tersimpan tersebut ke dalam header permintaan. Hal ini memastikan server dapat terus memverifikasi identitas pengguna di setiap langkah, dari halaman login hingga halaman profil.

Perbedaan mendasar pada package http dan CookieRequest terletak pada persistensi data sesi. Package http murni berfungsi sebagai mekanisme transportasi data. Package http tidak memelihara konteks hubungan antara klien dan server, sehingga autentikasi berbasis sesi tidak dapat berjalan secara otomatis karena server tidak menerima kredensial sesi pada permintaan kedua dan seterusnya. Sebaliknya, CookieRequest berfungsi sebagai pengelola persistensi sesi; ia memastikan bahwa token autentikasi yang diterbitkan server tetap terjaga dan dikirimkan kembali secara konsisten, memungkinkan backend seperti Django untuk mengidentifikasi bahwa serangkaian permintaan yang berbeda berasal dari pengguna yang sama yang telah terautentikasi.
 

## **3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.**  
Instance CookieRequest diperlukan untuk semua komponen aplikasi fultter karena untuk mempertahankan satu login session yang konsisten di seluruh bagian aplikasi. Misalnya jika seseorang sedang berada di Homepage sebuah aplikasi dan ingin pindah ke page lain, misalnya profile page intance CookieRequest ini yang akan meminta data dari database yang akan menampilkan data yang sesuai dengan pemiliki cookie session itu. Jika instance CookieRequest tidak dibagikan ke seluruh komponen aplikasi flutter, aplikasi akan mengalami error mengenali penggunanya.  


## **4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?**  
Pada proyek aplikasi ini, terdapat beberapa konfigurasi konektivitas yang dapat membuat flutter bisa berkomunikasi dengan Django, di antaranya AlLOWED_HOSTS, internet permission di file AndroidManifest.xml, CORS, dan pengaturan cookie. Masing-masing konfigurasi tersebut memiliki perannya masing-masing seperti:
- ALLOWED_HOSTS memberi tahu server Django domain yang diizinkan untuk terhubung. Kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS agar Django memngizinkan permintaan yang datang dari aplikasi yang berjalan di Android Emulator. Jika kita tidak memberikan konfigurasi ini, Aplikasi flutter akan gagal mengambil data dari Django dan Django akan menolak koneksi lalu mengembalikan respons HTTP 400
- Internet permission di file AndroidManifest.xml untuk meminta izin kepada sistem operasi android agar aplikasi dapat mengakses internet. Kita memerlukan konfigurasi ini agar aplikasi Flutter dapat melakukan panggilan jaringan. Jika tidak memberikan Internet permission di android, Aplikasi tidak akan bisa terhubung ke internet sama sekali dan Seluruh fitur online akan gagal.
- CORS untuk memberikan izin kepada aplikasi flutter web untuk membuat request API ke server Django. Kita perlu meng-install django-cors-headers dan mengkonfigurasikannya di Django agar server server akan menambahkan header HTTP ke responsnya. Header ini memberi tahu browser bahwa localhost:5000 dapat mengambil data dari browser. Jika tidak melakukan konfigurasi CORS, Aplikasi web Kita akan gagal memuat data apa pun dari API.
- pengaturan cookie untuk memastikan cookie dikirm dengan benar agar login session tetap terbaca. Kita perlu mengonfigurasi Django (di settings.py) agar menyetel cookie-nya dengan SameSite='None' dan Secure=True agar browser selalu mengirim cookie tersebut, bahkan pada permintaan cross-origin. Jika kita mengatur SamSite/cookie nya salah, Fitur login tidak akan berfungsi. Pengguna bisa login, tetapi saat mereka menavigasi ke halaman lain atau mencoba mengakses endpoint yang dilindungi, mereka akan dianggap logout. Django akan terus-menerus melihat permintaan sebagai AnonymousUser karena cookie sessionid tidak diterima oleh backend.


## **5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.**
**Mengirim Input dari Flutter ke Database Django**
- Pengguna memasukkan data ke dalam widget (TextField dalam sebuah Form).
- Data ini disimpan sementara di Flutter.
- Saat tombol "Submit" ditekan, program mengambil data dari controller tersebut.
- Program mengonversinya menjadi format Map di Dart, yang kemudian di-encode menjadi string JSON.
- Program menggunakan package seperti http untuk membuat HTTP POST Request.
- Program menargetkan URL endpoint Django yang spesifik
- Server Django Anda menerima request di address .../api/add-item/.
- File urls.py Django mencocokkan URL ini dan meneruskan request tersebut ke View yang sesuai.
- Di dalam View, Program menggunakan Serializer.
- Serializer otomatis memvalidasi data.
- Jika data valid, view akan memanggil serializer.save().
- Server Django kemudian mengirimkan respons kembali ke Flutter untuk memberi tahu bahwa data berhasil disimpan.

**Menampilkan Data dari Django di Layar Flutter**
- Flutter men-trigger Pengambilan Data:
- Flutter membuat HTTP GET Request ke endpoint daftar item Django.
- urls.py Django menerima request ini dan meneruskannya ke View yang sesuai. View tersebut menggunakan Model Django untuk mengambil data dari Database.
- Data yang didapat dari database masih mentah yang akan diolah dengan serializer menjadi format JSON.
- Django mengirimkan respons HTTP 200 - OK kembali ke Flutter.
- Aplikasi Flutter Anda menerima string JSON.
- Program menggunakan json.decode() untuk mengubah string JSON tersebut menjadi struktur data Dart.
- Data yang sudah menjadi objek Dart ini disimpan ke dalam state aplikasi.
- Widget seperti FutureBuilder atau ListView.builder menangkap perubahan state ini.
- Setelah state terisi data, Flutter secara otomatis rebuild UI. ListView.builder akan meng-loop data List<ItemModel> dan merender widget untuk setiap item di layar.

## **6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.**
**Registrasi Akun (Register)**
- user mengisi data (username & password) dalam Form di aplikasi Flutter.
- Saat tombol "Register" ditekan, Flutter mengemas data ini ke dalam format JSON.
- Flutter mengirimkan HTTP POST Request ke endpoint registrasi Django. Body dari request ini berisi data JSON tadi.
- Django menerima request di view yang sesuai. Serializer Django Rest Framework (DRF) memvalidasi data apakah input datanya valid
- Jika data valid, Django membuat objek User baru di database. Password secara otomatis dienkripsi sebelum disimpan. Jika input data tidak valid, Django mengirimkan respons HTTP 400 (Bad Request) berisi detail kesalahan.
- Django mengirimkan respons HTTP 201 (Created) yang menandakan registrasi berhasil.
- Flutter menerima respons sukses dan menampilkan pesan kepada pengguna dan mungkin mengarahkan mereka ke halaman Login.  

**Login Akun**
- User memasukkan username dan password di halaman login.
- Flutter mengirimkan HTTP POST Request ke endpoint login Django. Body berisi JSON username dan password.
- Django menerima kredensial. Django menggunakan fungsi authenticate() bawaannya untuk memeriksa database
- Jika input sesuia dengan yang ada di database, user terautentikasi. Django menghasilkan sepasang Token yaitu access token untuk flutter mengakses data dan refresh token untuk mendapatkan access token baru.Jika input tidak sesuai dengan database, Django mengirimkan respons HTTP 401 (Unauthorized) atau 400 (Bad Request) dengan pesan "Invalid credentials".
- Django mengirimkan respons HTTP 200. Body dari respons ini berisi kedua Token tersebut dalam format JSON.
- Flutter menerima kedua token tersebut dan menyimpan kedua token ini di tempat yang aman di perangkat, seperti menggunakan package flutter_secure_storage. 
- Setelah token disimpan, Flutter tahu bahwa pengguna sudah login.
- Flutter kemudian melakukan navigasi ke main menu.  

**Menampilkan Menu**
- MainMenuPage dimuat. Halaman ini menampilkan data yang spesifik untuk pengguna.
- Flutter bersiap untuk membuat HTTP GET Request ke endpoint yang dilindungi.
- Sebelum mengirim request, Flutter mengambil Access Token yang tadi disimpannya.
- Flutter mengirimkan request tersebut, tetapi kali ini flutter menyisipkan token di dalam HTTP Header Authorization.
- Django menerima request dan  melihat Authorization header. Django memvalidasi token. Jika token valid, Django mengidentifikasi pengguna pemilik token tersebut. Jika token tidak valid, Django langsung menolak request dan mengirimkan respons HTTP 401.
- ketika user sudah terverifikasi, view Django melanjutkan eksekusi, mengambil data yang diminta dari database, dan mengirimkannya kembali sebagai JSON dengan respons HTTP 200.
- Flutter menerima data JSON, mengubahnya menjadi state, dan ListView atau widget lainnya menampilkan data tersebut di layar. Jika Flutter menerima error 401, ia harus otomatis mengarahkan pengguna kembali ke halaman Login.  

**Logout**
- user menekan tombol "Logout".
- Flutter memanggil flutter_secure_storage.deleteAll() untuk menghapus Access Token dan Refresh Token yang tersimpan. Setelah token dihapus, aplikasi tidak lagi memiliki kunci akses.
- Flutter segera mengarahkan pengguna kembali ke halaman LoginPage.
- Untuk keamanan ekstra, Flutter juga bisa mengirim HTTP POST Request ke endpoint logout di Django. Request ini memberi tahu Django untuk memasukkan token tersebut ke blacklist. Ini memastikan token itu tidak bisa digunakan lagi oleh siapa pun, bahkan jika dicuri sebelum kedaluwarsa.

## **7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).**
**Memastikan Deployment Django Berjalan**
Langkah pertama adalah saya yang pertama adalah memvalidasi sisi server dengan memastikan proyek Django yang sudah saya deploy dapat diakses publik sebelum menghubungkannya dengan flutter. Setelah memastikan data JSON muncul, saya menambahkan konfigurasi CORS di settings.py agar aplikasi mobile diizinkan mengambil data. Kemudian saya membuat mengimplementasikan fitur register dengan membuat applikasi baru pada Django lalu menghubungkannya dengan aplikasi flutter. Untuk mengubungkan keduanya saya meng-installcpackage pbp_django_auth dan provider di terminal Flutter. Setelah itu, saya memodifikasi main.dart dengan membungkus widget utama menggunakan Provider dan  menginisialisasi CookieRequest yang berfungsi untuk menyimpan sesi login dan membagikannya ke seluruh widget di aplikasi. Setelah itu, saya membuat file baru login.dart sebagai halaman login untuk tampilan utama setiap kali aplikasi dijalankan. Di halaman login tersebut, saya menambahkan opsi register bagi user yang belum memiliki akun. Register ini juga saya buatkan file sendiri register.dart untuk penampilan halamannya. Kedua fitur tersebut saya integrasikan dengan sistem autentikasi Django. Kemudian, Saya membuat model kostum untuk data JSON yang ada di Django menjadi objek dart. Saya meng-copy data JSON dari Django lalu paste data tersebut di web Quicktype untuk dibuatkan model secara otomatis. Setelah mendapatkan data JSON dalam dart, saya membuat file baru yaitu product_entry.dart yang berisi data tersebut. Setelah itu saya membuatkan halaman baru untuk menampilkan semua product yang dan halaman baru untuk menampilkan detail dari suatu produk. Kemudian saya menambahkan fitur untuk mem-filter tampilan list product sehingga user dapat melihat hanya product miliknya.

5. Daftar Item & Filter User (List Page)
Tugas ini menggabungkan pengambilan data (fetch) dan penyaringan data (filter).

Filter di Backend (Penting): Untuk checklist "menampilkan item yang terasosiasi dengan pengguna yang login", logika utamanya ada di Django. Pada view JSON Anda, ubah query database dari Item.objects.all() menjadi Item.objects.filter(user=request.user). Ini memastikan JSON yang dikirim ke Flutter hanya berisi barang milik user tersebut.

# lucky_kicks

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
