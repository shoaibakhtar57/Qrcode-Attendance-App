import 'package:attendance_app/app/modules/auth/views/login_screen.dart';
import 'package:attendance_app/app/modules/auth/views/signup_screen.dart';
import 'package:attendance_app/app/modules/auth/views/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: Get.height * 0.7,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(55.0),
                bottomRight: Radius.circular(55.0),
              ),
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Get.height * 0.3,
                  child: Image(
                    image: AssetImage('assets/images/qrcode.png'),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Welcome To Attendance App',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Text(
                  'Where you can mark attendacne by using QR Code',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  height: Get.height * 0.3,
                  child: Image(
                    image: AssetImage('assets/images/ms.png'),
                  ),
                )
              ],
            ),
          ),
          AuthButton(
              title: 'Login',
              icon: Icon(
                Icons.login,
                color: Colors.white,
              ),
              color: Colors.green,
              onTap: () {
                Get.to(() => LoginScreen());
              }),
          AuthButton(
              title: 'Sign Up',
              color: Colors.green,
              icon: Icon(
                Icons.login,
                color: Colors.white,
              ),
              onTap: () {
                Get.to(() => SignupScreen());
              })
        ],
      ),
    );
  }
}
