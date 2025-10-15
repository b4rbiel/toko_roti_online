import 'package:flutter/material.dart';

class ManageCouriersPage extends StatefulWidget {
  const ManageCouriersPage({super.key});

  @override
  State<ManageCouriersPage> createState() => _ManageCouriersPageState();
}

class _ManageCouriersPageState extends State<ManageCouriersPage> {
  final List<Map<String, dynamic>> _couriers = [
    {
      'name': 'Budi Santoso',
      'status': 'Aktif',
      'phone': '0812-3456-7890',
      'image': 'assets/images/kurir_pria.jpg',
    },
    {
      'name': 'Rani Wijaya',
      'status': 'Nonaktif',
      'phone': '0813-9876-5432',
      'image': 'assets/images/kurir_wanita.jpeg',
    },
  ];

  void _showAddCourierDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    String selectedStatus = 'Aktif';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Tambah Kurir",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Kurir'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Nomor Telepon'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                items: const [
                  DropdownMenuItem(value: 'Aktif', child: Text('Aktif')),
                  DropdownMenuItem(value: 'Nonaktif', child: Text('Nonaktif')),
                ],
                onChanged: (value) => selectedStatus = value!,
                decoration: const InputDecoration(labelText: 'Status'),
              ),
            ],
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
                if (nameController.text.isEmpty ||
                    phoneController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Nama dan Nomor wajib diisi")),
                  );
                  return;
                }

                setState(() {
                  _couriers.add({
                    'name': nameController.text,
                    'status': selectedStatus,
                    'phone': phoneController.text,
                    'image': 'assets/images/courier_male.png',
                  });
                });

                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  void _deleteCourier(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Hapus Kurir"),
            content: Text(
              "Apakah Anda yakin ingin menghapus ${_couriers[index]['name']}?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Batal"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _couriers.removeAt(index);
                  });
                  Navigator.pop(context);
                },
                child: const Text("Hapus"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),
      appBar: AppBar(
        title: const Text('Kelola Kurir'),
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orangeAccent,
        icon: const Icon(Icons.add, color: Colors.white), 
        label: const Text("Tambah Kurir", 
        style: TextStyle(color: Colors.white),
        ),
        onPressed: _showAddCourierDialog,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            _couriers.isEmpty
                ? const Center(
                  child: Text(
                    "Belum ada kurir terdaftar",
                    style: TextStyle(color: Colors.orangeAccent, fontSize: 16),
                  ),
                )
                : ListView.builder(
                  itemCount: _couriers.length,
                  itemBuilder: (context, index) {
                    final courier = _couriers[index];
                    final statusColor =
                        courier['status'] == 'Aktif'
                            ? Colors.green
                            : Colors.grey;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.orangeAccent.withOpacity(0.1),
                          backgroundImage: AssetImage(courier['image']),
                        ),
                        title: Text(
                          courier['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Telepon: ${courier['phone']}"),
                              const SizedBox(height: 4),
                              Chip(
                                label: Text(
                                  courier['status'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: statusColor,
                                visualDensity: VisualDensity.compact,
                              ),
                            ],
                          ),
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'hapus') {
                              _deleteCourier(index);
                            } else if (value == 'edit') {
                              _showEditCourierDialog(index);
                            }
                          },
                          itemBuilder:
                              (context) => const [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text("Edit"),
                                ),
                                PopupMenuItem(
                                  value: 'hapus',
                                  child: Text("Hapus"),
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

  void _showEditCourierDialog(int index) {
    final courier = _couriers[index];
    final nameController = TextEditingController(text: courier['name']);
    final phoneController = TextEditingController(text: courier['phone']);
    String selectedStatus = courier['status'];

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text(
              "Edit Kurir",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama Kurir'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Nomor Telepon'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedStatus,
                  items: const [
                    DropdownMenuItem(value: 'Aktif', child: Text('Aktif')),
                    DropdownMenuItem(
                      value: 'Nonaktif',
                      child: Text('Nonaktif'),
                    ),
                  ],
                  onChanged: (value) => selectedStatus = value!,
                  decoration: const InputDecoration(labelText: 'Status'),
                ),
              ],
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
                    _couriers[index] = {
                      'name': nameController.text,
                      'phone': phoneController.text,
                      'status': selectedStatus,
                      'image': courier['image'],
                    };
                  });
                  Navigator.pop(context);
                },
                child: const Text("Simpan"),
              ),
            ],
          ),
    );
  }
}
