import 'package:erp_banchangtong/pages/inventory/adjust_detail.dart';
import 'package:erp_banchangtong/pages/inventory/controller/get_product_detail.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';

import '../../inventory/components/adjust_body.dart';
import '../../inventory/controller/var.dart' as vars;

class ProductCard extends StatefulWidget {
  final String productName;
  final String detail;
  final int price;
  final String imagePath;
  final String pageType;
  const ProductCard(
      this.productName, this.detail, this.price, this.imagePath, this.pageType);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  void getAdjustPage(String page) {
    if (page == "latest_add") {
      productCode.value = widget.productName.substring(0, 2);
      productId.value = int.parse(widget.productName.substring(2, 9));
      selectedValue.value =
          vars.items[vars.category.indexOf(productCode.value)];
      GetProductDetailsById()
          .getAllProduct(productId.toString(), productCode.toString());
      Get.to(() => const AdjustDetail());
    } else if (page == "latest_sole") {}
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {getAdjustPage(widget.pageType)},
      child: Container(
        padding: const EdgeInsets.all(8),
        width: 180,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 3))
          ],
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          AspectRatio(
            aspectRatio: 90 / 100,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.topCenter,
                      image: NetworkImage(widget.imagePath))),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 5, bottom: 6),
            child: AutoSizeText(
              widget.productName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 5, bottom: 6),
              child: AutoSizeText(
                widget.detail,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              )),
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: AutoSizeText(
              widget.price.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          )
        ]),
      ),
    );
  }
}
