import 'dart:developer';

import 'package:attendance_app/app/data/subject_repo.dart';
import 'package:attendance_app/app/modules/student/models/subject.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Subject> studentSubjectList = RxList.empty(growable: true);
  RxBool isLoading = false.obs;

  SubjectRepo subjectRepo = SubjectRepo();

  final currentUser = Get.arguments;

  Future<void> getStudentSubjects() async {
    isLoading.value = true;
    final subjects = await subjectRepo.getStudentSubjects();
    studentSubjectList.value = subjects;
    isLoading.value = false;
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
