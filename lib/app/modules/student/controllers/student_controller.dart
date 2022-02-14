import 'dart:developer';

import 'package:attendance_app/app/data/subject_repo.dart';
import 'package:attendance_app/app/modules/student/models/attendance.dart';
import 'package:attendance_app/app/modules/student/models/subject.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class StudentController extends GetxController {
  RxList<Subject> studentSubjectList = RxList.empty(growable: true);
  RxBool isLoading = false.obs;
  RxString qrCodeScanText = 'Default text'.obs;

  SubjectRepo subjectRepo = SubjectRepo();

  final currentUser = Get.arguments;

  Future<void> getStudentSubjects() async {
    isLoading.value = true;
    final subjects = await subjectRepo.getStudentSubjects();
    studentSubjectList.value = subjects;
    isLoading.value = false;
  }

  Future scanCode(Subject subject) async {
    isLoading.value = true;
    try {
      String barcode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", false, ScanMode.DEFAULT);
      qrCodeScanText.value = barcode;
      if (qrCodeScanText.value.isNotEmpty) {
        log('QR CODE VALUE:::::;; ${qrCodeScanText.value}');
        if (qrCodeScanText.value == '-1') {
          Get.snackbar('Error',
              'There was an error while marking attendance. Try again');
        } else {
          final codeScanText = qrCodeScanText.value.trim();
          await markAttendance(subject);
        }
      }
      isLoading.value = false;
    } on PlatformException catch (e) {
      print('Platform exception :::::::::::: $e');
    } on FormatException catch (e) {
      print('Format exception :::::::::::: $e');
    } catch (e) {
      print('Catch::::: $e');
    }
  }

  Future<void> markAttendance(Subject subject) async {
    Map<String, dynamic> jsonSubject = subject.toJson();

    jsonSubject = {
      ...jsonSubject,
      'studentID': currentUser.studentID,
      'studentName': currentUser.name,
      'studentUID': currentUser.uid,
    };
    final subjectAttendance = Attendance.fromJson(jsonSubject);
    log(subjectAttendance.toString());
    final attendance = await subjectRepo.markAttendance(subjectAttendance);
    if (attendance == true) {
      Get.snackbar('Attendance', 'Attendacne marked successfully');
    } else {
      Get.snackbar('Attendance',
          'There was an issue marking attendance. Please try again');
    }
  }

  @override
  void onInit() {
    getStudentSubjects();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
