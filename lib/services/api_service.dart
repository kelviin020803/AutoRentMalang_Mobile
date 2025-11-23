import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  static Future<List<dynamic>> getMobilHttp() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat data (${response.statusCode})');
    }
  }

  static Future<List<dynamic>> getMobilDio() async {
    var dio = Dio();
    final response = await dio.get(baseUrl);
    if (response.statusCode == 200) {
      if (response.data is List) return response.data;
      throw Exception('Format data tidak sesuai (bukan List)');
    } else {
      throw Exception('Gagal memuat data dengan Dio (${response.statusCode})');
    }
  }
}