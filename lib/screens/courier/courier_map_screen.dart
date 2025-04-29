import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';  // Untuk menangani koordinat
import 'package:geolocator/geolocator.dart';  // Untuk mengambil lokasi saat ini

class CourierMapScreen extends StatefulWidget {
  const CourierMapScreen({super.key});

  @override
  _CourierMapScreenState createState() => _CourierMapScreenState();
}

class _CourierMapScreenState extends State<CourierMapScreen> {
  // Koordinat awal untuk menampilkan lokasi kurir
  LatLng _currentPosition = LatLng(-6.2088, 106.8456);  // Default: Jakarta
  
  // Controller untuk mengontrol peta
  final MapController _mapController = MapController();

  // Inisialisasi peta
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Fungsi untuk mendapatkan lokasi saat ini
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Layanan lokasi tidak aktif');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Izin lokasi ditolak');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Izin lokasi ditolak permanen');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentPosition, 14.0); // Pindahkan peta ke lokasi baru
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigasi Kurir'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _currentPosition, // Ganti 'center' menjadi 'initialCenter'
          initialZoom: 14.0, // Ganti 'zoom' menjadi 'initialZoom'
          onTap: (tapPosition, point) {
            print("Diklik di: $point");
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _currentPosition,
                width: 80.0,
                height: 80.0,
                child: Icon(Icons.location_pin, color: Colors.red, size: 40), // Ganti 'builder' dengan 'child'
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        tooltip: 'Lokasi Saya',
        child: Icon(Icons.my_location),
      ),
    );
  }
}