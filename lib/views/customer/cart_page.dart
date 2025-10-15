import 'package:flutter/material.dart';
import 'package:toko_roti_online/routes/app_routes.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cartItems = [
      {
        "name": "Roti Coklat",
        "price": 12000,
        "qty": 2,
        "image": "assets/images/roti_coklat.jpg",
      },
      {
        "name": "Roti Keju",
        "price": 15000,
        "qty": 1,
        "image": "assets/images/roti_keju.png",
      },
    ];

    // hitung total harga
    final double totalHarga = cartItems.fold(0, (sum, item) {
      return sum + (item['price'] as int) * (item['qty'] as int);
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7), // warna cream lembut
      appBar: AppBar(
        title: const Text("Keranjang"),
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 3,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        item['image'] as String? ??
                            'assets/images/roti_tawar.png', // aman tanpa error
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      item['name'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    subtitle: Text(
                      "Rp ${item['price']} x ${item['qty']} pcs",
                      style: const TextStyle(color: Colors.black87),
                    ),
                    trailing: Text(
                      "Rp ${(item['price'] as int) * (item['qty'] as int)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bagian total dan tombol checkout
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.orangeAccent.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Pembayaran:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    Text(
                      "Rp ${totalHarga.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.checkout);
                  },
                  icon: const Icon(Icons.payment, color: Colors.white),
                  label: const Text(
                    "Lanjut ke Checkout",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
