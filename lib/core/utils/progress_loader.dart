import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// to show progress of asyc call
void showProgressDialog(BuildContext context, {bool isUpload = false}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (_) => WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Container(
          width: 80,
          padding: const EdgeInsets.all(8.0),
          child: const SizedBox(
              width: 80,
              height: 60,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.black,
                ),
                //     child: CupertinoActivityIndicator(
                //   radius: 25,
                //   color: Colors.grey[900],
                // )
              )),
        ),
      ),
    ),
  );
}

/// to hide progress of asyc call
void hideProgressDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true)
      .pop('dialog'); // this will pop the loading dialog only
}
