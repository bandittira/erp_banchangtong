import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:searchfield/searchfield.dart';
import '../../home/controller/var.dart';
import '../controller/get_id.dart';
import '../controller/var.dart' as vars;

RxString selectedValue = vars.items[0].obs;
RxString productCode = "RD".obs;
RxInt productId = 1000001.obs;

class WidgetBody extends StatelessWidget {
  const WidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    GetProductId getProductIdClass = GetProductId();
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header(),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: Get.width,
          height: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        const SizedBox(
          height: 20,
        ),
        productCodeWidget(),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "รายละเอียด",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
            width: Get.width / 0.175,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade200,
            ),
            child: SingleChildScrollView(
              child: DropdownButtonHideUnderline(
                child: Obx(() => DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text("หมวดหมู่"),
                      items: vars.items
                          .map((String item) => DropdownMenuItem<String>(
                              value: item, child: Text(item)))
                          .toList(),
                      value: selectedValue.value,
                      onChanged: (value) {
                        selectedValue.value = value!;
                        getProductIdClass.getProductId(vars
                            .category[vars.items.indexOf(selectedValue.value)]);
                      },
                    )),
              ),
            )),
      ],
    ));
  }
}

Widget header() {
  return Row(
    children: [
      const Text(
        "แก้ไขข้อมูล",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: Get.width / 6,
      ),
      Container(
        width: Get.width / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey.shade200),
        child: SearchField(
          onSuggestionTap: (x) => {
            productCode.value = x.item.toString().substring(0, 2),
            productId.value = int.parse(x.item.toString().substring(2, 9)),
            selectedValue.value =
                vars.items[vars.category.indexOf(productCode.value)],
          },
          searchInputDecoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.search_normal),
              contentPadding: EdgeInsets.only(top: 15),
              hintText: "Search",
              border: InputBorder.none),
          suggestions: allProduct
              .map(
                (e) => SearchFieldListItem(
                  e.toString(),
                  item: e,
                  // Use child to show Custom Widgets in the suggestions
                  // defaults to Text widget
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(e.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      )
    ],
  );
}

Widget productCodeWidget() {
  return Row(
    children: [
      const Text(
        "รหัสสินค้า ",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      Obx(() => Text(
            '#${productCode.toString()} ${productId.toString()}',
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          )),
    ],
  );
}
