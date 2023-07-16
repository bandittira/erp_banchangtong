import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String productName;
  final String detail;
  final int price;
  final String imagePath;
  const ProductCard(this.productName, this.detail, this.price, this.imagePath);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {},
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
            child: Text(
              widget.productName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 5, bottom: 6),
              child: Text(
                widget.detail,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              )),
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
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
