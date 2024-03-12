import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Global/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function() ontap;

  const CustomButton({super.key, required this.title, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      onLongPress: (){

      },
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            color: PRIMARY,
            border: Border.all(color: PRIMARY, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              title,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
