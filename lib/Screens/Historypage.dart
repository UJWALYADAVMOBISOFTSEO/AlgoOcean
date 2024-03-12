import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../CommonWidgets/image_helper.dart';
import '../Global/colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

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
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      border: Border.all(color: PRIMARY, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ImageHelper(
                              image: 'assets/images/GoogleLogo.png',
                              imageType: ImageType.asset,
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.ac_unit),
                                InkWell(
                                  onTap: () {},
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
