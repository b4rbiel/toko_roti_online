import 'package:flutter/material.dart';
import 'package:toko_roti_online/routes/app_routes.dart';

void main() {
  runApp(const TokoRotiApp());
}

class TokoRotiApp extends StatelessWidget {
  const TokoRotiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Roti Online',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown),
      initialRoute: AppRoutes.login, //  mulai dari halaman login
      routes: AppRoutes.routes,
    );
  }
}
