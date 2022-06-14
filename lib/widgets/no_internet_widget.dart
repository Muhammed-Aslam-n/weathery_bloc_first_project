import 'package:flutter/cupertino.dart';

Widget noInternetWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        Image.asset("assets/images/noInternetBg.png"),
        const Text(
          "No Internet",
          style: TextStyle(fontSize: 18),
        ),
        const Expanded(child: SizedBox())
      ],
    ),
  );
}
