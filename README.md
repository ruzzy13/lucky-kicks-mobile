Zhafira Uzma || 2406495451 || PBP C  

# **Tugas Individu 7**
## **1.  Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?**  
Perbedaan antara Navigator.push() dan Navigator.pushReplacement() terletak pada cara mereka mengelola page stack. Navigator.push() menambahkan page baru di atas stack. Page asal masih ada di bawahnya. Karena page asal masih ada di bawah page baru, user bisa kembali. Flutter secara otomatis menambahkan tombol "Back" di AppBar page baru. Navigator.pushReplacement() membuang current page dan menggantinya dengan page baru. Page yang diganti akan dihancurkan dan tidak ada lagi di stack. User tidak bisa kembali ke halaman tersebut. Tombol "Back" tidak akan muncul. Untuk Navigator.push(), saya menggunakannya pada product_card.dart (button create product) dan left_drawer.dart (button add product) dalam proyek lucky kicks. Ini akan memudahkan user ketika ingin membuat produk baru. Setelah mereka selesai membuat atau batal membuat produk baru, user dapat kembali ke home page. Untuk Navigator.pushReplacement(), saya menggunakannya pada left_drawer.dart (button Home Page).

## **2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer unntuk membangun struktur halaman yang konsisten di seluruh aplikasi?**  
a. **Scaffold** : Saya menggunakan Scaffold kerangka dasar untuk satu layar penuh. Scaffold ini menyediakan slot untuk komponen-komponen umum seperti appBar, Drawer, dan Body. Penggunaan Scafold ini membuat seluruh page pada proyek saya seperti menu.dart dan productlist_form.dart akan mengikuti aturan struktur tata letak yang sama.  
b. **Appbar** : Saya menggunakan AppBar sebagai tampilan konteks di bagian atas setiap halaman. Appbar ini secara otomatis mengambil warna dari ThemeData yang ada di main.dart, inilah sebabnya AppBar di HomePage dan ProductFormPage memiliki brand color yang sama. Kemudian, secara fungsional, Scaffold mengelola AppBar, dengan otomatis menambahkan ikon "menu" jika drawer ada, atau ikon "panah kembali" jika halaman itu dibuka melalui Navigator.push(), sehingga tidak perlu memprogram logika tersebut secara manual.  
c. **Drawer** : Saya menggunakan drawer sebagai pusat navigasi global proyek saya dan menjadi kunci utama konsistensi. Dengan membuat Drawer sebagai widget terpisah (left_drawer.dart) dan kemudian memanggilnya kembali (const LeftDrawer()) di setiap Scaffold (seperti di menu.dart dan productlist_form.dart), Hal ini menciptakan Single Source of Truth. Hal ini membuat proyek menjadi sangat efisien. Bagi user, Drawer menciptakan pengalaman (UX) yang dapat diprediksi, karena mereka tahu menu navigasi akan selalu identik, di mana pun mereka berada.  

## **3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.**  
a. **Padding** : Padding adalah widget estetika yang paling fundamental, bertugas memberikan space di sekitar elemen lain. Hal ini membuat tampilan page menjadi rapih. Tanpa adanya padding, TextFormField akan menempel rapat satu sama lain dan ke tepi layar, menciptakan antarmuka yang sempit dan sulit dibaca. Penggunaan Padding di sekeliling setiap input di productlist_form.dart secara efektif memisahkan field-field secara visual, mengelompokkan label dengan inputnya, dan secara tidak langsung menyediakan area sentuh yang lebih baik bagi pengguna.  
b. **SingleChildScrollView** : SingleChildScrollView adalah widget yang bersifat krusial, dirancang untuk menangani konten yang melebihi tinggi layar. Alasan utamanya adalah untuk mengatasi keyboard yang muncul. Tanpanya, input di bagian bawah seperti input "URL Thumbnail" dan tombol "Save" akan tertutup oleh keyboard dan tidak dapat diakses. Selain itu, SingleChildScrollView mencegah error pixel overflow yang muncul jika formulir Anda terlalu panjang untuk layar HP yang lebih kecil. Penggunaan SingleChildScrollView sangat cocok digunakan pada productlist_form.dart yang membuat tampilannya bisa di scroll untuk bisa mengisi filed input di bawah yang kemungkinan tertutup keyboard.  
c. **ListView** : ListView bertujuan unutk menggabungkan fungsionalitas Column dan SingleChildScrollView menjadi satu widget. Keuntungan utamanya adalah efisiensi memori, terutama saat menggunakan ListView.builder. Berbeda dengan Column, ListView.builder menerapkan lazy loading, yang berarti ia hanya merender item yang terlihat di layar.  

## **4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?**  
Untuk menyesuaikan warna tema agar konsisten, saya menerapkan single source of truth di file main.dart. Ini menjadi titik kontrol utama karena di sinilah letak MaterialApp. Di dalamnya, saya akan menggunakan properti theme untuk menyediakan ThemeData sebagai aturan dasar untuk semua tampilan visual. Secara spesifik, saya memanfaatkan colorScheme untuk mendefinisikan palet utama. Saya menggunakan ColorScheme.fromSwatch(primarySwatch: Colors.blue), yang menghasilkan seluruh skema warna hanya dari satu warna. Jika saya perlu penyesuaian, saya akan menambahkan .copyWith(secondary: Colors.blueAccent[400]) untuk override warna tertentu, seperti warna aksen. Setelah mengatur warna di level tertinggi ini, widget di halaman lain, seperti AppBar, ElevatedButton, dan Switch, akan secara otomatis mengambil warna yang benar dari tema ini. Jika brand ingin berganti warna (misalnya menjadi hijau), saya hanya perlu mengubah satu baris primarySwatch di main.dart untuk memperbarui seluruh aplikasi.  


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
