import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Attendance App',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            height: Get.height * 0.2,
            width: Get.width * 0.3,
            child: Image(
              image: AssetImage('assets/images/ms.png'),
            ),
          ),
        ],
      )),
    );
  }
}
