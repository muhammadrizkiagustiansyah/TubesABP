import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../services/route_service.dart';


class CourierRouteScreen extends StatefulWidget {
  const CourierRouteScreen({super.key});

  @override
  _CourierRouteScreenState createState() => _CourierRouteScreenState();
}

class _CourierRouteScreenState extends State<CourierRouteScreen> {
  late final RouteService _routeService;
  LatLng _currentPosition = LatLng(-6.2088, 106.8456); // Default: Jakarta
  final LatLng _customerLocation = LatLng(-7.8797, 109.2479); // Contoh: Yogyakarta
  List<LatLng> _routePoints = [];
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _routeService = RouteService(); // Inisialisasi RouteService
    _getCurrentLocation();
  }

  // Fungsi untuk mendapatkan lokasi saat ini
  Future<void> _getCurrentLocation() async {
    try {
      // Cek permission lokasi
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Layanan GPS tidak aktif');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Izin lokasi ditolak');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Izin lokasi ditolak permanen');
      }

      // Dapatkan posisi terkini
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _mapController.move(_currentPosition, 14.0);
      });

      // Dapatkan rute setelah mendapatkan lokasi
      await _getRoute();
    } catch (e) {
      print('Error mendapatkan lokasi: $e');
      // Tambahkan snackbar atau alert untuk menampilkan error ke user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mendapatkan lokasi: ${e.toString()}')),
      );
    }
  }

  // Fungsi untuk mendapatkan rute dari RouteService
  Future<void> _getRoute() async {
    try {
      final route = await _routeService.getRoute(
        _currentPosition, 
        _customerLocation,
      );

      setState(() {
        _routePoints = route;
      });
    } catch (e) {
      print('Error mendapatkan rute: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mendapatkan rute: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigasi Kurir'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _getCurrentLocation,
            tooltip: 'Perbarui Lokasi',
          ),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _currentPosition,
          initialZoom: 14.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              // Marker lokasi kurir (Anda)
              Marker(
                point: _currentPosition,
                width: 40,
                height: 40,
                child: Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
              ),
              // Marker lokasi customer
              Marker(
                point: _customerLocation,
                width: 40,
                height: 40,
                child: Icon(Icons.location_pin, color: Colors.red, size: 40),
              ),
            ],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: _routePoints,
                strokeWidth: 4.0,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        tooltip: 'Lokasi Saya',
        child: Icon(Icons.gps_fixed),
      ),
    );
  }
}