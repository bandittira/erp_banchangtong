import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/adjust_body.dart';

RxMap<String, dynamic> productDetailArray = <String, dynamic>{}.obs;

class GetProductDetailsById {
  Future getAllProduct(String id, String code) async {
    diamondColorArr.clear();
    diamondClarity.clear();
    diamondCut.clear();
    const String baseUrl = 'http://10.0.2.2:8000';
    String endpoint = '/getProduct/$id/$code';

    try {
      final Uri uri = Uri.parse('$baseUrl$endpoint');
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final dynamic responseData =
            json.decode(utf8.decode(response.bodyBytes));
        productDetailArray.assignAll(responseData['results']);
        imageName.value = productDetailArray['productDetail'][0]['ImageName'];
        priceText.value.text =
            productDetailArray['productDetail'][0]['Price'].toString();
        basePriceText.value.text =
            productDetailArray['productDetail'][0]['BasePrice'];
        print(productDetailArray['product'][0]['ProductCode']);
        return responseData['product'];
        // Handle the response data appropriately
      } else {
        print(response.statusCode);
        return ('Request failed with status: ${response.statusCode}');
        // Handle the error situation gracefully
      }
    } catch (error) {
      print(error);
      return ('An error occurred: $error');
      // Handle the error situation gracefully
    }
  }
}
