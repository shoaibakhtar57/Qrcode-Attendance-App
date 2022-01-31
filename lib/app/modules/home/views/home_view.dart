import 'package:attendance_app/app/modules/home/views/qrcode_screen.dart';
import 'package:attendance_app/app/modules/home/views/student_list.dart';
import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.black,
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  child: Image.network(
                      'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png'),
                ),
                SizedBox(
                  height: 12.0,
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => StudentList());
                  },
                  leading: Icon(Icons.person),
                  title: Text('Present Students'),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title:
            Text('Home', style: TextStyle(color: Colors.black, fontSize: 30.0)),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.PROFILE, arguments: controller.currentUser);
              },
              icon: Icon(Icons.person, size: 30.0, color: Colors.black))
        ],
      ),
      body: Obx(
        () => controller.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : controller.studentSubjectList.isEmpty
                ? Center(child: Text('No subjects'))
                : ListView.builder(
                    itemCount: controller.studentSubjectList.length,
                    itemBuilder: (context, index) {
                      final indexItem = controller.studentSubjectList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => QrCodeScreen(subject: indexItem));
                        },
                        child: Container(
                          height: Get.height * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35.0),
                              topRight: Radius.circular(35.0),
                              bottomLeft: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
                            ),
                            color: Colors.blue,
                          ),
                          child: Center(
                              child: Text(
                            indexItem.subjectName.toString(),
                            style:
                                TextStyle(fontSize: 45.0, color: Colors.white),
                          )),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
