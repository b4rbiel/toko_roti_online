import 'package:flutter/material.dart';
import 'package:toko_roti_online/routes/app_routes.dart';

class DeliveryListPage extends StatelessWidget {
  const DeliveryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final deliveries = [
      {
        'orderId': 'ORD001',
        'address': 'Jl. Merdeka No.10, Jakarta',
        'status': 'Pending',
        'customer': 'Andi Saputra',
        'phone': '+62 812-3456-7890',
        'notes': 'Antar sebelum jam 12 siang',
        'items': [
          {'name': 'Roti Tawar', 'qty': 2},
          {'name': 'Roti Keju', 'qty': 1},
        ],
      },
      {
        'orderId': 'ORD002',
        'address': 'Jl. Sudirman No.22, Bandung',
        'status': 'Dikirim',
        'customer': 'Budi Santoso',
        'phone': '+62 811-9876-5432',
        'notes': 'Pastikan roti tidak penyok ya.',
        'items': [
          {'name': 'Roti Coklat', 'qty': 3},
        ],
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),
      appBar: AppBar(
        title: const Text('Daftar Pengiriman'),
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: deliveries.length,
          itemBuilder: (context, index) {
            final d = deliveries[index];
            Color statusColor;
            switch (d['status']) {
              case 'Pending':
                statusColor = Colors.orange;
                break;
              case 'Dikirim':
                statusColor = Colors.blue;
                break;
              case 'Selesai':
                statusColor = Colors.green;
                break;
              default:
                statusColor = Colors.grey;
            }

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(
                  Icons.local_shipping,
                  color: Colors.orangeAccent,
                ),
                title: Text(
                  "Pesanan ${d['orderId']}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(d['address']?.toString() ?? '-'),
                trailing: Chip(
                  label: Text(
                    d['status']?.toString() ?? '-',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: statusColor,
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.courierDeliveryDetail,
                    arguments: d, // <-- kirim data ke halaman detail
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
