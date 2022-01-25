import 'package:attendance_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:attendance_app/app/modules/auth/models/user.dart';
import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Profile',
            style: TextStyle(color: Colors.black, fontSize: 30.0)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Obx(
          () => controller.isLoading.value == true
              ? CircularProgressIndicator()
              : Container(
                  height: Get.height * 0.45,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          child: Image.network(
                              'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(fontSize: 25.0),
                            ),
                            SizedBox(width: 30.0),
                            Text(
                              controller.currentUser.name,
                              style: TextStyle(fontSize: 25.0),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ID',
                              style: TextStyle(fontSize: 25.0),
                            ),
                            SizedBox(width: 30.0),
                            Text(
                              controller.currentUser.studentID,
                              style: TextStyle(fontSize: 25.0),
                            )
                          ],
                        ),
                        controller.currentUser.role == 'student'
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Semester',
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                  SizedBox(width: 30.0),
                                  Text(
                                    controller.currentUser.semester,
                                    style: TextStyle(fontSize: 25.0),
                                  )
                                ],
                              )
                            : SizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Department',
                              style: TextStyle(fontSize: 25.0),
                            ),
                            SizedBox(width: 30.0),
                            Text(
                              controller.currentUser.department,
                              style: TextStyle(fontSize: 25.0),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await controller.signOut();
                            // authController.currentUser.value = UserModel(
                            //     name: '',
                            //     email: '',
                            //     contact: '',
                            //     department: '',
                            //     semester: '',
                            //     role: '',
                            //     studentID: '',
                            //     uid: '');
                            Get.offAllNamed(Routes.AUTH);
                          },
                          child: Container(
                            height: 50.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.blue,
                            ),
                            child: Center(
                              child: Text('Logout',
                                  style: TextStyle(
                                      fontSize: 25.0, color: Colors.white)),
                            ),
                          ),
                        )
                      ]),
                ),
        ),
      ),
    );
  }
}
