import 'dart:convert';
import 'package:erp_banchangtong/pages/home/controller/var.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetProductDetails {
  Future getProductDetails() async {
    const String baseUrl = 'http://49.0.192.147:8000';
    const String endpoint = '/getLatestProduct/';

    try {
      final Uri uri = Uri.parse('$baseUrl$endpoint');
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        productsArr.assignAll(responseData['results']);
        print(productsArr);
        return responseData['results'];
        // Handle the response data appropriately
      } else {
        return ('Request failed with status: ${response.statusCode}');
        // Handle the error situation gracefully
      }
    } catch (error) {
      return ('An error occurred: $error');
      // Handle the error situation gracefully
    }
  }

  Future getAllProduct() async {
    const String baseUrl = 'http://49.0.192.147:8000';
    const String endpoint = '/getAllProduct/';

    try {
      final Uri uri = Uri.parse('$baseUrl$endpoint');
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        allProductTemp.assignAll(responseData['results']);
        return responseData['results'];
        // Handle the response data appropriately
      } else {
        return ('Request failed with status: ${response.statusCode}');
        // Handle the error situation gracefully
      }
    } catch (error) {
      return ('An error occurred: $error');
      // Handle the error situation gracefully
    }
  }
}
