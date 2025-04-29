import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RouteService {
  // Menggunakan OSRM (Open Source Routing Machine) sebagai backend
  final String _osrmBaseUrl = 'http://router.project-osrm.org/route/v1/driving';

  // Metode utama untuk mendapatkan rute
  Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    try {
      // Format URL untuk request ke OSRM
      final url = '$_osrmBaseUrl/'
          '${start.longitude},${start.latitude};'
          '${end.longitude},${end.latitude}'
          '?overview=full&geometries=geojson';

      // Lakukan HTTP GET request
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse response JSON
        final data = jsonDecode(response.body);
        return _parseRouteFromResponse(data);
      } else {
        throw Exception('Gagal mendapatkan rute: Status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error saat mengambil rute: $e');
    }
  }

  // Parsing data response dari OSRM ke List<LatLng>
  List<LatLng> _parseRouteFromResponse(Map<String, dynamic> data) {
    final routes = data['routes'] as List;
    if (routes.isEmpty) {
      throw Exception('Tidak ada rute yang ditemukan');
    }

    final geometry = routes[0]['geometry'];
    if (geometry['type'] != 'LineString') {
      throw Exception('Format geometri tidak dikenali');
    }

    final coordinates = geometry['coordinates'] as List;
    return coordinates.map<LatLng>((coord) {
      return LatLng(coord[1].toDouble(), coord[0].toDouble());
    }).toList();
  }

  // Alternatif: Metode untuk mendapatkan rute sederhana (garis lurus)
  // Digunakan sebagai fallback jika API tidak tersedia
  List<LatLng> getSimpleRoute(LatLng start, LatLng end) {
    return [start, end];
  }
}