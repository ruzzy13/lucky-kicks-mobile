Zhafira Uzma || 2406495451 || PBP C  

# **Tugas Individu 6**
## **1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.**  
widget tree adalah kerangka dari seluruh user interface dari aplikasi flutter. Widget tree menggambarkan bagaimana widget saling terhubung dan disusun. Ketika aplikasi Flutter berjalan, Flutter membangun UI dari root, branches hingga ke leaf melalui struktur Widget tree. Dalam widget tree, terdapat istilah parent dan child. Parent adalah widget yang membungkus atau menyediakan konteks bagi widget lain sedangkan child adalah widget yang terletak di dalam parent dan biasanya akan mewarisi properti atau perilaku tertentu dari parent-nya. Hubungan antara parent-children ini bekerja melalui 3 aturan utama yaitu parent memberikan batasan/constraints kepada child, child menentukan ukurannya sendiri, dan parent menentukan posisi child.   

## **2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.**  
- MaterialApp: Membungkus seluruh aplikasi, menyediakan fungsionalitas dasar Material Design, seperti navigasi dan tema.  
- Scaffold: Menyediakan struktur visual dasar halaman, seperti AppBar di bagian atas dan body untuk konten utama.  
- AppBar: Bilah di bagian atas layar yang biasanya berisi title.  
- Padding: Memberikan ruang kosong di sekeliling widget anaknya.  
- Column: Menyusun daftar widget anaknya secara vertikal.  
- Row: Menyusun daftar widget anaknya secara horizontal.  
- Center: Menempatkan widget anaknya di tengah-tengah ruang yang tersedia.  
- SizedBox: Membuat sebuah kotak dengan ukuran yang spesifik.  
- GridView : Menampilkan widget anaknya dalam format grid.  
- Card: Membuat sebuah panel/card bergaya Material Design dengan sudut membulat dan elevation.  
- Container: Kotak serbaguna yang bisa diatur styling-nya.  
- Material: Sebuah "kanvas" Material Design. Kamu menggunakannya di ItemCard untuk memberikan warna latar belakang, bentuk melengkung (borderRadius), dan sebagai dasar untuk InkWell.  
- Text: Menampilkan teks di layar.  
- Icon: Menampilkan ikon grafis dari font set Material Icons.  
- InkWell: Membuat widget anaknya menjadi interaktif dan dapat diklik.  
- SnackBar: Pesan sementara yang muncul di bagian bawah layar untuk memberi feedback singkat.  

## **3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.**  
MaterialApp adalah widget inti dalam Flutter yang membungkus seluruh aplikasi untuk menyediakan fungsionalitas dan styling dasar yang diperlukan untuk Material Design. Fungsi utamanya adalah mengatur tema, mengelola navigasi, dan mengatur lokalisasi. MaterialApp hampir selalu ditempatkan di paling atas atau dijadikan sebagai root dari widget tree karena widget-widget Material Design lainnya bergantung padanya. Misalkan, jika menggunakan Scaffold tanpa membungkusnya terlebih dahulu dengan MaterialApp, program akan mendapatkan error. Scaffold tidak akan tahu bagaimana cara menampilkan dirinya dengan benar.

## **4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?**  
Perbedaan utama antara StatelessWidget dan StatefulWidget adalah StatelessWidget tidak bisa berubah setelah dibuat, sedangkan StatefulWidget bisa berubah dan memperbarui tampilannya sendiri selama digunakan. StatelessWidget adalah widget yang immutable, tampilannya ditentukan saat dibuat dan tidak akan pernah berubah, kecuali parent-nya mengirimkan data konfigurasi baru. Widget ini tidak peduli pada apa pun selain konfigurasi awal yang diterimanya. Ia tidak memiliki mekanisme internal untuk rebuild dirinya sendiri. StatefulWidget adalah widget yang mutable. Widget ini memiliki State (data internal) yang bisa berubah kapan saja selama widget itu hidup. Ketika state-nya berubah, widget ini bisa memicu rebuild untuk dirinya sendiri agar tampilannya diperbarui sesuai dengan state yang baru. Perubahan ini dilakukan dengan memanggil metode setState(). Penggunaan StatelessWidget adalah ketika widget hanya perlu menampilkan data yang diterima dari parent-nya dan  tampilan widget tidak akan pernah berubah setelah dibuat. Penggunaan StatefulWidget adalah ketika data di dalam widget itu perlu berubah setelah widget itu tampil di layar dan tampilan widget bergantung pada interaksi pengguna.  

## **5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?**  
BuildContext adalah referensi ke lokasi spesifik sebuah widget di dalam struktur widget tree sebuah aplikasi. Setiap widget yang dibuat di Flutter berada di dalam sebuah struktur widget tree. BuildContext adalah objek yang memberi tahu widget tersebut di mana tepatnya ia berada di dalam tree itu, siapa parent-nya, dan seterusnya. BuildContext adalah penghubung antara widget dengan seluruh bagian aplikasi lainnya. Oleh karena itu, widget sangat penting untuk menentukan widget ancestor dan mengakses "service" terdekat. BuildContex digunakan pada metode build sebagai alat untuk mengakses state atau objek dari widget ancestor. Contohnya seperti mengambil tema dan mengambil ukuran layar.  

## **6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".**  
Hot Reload adalah fitur yang meng-insert file yang baru diubah ke dalam Dart Virtual Machine (VM) yang sedang berjalan. Setelah insert file kode baru, framework Flutter secara otomatis membangun ulang widget tree berdasarkan kode baru yang membuat tampilan UI aplikasi diperbarui dalam waktu yang cepat. Terdapat beberapa hal yang membedakan antara hot reload dan hot restart, di antaranya adalah kecepatan memperbarui tampilan UI (hot reload lebih cepat daripada hot restart) dan state aplikasi akan terjada dengan menggunakan hot reload (hot restart akan me-reset state tersebut). 

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
