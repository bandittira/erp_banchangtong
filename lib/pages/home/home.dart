import 'package:erp_banchangtong/pages/home/components/product_cards.dart';
import 'package:erp_banchangtong/pages/home/controller/var.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iconsax/iconsax.dart';
import '../inventory/adjust_detail.dart';
import '../inventory/components/adjust_body.dart';
import '../inventory/controller/var.dart' as vars;
import '../scanner/qr_scanner.dart';
import 'controller/get_product.dart';

// Import variables from var.dart file

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get product details
    GetProductDetails getProductDetails = GetProductDetails();
    getProductDetails.getProductDetails();
    getProductDetails.getAllProduct();

    // ignore: unused_element
    Future<void> removeSharedPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('isLogged', 'false');
      prefs.remove('Id');
      prefs.remove('Fname');
      prefs.remove('Lname');
      prefs.remove('PermissionId');
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: Get.width,
              child: Column(
                children: [
                  Obx(() {
                    if (productsArr.isEmpty || allProductTemp.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      pushProduct();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            child: const Text(
                              "Catalog",
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // test
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.transparent,
                            width: Get.width / 0.175,
                            child: Row(
                              children: [
                                Container(
                                  width: Get.width / 1.5,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: SearchField(
                                    onSuggestionTap: (x) => {
                                      productCode.value =
                                          x.item.toString().substring(0, 2),
                                      productId.value = int.parse(
                                          x.item.toString().substring(2, 9)),
                                      selectedValue.value = vars.items[vars
                                          .category
                                          .indexOf(productCode.value)],
                                      Get.to(() => const AdjustDetail())
                                    },
                                    searchInputDecoration:
                                        const InputDecoration(
                                            prefixIcon:
                                                Icon(Iconsax.search_normal),
                                            contentPadding:
                                                EdgeInsets.only(top: 15),
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
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                  onPressed: () =>
                                      {Get.to(const QRViewExample())},
                                  child: Container(
                                    width: Get.width / 7,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Icon(
                                      Iconsax.scanner,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Latest added",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              width: Get.width,
                              height: 280,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (var x = 0; x < productsArr.length; x++)
                                      ProductCard(
                                          '${productsArr[x]['ProductCode']}${productsArr[x]['ProductId']}',
                                          '${productsArr[x]['BasePrice']}',
                                          productsArr[x]['Price'],
                                          "https://scontent.fbkk12-1.fna.fbcdn.net/v/t39.30808-6/363812463_711734630969883_6541867963504109327_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=7f8c78&_nc_eui2=AeGcgKBvBSBFZNBIHMJ7rFoz-p5-Tl6R31b6nn5OXpHfVuxl0wNDHAt_MHQy_VL-Lk_12WApmsfXfWBgYe8KMJyb&_nc_ohc=UU4emcxBaVoAX_crK9d&_nc_ht=scontent.fbkk12-1.fna&oh=00_AfCHO5T_0gZlF2TV2O902et9v5Efi8oGMshqQAm0eMAqmw&oe=64DCBF61"),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: Get.width,
                            height: 3,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300.withOpacity(0.1)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Latest sold",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              width: Get.width,
                              height: 280,
                              child: const SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ProductCard(
                                        "Nike Air Force",
                                        "20pcs + 8 colors + 12 Sizes",
                                        3600,
                                        "https://scontent.fbkk12-1.fna.fbcdn.net/v/t39.30808-6/363812463_711734630969883_6541867963504109327_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=7f8c78&_nc_eui2=AeGcgKBvBSBFZNBIHMJ7rFoz-p5-Tl6R31b6nn5OXpHfVuxl0wNDHAt_MHQy_VL-Lk_12WApmsfXfWBgYe8KMJyb&_nc_ohc=UU4emcxBaVoAX_crK9d&_nc_ht=scontent.fbkk12-1.fna&oh=00_AfCHO5T_0gZlF2TV2O902et9v5Efi8oGMshqQAm0eMAqmw&oe=64DCBF61"),
                                    ProductCard(
                                        "Nike Air Force",
                                        "20pcs + 8 colors + 12 Sizes",
                                        3600,
                                        "https://scontent.fbkk12-1.fna.fbcdn.net/v/t39.30808-6/363812463_711734630969883_6541867963504109327_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=7f8c78&_nc_eui2=AeGcgKBvBSBFZNBIHMJ7rFoz-p5-Tl6R31b6nn5OXpHfVuxl0wNDHAt_MHQy_VL-Lk_12WApmsfXfWBgYe8KMJyb&_nc_ohc=UU4emcxBaVoAX_crK9d&_nc_ht=scontent.fbkk12-1.fna&oh=00_AfCHO5T_0gZlF2TV2O902et9v5Efi8oGMshqQAm0eMAqmw&oe=64DCBF61"),
                                    ProductCard(
                                        "Nike Air Force",
                                        "20pcs + 8 colors + 12 Sizes",
                                        3600,
                                        "https://scontent.fbkk12-1.fna.fbcdn.net/v/t39.30808-6/363812463_711734630969883_6541867963504109327_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=7f8c78&_nc_eui2=AeGcgKBvBSBFZNBIHMJ7rFoz-p5-Tl6R31b6nn5OXpHfVuxl0wNDHAt_MHQy_VL-Lk_12WApmsfXfWBgYe8KMJyb&_nc_ohc=UU4emcxBaVoAX_crK9d&_nc_ht=scontent.fbkk12-1.fna&oh=00_AfCHO5T_0gZlF2TV2O902et9v5Efi8oGMshqQAm0eMAqmw&oe=64DCBF61"),
                                    ProductCard(
                                        "Nike Air Force",
                                        "20pcs + 8 colors + 12 Sizes",
                                        3600,
                                        "https://scontent.fbkk12-1.fna.fbcdn.net/v/t39.30808-6/363812463_711734630969883_6541867963504109327_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=7f8c78&_nc_eui2=AeGcgKBvBSBFZNBIHMJ7rFoz-p5-Tl6R31b6nn5OXpHfVuxl0wNDHAt_MHQy_VL-Lk_12WApmsfXfWBgYe8KMJyb&_nc_ohc=UU4emcxBaVoAX_crK9d&_nc_ht=scontent.fbkk12-1.fna&oh=00_AfCHO5T_0gZlF2TV2O902et9v5Efi8oGMshqQAm0eMAqmw&oe=64DCBF61"),
                                    ProductCard(
                                        "Nike Air Force",
                                        "20pcs + 8 colors + 12 Sizes",
                                        3600,
                                        "https://scontent.fbkk12-1.fna.fbcdn.net/v/t39.30808-6/363812463_711734630969883_6541867963504109327_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=7f8c78&_nc_eui2=AeGcgKBvBSBFZNBIHMJ7rFoz-p5-Tl6R31b6nn5OXpHfVuxl0wNDHAt_MHQy_VL-Lk_12WApmsfXfWBgYe8KMJyb&_nc_ohc=UU4emcxBaVoAX_crK9d&_nc_ht=scontent.fbkk12-1.fna&oh=00_AfCHO5T_0gZlF2TV2O902et9v5Efi8oGMshqQAm0eMAqmw&oe=64DCBF61"),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: Get.width,
                            height: 3,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300.withOpacity(0.1)),
                          ),
                        ],
                      );
                    }
                  })
                ],
              )),
        ),
      ),
    );
  }
}
