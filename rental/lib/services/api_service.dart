import 'dart:convert'; // Mengimpor library untuk mengolah data JSON
import 'package:http/http.dart'
    as http; // Mengimpor package http untuk melakukan request HTTP
import 'package:dio/dio.dart'; // Mengimpor Dio untuk melakukan request HTTP dengan fitur tambahan

class ApiService {
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com/posts'; // URL dasar API

  // ========================
  // HTTP (async-await)
  // ========================
  static Future<List<dynamic>> getMobilHttp() async {
    try {
      // Mengirim request GET ke API menggunakan http package
      final response = await http.get(Uri.parse(baseUrl));

      // Debug log untuk melihat status code dan bagian awal dari response body
      print('Status code: ${response.statusCode}');
      print(
          'Response body: ${response.body.substring(0, 50)}...'); // Menampilkan 50 karakter pertama dari body response

      // Jika status code 200 (OK), mengembalikan data yang sudah didekode dari JSON ke bentuk List
      if (response.statusCode == 200) {
        return json.decode(response.body); // Decode JSON response body
      } else {
        // Jika status code bukan 200, lempar exception
        throw Exception('Gagal memuat data (${response.statusCode})');
      }
    } catch (e) {
      // Menangani error jika terjadi masalah selama request HTTP
      print('Error HTTP: $e');
      rethrow; // Lempar error lagi agar bisa ditangani lebih lanjut
    }
  }

  // ========================
  // DIO (callback chaining)
  // ========================
  static Future<List<dynamic>> getMobilDio() async {
    try {
      var dio = Dio(); // Membuat instance Dio untuk melakukan request HTTP
      final response =
          await dio.get(baseUrl); // Mengirim request GET menggunakan Dio

      // Debug log untuk status code dan tipe data dari response
      print('Dio status: ${response.statusCode}');
      print(
          'Dio data type: ${response.data.runtimeType}'); // Melihat tipe data yang diterima

      // Jika status code 200 (OK), memeriksa apakah data yang diterima berupa List
      if (response.statusCode == 200) {
        if (response.data is List) {
          // Mengecek apakah data merupakan List
          return response.data; // Mengembalikan data berupa List
        } else {
          // Jika data bukan List, lempar exception
          throw Exception('Format data tidak sesuai (bukan List)');
        }
      } else {
        // Jika status code bukan 200, lempar exception
        throw Exception(
            'Gagal memuat data dengan Dio (${response.statusCode})');
      }
    } catch (e) {
      // Menangani error jika terjadi masalah selama request dengan Dio
      print('Error Dio: $e');
      rethrow; // Lempar error lagi agar bisa ditangani lebih lanjut
    }
  }
}
