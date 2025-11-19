import 'package:flutter/material.dart';
import 'package:lucky_kicks/screens/productlist_form.dart';
import 'package:lucky_kicks/screens/product_entry_list.dart'; // Import halaman list baru
import 'package:lucky_kicks/screens/login.dart'; // Import halaman login
import 'package:pbp_django_auth/pbp_django_auth.dart'; // Import untuk auth
import 'package:provider/provider.dart'; // Import untuk Provider

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan request dari Provider untuk logout
    final request = context.watch<CookieRequest>();
    
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async { // Jadikan async untuk logout
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("you have clicked ${item.name} button!"),
              ),
            );

          if (item.name == "Create Product") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductFormPage(),
              ),
            );
          } else if (item.name == "All Products") {
            // Navigasi ke halaman list produk baru
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductEntryListPage(),
              ),
            );
          } else if (item.name == "Logout") {
            // Logika logout dari template
            // TODO: Ganti URL dengan URL aplikasi Anda!
            // Gunakan http://10.0.2.2/ untuk emulator Android
            // Gunakan http://localhost:8000/ jika di browser
            
            final response = await request.logout(
              "http://127.0.0.1:8000/authentication/logout/");
              String message = response["message"];
              if (context.mounted) {
                if (response['status']) {
                  String uname = response["username"];
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message See you again, $uname."),
                  ));
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );
                }
              }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}