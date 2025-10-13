import 'package:flutter/material.dart';
import 'package:toko_roti_online/routes/app_routes.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        "name": "Roti Tawar",
        "price": 10000,
        "image": "assets/images/roti_tawar.png",
        "description":
            "Roti tawar lembut dan segar, cocok untuk sarapan pagi dengan selai.",
        "expired": "12/12/2025",
      },
      {
        "name": "Roti Coklat",
        "price": 12000,
        "image": "assets/images/roti_coklat.png",
        "description":
            "Roti isi coklat manis dengan aroma lezat yang menggoda selera.",
        "expired": "08/12/2025",
      },
      {
        "name": "Roti Keju",
        "price": 15000,
        "image": "assets/images/roti_keju.png",
        "description":
            "Roti lembut dengan lelehan keju yang gurih, cocok untuk semua usia.",
        "expired": "15/12/2025",
      },
      {
        "name": "Roti Susu",
        "price": 15500,
        "image": "assets/images/roti_susu.png",
        "description":
            "Roti empuk dengan rasa susu yang manis dan lembut di mulut.",
        "expired": "10/12/2025",
      },
      {
        "name": "Roti Pandan",
        "price": 16000,
        "image": "assets/images/roti_pandan.jpg",
        "description":
            "Roti pandan lembut dengan aroma harum khas daun pandan asli.",
        "expired": "20/12/2025",
      },
      {
        "name": "Roti Kopi",
        "price": 16000,
        "image": "assets/images/roti_kopi.jpg",
        "description":
            "Roti dengan aroma kopi kuat, cocok untuk teman minum teh sore hari.",
        "expired": "18/12/2025",
      },
      {
        "name": "Air Mineral",
        "price": 2000,
        "image": "assets/images/air_mineral.jpg",
        "description": "Air yang sehat untuk diminum untuk melepas dahaga.",
        "expired": "30/12/2025",
      },
      {
        "name": "Teh Manis",
        "price": 5000,
        "image": "assets/images/teh_manis.jpg",
        "description":
            "teh yang diminum untuk menemani waktu luang saat bersantai.",
        "expired": "25/12/2025",
      },
      {
        "name": "Kopi",
        "price": 5000,
        "image": "assets/images/kopi.jpg",
        "description":
            "kopi yang diminum untuk menemani waktu luang dan meningkatkan produktivitas.",
        "expired": "28/12/2025",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),
      appBar: AppBar(
        title: const Text("Daftar Roti"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // tampil dua kolom
            childAspectRatio: 0.9, // ini pengatur tinggi card
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.productDetail,
                  arguments: product,
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                shadowColor: Colors.brown.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Gambar produk
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      child: Image.asset(
                        product['image'] ?? 'assets/images/roti_tawar.png',
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Nama produk
                    Text(
                      product['name'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.brown,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // Harga produk
                    Text(
                      "Rp ${product['price']}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),

                    // Expired info
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "Exp: ${product['expired']}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Tombol Lihat Detail
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 6,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.productDetail,
                            arguments: product,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size(double.infinity, 40),
                        ),
                        child: const Text(
                          "Lihat Detail",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
