import 'package:flutter/material.dart';
import 'package:toko_roti_online/routes/app_routes.dart';

class CourierDashboardPage extends StatelessWidget {
  const CourierDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7), // warna cream lembut
      appBar: AppBar(
        title: const Text("Dashboard Kurir"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selamat datang, Kurir",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Silakan pilih menu untuk melanjutkan tugas Anda hari ini.",
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // Card Menu Utama
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    icon: Icons.local_shipping_outlined,
                    color: Colors.orangeAccent,
                    title: "Daftar Pengiriman",
                    subtitle: "Lihat semua pesanan yang harus dikirim",
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.courierDeliveryList,
                      );
                    },
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.person_outline,
                    color: Colors.teal,
                    title: "Profil Kurir",
                    subtitle: "Lihat dan ubah informasi akun Anda",
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.courierProfile);
                    },
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.map_outlined,
                    color: Colors.lightBlueAccent,
                    title: "Lacak Lokasi",
                    subtitle: "Pantau rute pengiriman Anda",
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.courierTracking);
                    },
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.logout,
                    color: Colors.redAccent,
                    title: "Keluar",
                    subtitle: "Kembali ke halaman login",
                    onTap: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat card menu kurir
  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              radius: 28,
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
