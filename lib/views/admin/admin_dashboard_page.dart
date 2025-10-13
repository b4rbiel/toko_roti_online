import 'package:flutter/material.dart';
import 'package:toko_roti_online/routes/app_routes.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Admin')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _menuCard(context, 'Kelola Produk', Icons.bakery_dining, () {
              Navigator.pushNamed(context, AppRoutes.adminProducts);
            }),
            _menuCard(context, 'Kelola Pesanan', Icons.receipt_long, () {
              Navigator.pushNamed(context, AppRoutes.adminOrders);
            }),
            _menuCard(context, 'Kelola Kurir', Icons.delivery_dining, () {
              Navigator.pushNamed(context, AppRoutes.adminCouriers);
            }),
            _menuCard(context, 'Profil Admin', Icons.person, () {
              Navigator.pushNamed(context, AppRoutes.adminProfile);
            }),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Colors.brown),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

