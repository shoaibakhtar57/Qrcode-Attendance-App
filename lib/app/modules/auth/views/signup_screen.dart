import 'package:attendance_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:attendance_app/app/modules/auth/views/widgets/auth_button.dart';
import 'package:attendance_app/app/modules/auth/views/widgets/signup_form.dart';
import 'package:attendance_app/app/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : controller.showSignUp.value == SignUp.none
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Attendacne App',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          height: 210.0,
                          child: Image(
                            image: AssetImage('assets/images/ms.png'),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.showSignUp.value = SignUp.teacher;
                          },
                          child: Container(
                            height: Get.height * 0.05,
                            width: Get.width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.green),
                            child: Center(
                              child: Text(
                                'Signup as Teahcer',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.showSignUp.value = SignUp.student;
                          },
                          child: Container(
                            height: Get.height * 0.05,
                            width: Get.width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.green),
                            child: Center(
                                child: Text(
                              'Signup as Student',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    ),
                  )
                : SignUpForm(),
      ),
    );
  }
}
