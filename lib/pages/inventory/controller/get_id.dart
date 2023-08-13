import 'dart:convert';
import 'package:http/http.dart' as http;

import '../components/adjust_body.dart';

class GetProductId {
  Future<void> getProductId(String productCodeString) async {
    const String baseUrl = 'http://10.0.2.2:8000';
    const String endpoint = '/getProductId/';
    try {
      if (productCodeString.isEmpty) {
        print('Product code is empty');
        return;
      }

      final Uri uri = Uri.parse('$baseUrl$endpoint$productCodeString');
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData['results'] is List &&
            responseData['results'].isNotEmpty) {
          final Map<String, dynamic> productData = responseData['results'][0];
          productCode.value = productData['ProductCode'];
          productId.value = productData['ProductId'];
          // Handle the response data appropriately
          // Assign the values to productCode.value and productId.value
        } else {
          print('No product data found');
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        // Handle the error situation gracefully
      }
    } catch (error) {
      print('An error occurred: $error');
      // Handle the error situation gracefully
    }
  }
}
