import 'package:attendance_app/app/modules/home/controllers/home_controller.dart';
import 'package:attendance_app/app/modules/student/models/attendance.dart';
import 'package:attendance_app/app/modules/student/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentList extends StatelessWidget {
  StudentList({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Student ID',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Student Name',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Attendance Status',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: controller.studentListStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Attendance>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Center(child: Text('No connection established'));
                    case ConnectionState.waiting:
                      return Center(child: Text('Waiting for connection '));

                    case ConnectionState.active:
                      {
                        final students = snapshot.data!;

                        return ListView.builder(
                            itemCount: students.length,
                            itemBuilder: (context, index) {
                              final studentAttendance = students[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  height: 50.0,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        studentAttendance.studentID,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Text(
                                        studentAttendance.studentName,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Text(
                                        'Present',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 15.0),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });

                        // print(chats);
                        // return Center(child: Text('Connection Active'));
                      }
                    case ConnectionState.done:
                      return Center(child: Text('No connection established'));
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
