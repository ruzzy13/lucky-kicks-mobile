import 'package:flutter/material.dart';
import 'package:lucky_kicks/models/product_entry.dart'; 
import 'package:lucky_kicks/widgets/left_drawer.dart';
import 'package:lucky_kicks/screens/product_detail.dart';
import 'package:lucky_kicks/widgets/product_entry_card.dart'; 
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<ProduchEntry>> fetchProducts(CookieRequest request) async {
    // TODO: Ganti URL dengan URL aplikasi Anda!
    // Gunakan http://10.0.2.2/ untuk emulator Android
    // Gunakan http://localhost:8000/ jika di browser
    
    final response = await request.get('http://127.0.0.1:8000/json/');
    
    // Decode response ke format json
    var data = response;
    List<ProduchEntry> listProducts = [];
    for (var d in data) {
      if (d != null) {
        listProducts.add(ProduchEntry.fromJson(d));
      }
    }
    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Column(
                children: [
                  Text(
                    'There are no products yet.',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => ProductEntryCard(
                  product: snapshot.data![index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}