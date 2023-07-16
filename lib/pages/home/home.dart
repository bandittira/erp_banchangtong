import 'package:erp_banchangtong/pages/home/components/product_cards.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> removeSharedPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('isLogged', 'false');
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
              height: screen.size.height,
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
                          onPressed: () => {},
                          child: Container(
                            width: screen.size.width / 7,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: const Icon(
                              Iconsax.setting_44,
                              color: Colors.black,
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
                      height: screen.size.height / 2.85,
                      child: const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/359508076_696228599187153_2661508143351250743_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=730e14&_nc_ohc=Jz2LOjpAdigAX96jsku&_nc_oc=AQmRsJR3dESabwDnMi5hutxBEzjAd8nYgoeAV_UUnQ8O_lS0wh-8R7Kyv21Bi9qlxcUazc2zQcDRkduLoLblAR6E&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfCqz5Y6y8uyg2YKBfDDfnSLXP1Y0zfhAL_vfFPKOimdFQ&oe=64B8E261"),
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/360132833_698182282325118_1715481436329912644_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_ohc=jYdP5OyN9ToAX_GSbS0&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfBTvByDzXSNQaGEQi2ggyjIMbB2HndOCnYnHBq4nDMYmQ&oe=64B839AA"),
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/358131843_688704116606268_8830508598617913031_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=730e14&_nc_ohc=jeSbWkvDtNYAX9PuJyC&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfCPhxhKCjUGU1jUkt570vjSPzzPlGjSJJGBDlFbWYwYsA&oe=64B8D474"),
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/357511545_685904200219593_3767147151628632197_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=730e14&_nc_ohc=OnDk6KabDkkAX8VfGia&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfAXmWRe8bNuwbMoGK4GMpQ05oHadIkeqJWxM4nhHsKubQ&oe=64B8FCE7"),
                            ProductCard(
                                "Nike Air Force",
                                "20pcs + 8 colors + 12 Sizes",
                                3600,
                                "https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/356653186_681387714004575_4246817800244333473_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=730e14&_nc_ohc=aoI4v-sr2rYAX-j-wRg&_nc_oc=AQkn5QpVb4Gbg_bZab1NYDjnPEZNaXPCyIO0lFT1eJADC-7WXFe12wXhL9QxHnHbnYwGRGV22kUX8oJ4d3RGPvI_&_nc_ht=scontent.fbkk23-1.fna&oh=00_AfDlm0M7EoagwRwrUaeMivcmWIBLxd2aF-rJ6Df_pWHYgg&oe=64B8B2C0"),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                 const Text("Menu",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                ],
              )),
              
        ),
      ),
    );
  }
}
