import 'package:flutter/material.dart';
import 'package:toko_roti_online/routes/app_routes.dart';

class CourierProfilePage extends StatelessWidget {
  const CourierProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7), // warna cream lembut
      appBar: AppBar(
        title: const Text('Profil Kurir'),
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Bagian foto profil
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orangeAccent.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/kurirdata.jpg'),
                backgroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            // Nama Kurir
            const Text(
              'Carl Stephan',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 5),
            const Text('Kurir Aktif', style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 25),

            // Kartu informasi
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  children: const [
                    ProfileInfoRow(
                      icon: Icons.phone,
                      label: "Nomor Telepon",
                      value: "0812-9243-1442",
                    ),
                    Divider(),
                    ProfileInfoRow(
                      icon: Icons.badge,
                      label: "ID Kurir",
                      value: "KUR-2025-001",
                    ),
                    Divider(),
                    ProfileInfoRow(
                      icon: Icons.local_shipping,
                      label: "Total Pengiriman",
                      value: "152 Pesanan",
                    ),
                    Divider(),
                    ProfileInfoRow(
                      icon: Icons.star,
                      label: "Rating",
                      value: "4.7 / 5",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Tombol Logout
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.orangeAccent,
                side: const BorderSide(color: Colors.orangeAccent),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.courierDashboard,
                );
              },
              icon: const Icon(Icons.arrow_back_ios_new),
              label: const Text(
                "Kembali ke Dashboard",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget kecil untuk baris informasi profil
class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.orangeAccent),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.black87, fontSize: 15),
        ),
      ],
    );
  }
}
