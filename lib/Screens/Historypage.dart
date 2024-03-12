import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CommonWidgets/image_helper.dart';
import '../Global/colors.dart';
import 'CartPage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> imageUrls = [];
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    _loadImagesLocally();
    super.initState();
  }

  /// Load stored images from SharedPreferences
  Future<void> _loadImagesLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final storedImages = prefs.getStringList('imageUrls') ?? [];
    setState(() {
      imageUrls = storedImages;
    });
  }

  void addToCart(String imageUrl, String price) {
    setState(() {
      cartItems.add({'imageUrl': imageUrl, 'price': price});
    });
    saveCartToSharedPreferences();

    // Navigate to CartPage and pass the cartItems data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems: cartItems),
      ),
    );
  }

  void saveCartToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> cartItemsMapList = cartItems.map((item) {
      return {'imageUrl': item['imageUrl'], 'price': item['price']};
    }).toList();
    String cartItemsJson = jsonEncode(cartItemsMapList);
    prefs.setString('cartItems', cartItemsJson);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        ///This Is To Remove StatusBar Color
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          ///This is to Change Color of Leading Icon i.e Back Button
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: PRIMARY,
          centerTitle: true,
          title: Text(
            'History',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 24),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: PRIMARY, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ImageHelper(
                              image: imageUrls[index],
                              imageType: ImageType.network,
                              imageShape: ImageShape.circle,
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 90.0),
                                child: Text(
                                  '${index + 10} ₹',
                                  style: GoogleFonts.poppins(
                                      color: PRIMARY, fontSize: 24),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.pets),
                                    InkWell(
                                      onTap: () {
                                        addToCart(imageUrls[index],
                                            '${index + 10} ₹');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: PRIMARY, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Text(
                                            'Add To Cart',
                                            style: GoogleFonts.poppins(
                                                color: PRIMARY, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ));
  }
}
