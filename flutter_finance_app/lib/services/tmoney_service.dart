import 'package:http/http.dart' as http;
import 'dart:convert';

class TMoneyService {
  static const String _baseUrl = 'https://api.tmoney.tg'; // Replace with actual TMoney API URL
  static const String _apiKey = 'your_tmoney_api_key';
  static const String _merchantId = 'your_merchant_id';

  static Future<Map<String, dynamic>> initiatePayment({
    required String amount,
    required String phoneNumber,
    required String description,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/transactions'),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'merchant_id': _merchantId,
          'amount': amount,
          'phone_number': phoneNumber,
          'description': description,
          'currency': 'XOF',
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erreur TMoney: ${response.body}');
      }
    } catch (e) {
      throw Exception('Erreur de paiement TMoney: $e');
    }
  }

  static Future<Map<String, dynamic>> verifyPayment(String transactionId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/transactions/$transactionId'),
        headers: {
          'Authorization': 'Bearer $_apiKey',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erreur de vérification TMoney: ${response.body}');
      }
    } catch (e) {
      throw Exception('Erreur de vérification TMoney: $e');
    }
  }

  static Future<Map<String, dynamic>> checkBalance() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/balance'),
        headers: {
          'Authorization': 'Bearer $_apiKey',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erreur de vérification du solde TMoney: ${response.body}');
      }
    } catch (e) {
      throw Exception('Erreur de vérification du solde TMoney: $e');
    }
  }
}
