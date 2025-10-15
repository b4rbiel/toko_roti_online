import 'package:flutter/material.dart';

class CourierDeliveryDetailPage extends StatelessWidget {
  const CourierDeliveryDetailPage({super.key});

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "Dikirim":
        return Colors.blue;
      case "Selesai":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final delivery =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),
      appBar: AppBar(
        title: Text("Detail Pengiriman #${delivery['orderId']}"),
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                // Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Status:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                        fontSize: 16,
                      ),
                    ),
                    Chip(
                      label: Text(
                        delivery["status"],
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: getStatusColor(delivery["status"]),
                    ),
                  ],
                ),
                const Divider(height: 20, color: Colors.orangeAccent),

                ListTile(
                  leading: const Icon(Icons.person, color: Colors.orangeAccent),
                  title: const Text("Nama Pelanggan"),
                  subtitle: Text(delivery["customer"]),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.location_on,
                    color: Colors.orangeAccent,
                  ),
                  title: const Text("Alamat Pengiriman"),
                  subtitle: Text(delivery["address"]),
                ),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.orangeAccent),
                  title: const Text("Nomor Telepon"),
                  subtitle: Text(delivery["phone"]),
                ),
                ListTile(
                  leading: const Icon(Icons.note, color: Colors.orangeAccent),
                  title: const Text("Catatan"),
                  subtitle: Text(delivery["notes"]),
                ),

                const SizedBox(height: 10),
                const Text(
                  "Barang yang dikirim:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 6),

                ...delivery["items"].map<Widget>((item) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.shopping_bag,
                        color: Colors.orangeAccent,
                      ),
                      title: Text(item["name"]),
                      trailing: Text("x${item["qty"]}"),
                    ),
                  );
                }).toList(),

                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Pesanan ditandai selesai"),
                            ),
                          );
                        },
                        icon: const Icon(Icons.check),
                        label: const Text("Tandai Selesai"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("Kembali"),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.orangeAccent),
                          foregroundColor: Colors.orangeAccent,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
