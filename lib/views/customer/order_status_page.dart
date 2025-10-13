import 'package:flutter/material.dart';

class OrderStatusPage extends StatelessWidget {
  const OrderStatusPage({super.key});

  // Tambahkan fungsi untuk menentukan warna berdasarkan status
  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.amber.shade600;
      case "Dikirim":
        return Colors.brown.shade400;
      case "Selesai":
        return Colors.green.shade600;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = [
      {"id": 1, "status": "Pending", "date": "12 Okt 2025", "total": 48000},
      {"id": 2, "status": "Dikirim", "date": "10 Okt 2025", "total": 32000},
      {"id": 3, "status": "Selesai", "date": "5 Okt 2025", "total": 55000},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),
      appBar: AppBar(
        title: const Text("Status Pesanan"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 3,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          final String status = (order['status'] as String?) ?? 'Pending';
          final Color statusColor = getStatusColor(status);

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon status
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    order["status"] == "Pending"
                        ? Icons.timer_outlined
                        : order["status"] == "Dikirim"
                        ? Icons.local_shipping_outlined
                        : Icons.check_circle_outline,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                // Info pesanan
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pesanan #${order["id"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Status: ${order["status"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Tanggal: ${order["date"]}",
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        "Total: Rp ${order["total"]}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Tombol detail
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.brown),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Detail Pesanan #${order["id"]} (${order["status"]})",
                        ),
                        backgroundColor: Colors.brown,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
