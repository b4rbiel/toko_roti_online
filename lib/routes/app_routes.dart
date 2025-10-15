import 'package:flutter/material.dart';
// Admin
import 'package:toko_roti_online/views/admin/admin_dashboard_page.dart';
import 'package:toko_roti_online/views/admin/admin_profile_page.dart';
import 'package:toko_roti_online/views/admin/manage_couriers_page.dart';
import 'package:toko_roti_online/views/admin/manage_orders_page.dart';
import 'package:toko_roti_online/views/admin/manage_products_page.dart';
// Courier
import 'package:toko_roti_online/views/courier/courier_dashboard_page.dart';
import 'package:toko_roti_online/views/courier/courier_profile_page.dart';
import 'package:toko_roti_online/views/courier/courier_tracking_page.dart';
import 'package:toko_roti_online/views/courier/delivery_list_page.dart';
import 'package:toko_roti_online/views/courier/delivery_detail_page.dart';
// Customer
import '../views/customer/splash_screen.dart';
import '../views/customer/login_page.dart';
import '../views/customer/register_page.dart';
import '../views/customer/product_list_page.dart';
import '../views/customer/product_detail_page.dart';
import '../views/customer/cart_page.dart';
import '../views/customer/checkout_page.dart';
import '../views/customer/order_status_page.dart';

class AppRoutes {
  // === ROUTE CUSTOMER ===
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const products = '/products';
  static const productDetail = '/product-detail';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const orderStatus = '/order-status';

  // === ROUTE ADMIN ===
  static const adminDashboard = '/admin/dashboard';
  static const adminProducts = '/admin/products';
  static const adminOrders = '/admin/orders';
  static const adminCouriers = '/admin/couriers';
  static const adminProfile = '/admin/profile';

  // === ROUTE COURIER ===
  static const courierDashboard = '/courier/dashboard';
  static const courierDeliveryList = '/courier/delivery-list';
  static const courierProfile = '/courier/profile';
  static const courierDeliveryDetail = '/courier/delivery-detail';
  static const courierTracking = '/courier/tracking';

  static Map<String, WidgetBuilder> routes = {
    // CUSTOMER
    splash: (_) => const SplashScreen(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    products: (_) => const ProductListPage(),
    productDetail: (_) => const ProductDetailPage(),
    cart: (_) => const CartPage(),
    checkout: (_) => const CheckoutPage(),
    orderStatus: (_) => const OrderStatusPage(),

    // ADMIN
    adminDashboard: (_) => const AdminDashboardPage(),
    adminProducts: (_) => const ManageProductsPage(),
    adminOrders: (_) => const ManageOrdersPage(),
    adminCouriers: (_) => const ManageCouriersPage(),
    adminProfile: (_) => const AdminProfilePage(),

    // COURIER
    courierDashboard: (_) => const CourierDashboardPage(),
    courierDeliveryList: (_) => const DeliveryListPage(),
    courierProfile: (_) => const CourierProfilePage(),
    courierDeliveryDetail: (_) => const CourierDeliveryDetailPage(),
    courierTracking: (_) => const CourierTrackingPage(),
  };
}
