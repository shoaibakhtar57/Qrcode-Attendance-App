import 'package:attendance_app/app/modules/auth/views/auth_screen.dart';
import 'package:attendance_app/app/modules/home/views/home_view.dart';
import 'package:attendance_app/app/modules/student/views/student_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value == true
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : controller.currentUser.value.name.isEmpty
              ? AuthScreen()
              : SizedBox(),
    );
  }
}
