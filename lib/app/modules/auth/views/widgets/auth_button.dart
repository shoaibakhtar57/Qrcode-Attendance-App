import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthButton extends StatelessWidget {
  AuthButton(
      {Key? key,
      required this.title,
      this.icon,
      required this.onTap,
      required this.color})
      : super(key: key);

  String title;
  Icon? icon;
  VoidCallback onTap;
  Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.05,
        width: Get.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? icon! : SizedBox(),
            SizedBox(
              width: 10.0,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
