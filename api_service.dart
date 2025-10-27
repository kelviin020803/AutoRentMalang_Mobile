import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // ========================
  // HTTP (async-await)
  // ========================
  static Future<List<dynamic>> getMobilHttp() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      // Debug log
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body.substring(0, 50)}...');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Gagal memuat data (${response.statusCode})');
      }
    } catch (e) {
      print('Error HTTP: $e');
      rethrow;
    }
  }

  // ========================
  // DIO (callback chaining)
  // ========================
  static Future<List<dynamic>> getMobilDio() async {
    try {
      var dio = Dio();
      final response = await dio.get(baseUrl);

      // Debug log
      print('Dio status: ${response.statusCode}');
      print('Dio data type: ${response.data.runtimeType}');

      if (response.statusCode == 200) {
        if (response.data is List) {
          return response.data;
        } else {
          throw Exception('Format data tidak sesuai (bukan List)');
        }
      } else {
        throw Exception(
            'Gagal memuat data dengan Dio (${response.statusCode})');
      }
    } catch (e) {
      print('Error Dio: $e');
      rethrow;
    }
  }
}
