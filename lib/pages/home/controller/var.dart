// Home variables

import 'package:get/get.dart';

RxList productsArr = <dynamic>[].obs;
RxList allProduct = <dynamic>[].obs;

RxList allProductTemp = <dynamic>[].obs;

void pushProduct() {
  for (int i = 0; i < allProductTemp.length; i++) {
    allProduct.add(
      RxString(
        allProductTemp[i]['ProductCode'] +
            allProductTemp[i]['ProductId'].toString(),
      ),
    );
  }
}
