import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManageOrdersPage extends StatefulWidget {
  const ManageOrdersPage({super.key});

  @override
  State<ManageOrdersPage> createState() => _ManageOrdersPageState();
}

class _ManageOrdersPageState extends State<ManageOrdersPage> {
  // 🔹 List orders bisa diubah (bukan final)
  List<Map<String, dynamic>> orders = [
    {
      'id': 'ORD001',
      'customer': 'Asih',
      'status': 'Pending',
      'total': 35000,
      'date': DateTime.now().subtract(const Duration(hours: 3)),
    },
    {
      'id': 'ORD002',
      'customer': 'Nopriadi',
      'status': 'Dikirim',
      'total': 50000,
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': 'ORD003',
      'customer': 'Lina',
      'status': 'Selesai',
      'total': 42000,
      'date': DateTime.now().subtract(const Duration(days: 2)),
    },
  ];

  // 🔹 Warna status
  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orangeAccent;
      case 'Dikirim':
        return Colors.blueAccent;
      case 'Selesai':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),
      appBar: AppBar(
        title: const Text('Kelola Pesanan'),
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            orders.isEmpty
                ? const Center(
                  child: Text(
                    "Belum ada pesanan",
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
                : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    final status = order['status'] as String? ?? 'Pending';
                    final statusColor = getStatusColor(status);

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Baris atas: ID & Status
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Pesanan ${order['id']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                                Chip(
                                  label: Text(
                                    status,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: statusColor,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Nama Customer
                            Row(
                              children: [
                                const Icon(
                                  Icons.person_outline,
                                  color: Colors.orangeAccent,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Customer: ${order['customer']}",
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),

                            // Tanggal Pesanan
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.orangeAccent,
                                  size: 16,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  DateFormat(
                                    'dd MMM yyyy, HH:mm',
                                  ).format(order['date']),
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),

                            // Total harga
                            Row(
                              children: [
                                const Icon(
                                  Icons.attach_money_rounded,
                                  color: Colors.green,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Total: Rp ${order['total']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Divider(height: 1),

                            // Tombol aksi
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  icon: const Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.orangeAccent,
                                  ),
                                  label: const Text(
                                    "Detail",
                                    style: TextStyle(
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                  onPressed:
                                      () => _showOrderDetail(context, order),
                                ),
                                const SizedBox(width: 8),
                                TextButton.icon(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  label: const Text(
                                    "Ubah Status",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onPressed:
                                      () => _changeOrderStatus(context, index),
                                ),
                              ],
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

  // Detail Pesanan
  void _showOrderDetail(BuildContext context, Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              "Detail Pesanan ${order['id']}",
              style: const TextStyle(color: Colors.orangeAccent),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Customer: ${order['customer']}"),
                Text("Status: ${order['status']}"),
                Text("Total: Rp ${order['total']}"),
                Text(
                  "Tanggal: ${DateFormat('dd MMM yyyy, HH:mm').format(order['date'])}",
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Tutup"),
              ),
            ],
          ),
    );
  }

  // Ubah Status
  void _changeOrderStatus(BuildContext context, int index) {
    final order = orders[index];
    final statuses = ['Pending', 'Dikirim', 'Selesai'];
    String selected = order['status'] ?? 'Pending';

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(
                  "Ubah Status ${order['id']}",
                  style: const TextStyle(color: Colors.orangeAccent),
                ),
                content: DropdownButton<String>(
                  value: selected,
                  isExpanded: true,
                  items:
                      statuses
                          .map(
                            (s) => DropdownMenuItem(value: s, child: Text(s)),
                          )
                          .toList(),
                  onChanged: (value) => setDialogState(() => selected = value!),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Batal"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        orders[index]['status'] = selected;
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Status pesanan ${order['id']} diubah ke $selected",
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: const Text("Simpan"),
                  ),
                ],
              );
            },
          ),
    );
  }
}
