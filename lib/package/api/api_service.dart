import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://171.244.142.43/api";

  static Future<Map<String, String>> _headers() async {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }

 
  static Future<dynamic> get(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");
    final headers = await _headers();

    final res = await http.get(url, headers: headers);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(res.body);
    } else {
      throw Exception("GET $endpoint failed: ${res.statusCode}");
    }
  }

  // POST
  static Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endpoint");
    final headers = await _headers();

    final res = await http.post(url, headers: headers, body: jsonEncode(body));

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(res.body);
    } else {
      throw Exception("POST $endpoint failed: ${res.statusCode}");
    }
  }

  // PUT
  static Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endpoint");
    final headers = await _headers();

    final res = await http.put(url, headers: headers, body: jsonEncode(body));

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(res.body);
    } else {
      throw Exception("PUT $endpoint failed: ${res.statusCode}");
    }
  }

  // DELETE
  static Future<dynamic> delete(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");
    final headers = await _headers();

    final res = await http.delete(url, headers: headers);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(res.body);
    } else {
      throw Exception("DELETE $endpoint failed: ${res.statusCode}");
    }
  }
}