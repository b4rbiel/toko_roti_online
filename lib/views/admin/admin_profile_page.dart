import 'package:flutter/material.dart';
import 'package:toko_roti_online/routes/app_routes.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Admin'),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Foto Profil
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/foto_admin.jpeg'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Admin Butter Future',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'butterfuture@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Info Detail
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.store, color: Colors.orangeAccent),
                title: const Text('Nama Toko'),
                subtitle: const Text('ButterFuture'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.phone, color: Colors.orangeAccent),
                title: const Text('Nomor Telepon'),
                subtitle: const Text('+62 812-9355-8500'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.menu_open,
                  color: Colors.orangeAccent,
                ),
                title: const Text('Jam Operasional'),
                subtitle: const Text('08.00 s.d. 17.00'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.location_on,
                  color: Colors.orangeAccent,
                ),
                title: const Text('Alamat'),
                subtitle: const Text(
                  'Jl. Raya Pemda, Kaum Pandak, Kel.Karadenan, Kec. Cibinong, Kab.Bogor, Jawa Barat',
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Tombol Edit & Logout
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Navigasi ke halaman edit profil
              },
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text(
                "Edit Profil",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.orangeAccent,
                side: const BorderSide(color: Colors.orangeAccent),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Aksi logout
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
