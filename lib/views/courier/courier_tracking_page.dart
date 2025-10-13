import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class CourierTrackingPage extends StatefulWidget {
  const CourierTrackingPage({super.key});

  @override
  State<CourierTrackingPage> createState() => _CourierTrackingPageState();
}

class _CourierTrackingPageState extends State<CourierTrackingPage> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  LatLng _storeLocation = const LatLng(
    -6.200000,
    106.816666,
  ); // contoh: Jakarta (toko)
  LatLng _customerLocation = const LatLng(
    -6.210123,
    106.820987,
  ); // contoh: alamat pelanggan
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    await _determinePosition();
    await _getRoutePolyline();
  }

  /// Cek izin lokasi & ambil posisi saat ini
  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Layanan lokasi tidak aktif")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    _markers.add(
      Marker(
        markerId: const MarkerId("kurir"),
        position: _currentPosition!,
        infoWindow: const InfoWindow(title: "Posisi Kurir"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId("toko"),
        position: _storeLocation,
        infoWindow: const InfoWindow(title: "Toko Roti"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId("pelanggan"),
        position: _customerLocation,
        infoWindow: const InfoWindow(title: "Alamat Pelanggan"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );
  }

  /// Ambil data rute dari Google Directions API
  Future<void> _getRoutePolyline() async {
    const apiKey = "YOUR_GOOGLE_MAPS_API_KEY"; // 🔑 ganti dengan API key kamu
    final url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${_storeLocation.latitude},${_storeLocation.longitude}&destination=${_customerLocation.latitude},${_customerLocation.longitude}&key=$apiKey";

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data["routes"].isNotEmpty) {
      final points = data["routes"][0]["overview_polyline"]["points"];
      _addPolyline(_decodePolyline(points));
    }
  }

  /// Decode polyline Google Maps ke List<LatLng>
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  void _addPolyline(List<LatLng> polylinePoints) {
    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          points: polylinePoints,
          color: Colors.brown,
          width: 5,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),
      appBar: AppBar(
        title: const Text("Lacak Pengiriman"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body:
          _currentPosition == null
              ? const Center(
                child: CircularProgressIndicator(color: Colors.brown),
              )
              : GoogleMap(
                onMapCreated: (controller) => _mapController = controller,
                initialCameraPosition: CameraPosition(
                  target: _storeLocation,
                  zoom: 13,
                ),
                markers: _markers,
                polylines: _polylines,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(_currentPosition!, 15),
          );
        },
        backgroundColor: Colors.brown,
        icon: const Icon(Icons.my_location),
        label: const Text("Posisi Saya"),
      ),
    );
  }
}
