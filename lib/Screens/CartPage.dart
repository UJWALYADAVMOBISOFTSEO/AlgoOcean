import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../CommonWidgets/image_helper.dart';
import '../Global/colors.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>>? cartItems;

  const CartPage({super.key, this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // Calculate the total price
    double totalPrice = 0.0;
    widget.cartItems?.forEach((item) {
      totalPrice += double.parse(item['price'].toString().replaceAll('₹', ''));
    });
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
            'Cart Page',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 24),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 10),
              child: Text(
                'Total: ₹$totalPrice',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: widget.cartItems?.length,
            itemBuilder: (context, index) {
              String imageUrl = widget.cartItems?[index]['imageUrl'];
              String price = widget.cartItems?[index]['price'];
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
                              image: imageUrl,
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
                                padding: const EdgeInsets.only(left: 100.0),
                                child: Text(
                                  '$price',
                                  style: GoogleFonts.poppins(
                                      color: PRIMARY, fontSize: 24),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/svgImages/dog.svg',
                                height: 50,
                                width: 70,
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
