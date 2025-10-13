import 'package:flutter/material.dart';

class ManageProductsPage extends StatefulWidget {
  const ManageProductsPage({super.key});

  @override
  State<ManageProductsPage> createState() => _ManageProductsPageState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Roti Tawar',
      'price': 10000,
      'image': 'assets/images/roti_tawar.png',
    },
    {
      'name': 'Roti Coklat',
      'price': 12000,
      'image': 'assets/images/roti_coklat.png',
    },
    {
      'name': 'Roti Keju',
      'price': 15000,
      'image': 'assets/images/roti_keju.png',
    },
    {
      'name': 'Roti Kopi',
      'price': 16000,
      'image': 'assets/images/roti_kopi.jpg',
    },
    {
      'name': 'Roti Pandan',
      'price': 16000,
      'image': 'assets/images/roti_pandan.jpg',
    },
    {
      'name': 'Air Mineral',
      'price': 2000,
      'image': 'assets/images/air_mineral.jpg',
    },
    {
      'name': 'Roti Susu',
      'price': 15500,
      'image': 'assets/images/roti_susu.png',
    },
    {'name': 'Kopi', 'price': 5000, 'image': 'assets/images/kopi.jpg'},
    {
      'name': 'Teh Manis',
      'price': 5000,
      'image': 'assets/images/teh_manis.jpg',
    },
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  void _showAddProductDialog() {
    _nameController.clear();
    _priceController.clear();
    _imageController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Tambah Produk',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Harga Produk'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _imageController,
                decoration: const InputDecoration(
                  labelText: 'Path Gambar (opsional)',
                  hintText: 'contoh: assets/images/roti_baru.png',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (_nameController.text.isEmpty ||
                    _priceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Nama dan harga wajib diisi")),
                  );
                  return;
                }

                setState(() {
                  _products.add({
                    'name': _nameController.text,
                    'price': int.tryParse(_priceController.text) ?? 0,
                    'image':
                        _imageController.text.isNotEmpty
                            ? _imageController.text
                            : 'assets/images/roti_tawar.png',
                  });
                });

                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Hapus Produk"),
            content: Text(
              "Apakah Anda yakin ingin menghapus ${_products[index]['name']}?",
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
                    _products.removeAt(index);
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
        title: const Text('Kelola Produk'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.brown,
        icon: const Icon(Icons.add),
        label: const Text("Tambah Produk"),
        onPressed: _showAddProductDialog,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            _products.isEmpty
                ? const Center(
                  child: Text(
                    "Belum ada produk",
                    style: TextStyle(color: Colors.brown, fontSize: 16),
                  ),
                )
                : ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final item = _products[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            (item['image'] as String?) ??
                                'assets/images/roti_tawar.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          item['name'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.brown,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "Rp ${item['price']}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          tooltip: "Hapus Produk",
                          onPressed: () => _deleteProduct(index),
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
