import 'package:flutter/material.dart';
import 'package:toko_roti_online/routes/app_routes.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // contoh data pesanan
    final List<Map<String, dynamic>> items = [
      {"name": "Roti Coklat", "price": 12000, "qty": 2},
      {"name": "Roti Keju", "price": 15000, "qty": 1},
    ];

    final totalHarga = items.fold(
      0,
      (sum, item) => sum + (item['price'] as int) * (item['qty'] as int),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7), // warna cream lembut
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian ringkasan pesanan
            const Text(
              "Ringkasan Pesanan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children:
                      items
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['name'].toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Rp ${(item['price'] as int) * (item['qty'] as int)}",
                                    style: const TextStyle(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Bagian alamat GPS
            const Text(
              "Alamat Pengiriman (otomatis GPS)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orangeAccent.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.orangeAccent),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Lokasi: -6.200, 106.816\nJl. Contoh No.12, Jakarta",
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.my_location, color: Colors.green),
                    onPressed: () {
                      // nanti bisa ditambahkan logika get GPS
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Total harga
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Pembayaran",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.orangeAccent,
                  ),
                ),
                Text(
                  "Rp $totalHarga",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Tombol kirim pesanan
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.orderStatus);
              },
              icon: const Icon(Icons.send, color: Colors.white),
              label: const Text(
                "Kirim Pesanan",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
            ),

            const SizedBox(height: 20),

            // Tombol logout
            Center(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orangeAccent,
                  side: const BorderSide(
                    color: Colors.orangeAccent,
                    width: 1.2,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout", style: TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
