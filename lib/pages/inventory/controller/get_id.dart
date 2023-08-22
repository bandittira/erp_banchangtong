import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../home/controller/get_product.dart';
import '../../home/controller/var.dart';
import '../components/adjust_body.dart';
import 'var.dart' as insert;

class GetProductId {
  Future<void> getProductId(String productCodeString, String page) async {
    const String baseUrl = 'http://10.0.2.2:8000';
    const String endpoint = '/getProductId';
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
          if (page == "insert") {
            insert.productCode.value = productData['ProductCode'];
            insert.productId.value = productData['ProductId'] + 1;
          } else if (page == "adjust") {}
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

RxInt permissionId = 0.obs;

class GetPermission {
  Future<void> submitForm(username, password, buttonType) async {
    try {
      var response = await http.post(Uri.parse("http://10.0.2.2:8000/login"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            "username": username,
            "password": password,
          }));

      if (response.statusCode == 200) {
        // Login successful

        var a = json.decode(response.body);
        print(a['data'][0]['PermissionId']);
        if (a["message"] == "Username or Password does not match") {
          Get.snackbar("ผิดพลาด", "ชื่อผู้ใช้และรหัสผ่านไม่ตรง");
        } else if (a["message"] == "Login Success") {
          if (a['data'][0]['PermissionId'] == 1) {
            permissionId.value = a['data'][0]['PermissionId'];
            Get.back();
            Get.snackbar("ยืนยัน", "คุณมีสิทธิ์ดำเนินการ");
            if (buttonType == "delete") {
              DeleteProduct()
                  .deleteProduct(productCode.toString(), productId.toString());
            }
          } else {
            Get.back();
            Get.snackbar("ไม่สามารถดำเนินการ", "คุณไม่มีสิทธิ์ดำเนินการ");
          }
        } else {
          print("Error");
        }
      } else if (response.statusCode == 307) {
        // Redirect
        String? redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          response = await http.post(
            Uri.parse(redirectUrl),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          );

          if (response.statusCode == 200) {
            // Login successful after redirect
            print('Login successful after redirect!');
            print(json.decode(response.body));
          } else {
            // Login failed after redirect
            print(
                'Login failed after redirect. Status code: ${response.statusCode}');
            print(json.decode(response.body));
          }
        } else {
          // Redirect URL not provided
          print('Redirect URL not provided');
        }
      } else {
        // Login failed
        print('Login failed. Status code: ${response.statusCode}');
        print(json.decode(response.body));
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}

class DeleteProduct {
  Future<void> deleteProduct(
      String productCodeString, String productIdString) async {
    const String baseUrl = 'http://10.0.2.2:8000';
    String endpoint = '/deleteProduct/';
    try {
      if (productCodeString.isEmpty || productIdString.isEmpty) {
        print('Product code is empty');
        return;
      }

      final Uri uri = Uri.parse(
          '$baseUrl$endpoint$productCodeString${"/"}$productIdString');
      final http.Response response = await http.delete(uri);

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        print(responseData);
        if (responseData['message'] == 'Success') {
          Get.snackbar("ดำเนินการเสร็จสิ้น", "ทำการลบเรียบร้อย");
          GetProductDetails().getProductDetails();
          GetProductDetails().getAllProduct();
          pushProduct();
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
