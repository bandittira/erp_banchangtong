import 'package:erp_banchangtong/pages/home/components/product_cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../scanner/qr_scanner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 0);

    // ignore: unused_element
    Future<void> removeSharedPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('isLogged', 'false');
      prefs.remove('Id');
      prefs.remove('Fname');
      prefs.remove('Lname');
      prefs.remove('PermissionId');
    }

    var screen = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: screen.size.width,
              child: Column(
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
                    width: screen.size.width / 0.175,
                    child: Row(
                      children: [
                        Container(
                          width: screen.size.width / 1.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: const TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                contentPadding: EdgeInsets.only(top: 15),
                                prefixIcon: Icon(Iconsax.search_normal)),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () => {Get.to(const QRViewExample())},
                          child: Container(
                            width: screen.size.width / 7,
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: screen.size.width,
                      height: 280,
                      child: const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://banchangtong.s3.ap-southeast-1.amazonaws.com/images/ec6903c5-721f-4e24-adf1-e4d8662d55985621050335100112240.jpg"),
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/361088281_700518162091530_7746397129097762439_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeHhvrAiGu6kcwwPOCeLDqA-Pq7IxF-Kz6Y-rsjEX4rPpjediUs4LqxvVdQKQRNSyE-Hn9hpI4gqnOLaH0H0JdSq&_nc_ohc=-0GKCG68VBkAX9Og8GU&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfBvTF3hKHD8m7HrvffP5eNZjhRndbZMa-K75EXnebNhIQ&oe=64CE0151"),
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/361088281_700518162091530_7746397129097762439_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeHhvrAiGu6kcwwPOCeLDqA-Pq7IxF-Kz6Y-rsjEX4rPpjediUs4LqxvVdQKQRNSyE-Hn9hpI4gqnOLaH0H0JdSq&_nc_ohc=-0GKCG68VBkAX9Og8GU&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfBvTF3hKHD8m7HrvffP5eNZjhRndbZMa-K75EXnebNhIQ&oe=64CE0151"),
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/361088281_700518162091530_7746397129097762439_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeHhvrAiGu6kcwwPOCeLDqA-Pq7IxF-Kz6Y-rsjEX4rPpjediUs4LqxvVdQKQRNSyE-Hn9hpI4gqnOLaH0H0JdSq&_nc_ohc=-0GKCG68VBkAX9Og8GU&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfBvTF3hKHD8m7HrvffP5eNZjhRndbZMa-K75EXnebNhIQ&oe=64CE0151"),
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/361088281_700518162091530_7746397129097762439_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeHhvrAiGu6kcwwPOCeLDqA-Pq7IxF-Kz6Y-rsjEX4rPpjediUs4LqxvVdQKQRNSyE-Hn9hpI4gqnOLaH0H0JdSq&_nc_ohc=-0GKCG68VBkAX9Og8GU&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfBvTF3hKHD8m7HrvffP5eNZjhRndbZMa-K75EXnebNhIQ&oe=64CE0151"),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: screen.size.width,
                    height: 3,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300.withOpacity(0.1)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Latest sold",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: screen.size.width,
                      height: 280,
                      child: const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/361088281_700518162091530_7746397129097762439_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeHhvrAiGu6kcwwPOCeLDqA-Pq7IxF-Kz6Y-rsjEX4rPpjediUs4LqxvVdQKQRNSyE-Hn9hpI4gqnOLaH0H0JdSq&_nc_ohc=-0GKCG68VBkAX9Og8GU&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfBvTF3hKHD8m7HrvffP5eNZjhRndbZMa-K75EXnebNhIQ&oe=64CE0151"),
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/361088281_700518162091530_7746397129097762439_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeHhvrAiGu6kcwwPOCeLDqA-Pq7IxF-Kz6Y-rsjEX4rPpjediUs4LqxvVdQKQRNSyE-Hn9hpI4gqnOLaH0H0JdSq&_nc_ohc=-0GKCG68VBkAX9Og8GU&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfBvTF3hKHD8m7HrvffP5eNZjhRndbZMa-K75EXnebNhIQ&oe=64CE0151"),
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/361088281_700518162091530_7746397129097762439_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeHhvrAiGu6kcwwPOCeLDqA-Pq7IxF-Kz6Y-rsjEX4rPpjediUs4LqxvVdQKQRNSyE-Hn9hpI4gqnOLaH0H0JdSq&_nc_ohc=-0GKCG68VBkAX9Og8GU&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfBvTF3hKHD8m7HrvffP5eNZjhRndbZMa-K75EXnebNhIQ&oe=64CE0151"),
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/361088281_700518162091530_7746397129097762439_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeHhvrAiGu6kcwwPOCeLDqA-Pq7IxF-Kz6Y-rsjEX4rPpjediUs4LqxvVdQKQRNSyE-Hn9hpI4gqnOLaH0H0JdSq&_nc_ohc=-0GKCG68VBkAX9Og8GU&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfBvTF3hKHD8m7HrvffP5eNZjhRndbZMa-K75EXnebNhIQ&oe=64CE0151"),
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/361088281_700518162091530_7746397129097762439_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeHhvrAiGu6kcwwPOCeLDqA-Pq7IxF-Kz6Y-rsjEX4rPpjediUs4LqxvVdQKQRNSyE-Hn9hpI4gqnOLaH0H0JdSq&_nc_ohc=-0GKCG68VBkAX9Og8GU&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfBvTF3hKHD8m7HrvffP5eNZjhRndbZMa-K75EXnebNhIQ&oe=64CE0151"),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: screen.size.width,
                    height: 3,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300.withOpacity(0.1)),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
