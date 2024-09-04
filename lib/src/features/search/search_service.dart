// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class CitySearchService {
//   final String apiKey = 'YOUR_OPENWEATHERMAP_API_KEY'; // Replace with your API key
//
//   Future<List<Map<String, dynamic>>> searchCity(String query) async {
//     final url = Uri.parse(
//         'http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=$apiKey');
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       return data.map((city) {
//         return {
//           'name': city['name'],
//           'lat': city['lat'],
//           'lon': city['lon'],
//         };
//       }).toList();
//     } else {
//       throw Exception('Failed to load cities');
//     }
//   }
// }
