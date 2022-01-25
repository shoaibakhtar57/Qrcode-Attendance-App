import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_controller.dart';

class StudentView extends GetView<StudentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                        onTap: () async {
                          //Get.to(() => AttendanceScreen(subject: indexItem));
                          await controller.scanCode(indexItem);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
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
                              style: TextStyle(
                                  fontSize: 45.0, color: Colors.white),
                            )),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
