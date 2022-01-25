import 'dart:developer';

import 'package:attendance_app/app/data/auth_repo.dart';
import 'package:attendance_app/app/modules/auth/models/user.dart';
import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:attendance_app/app/utils/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepo authRepo = AuthRepo();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController semester = TextEditingController();

  Rx<UserModel> currentUser = UserModel(
          name: '',
          email: '',
          contact: '',
          department: '',
          semester: '',
          role: '',
          studentID: '',
          uid: '')
      .obs;
  Rx<SignUp> showSignUp = Rx<SignUp>(SignUp.none);
  RxBool isLoading = false.obs;

  void setCurrentUser(UserModel user) {
    currentUser.value = user;
    log('INSIDE CURRENT USER');
    while (Get.currentRoute != Routes.SPLASH) {
      Get.back();
    }
  }

  Future<void> persistanceLogin() async {
    isLoading.value = true;
    await authRepo.persistanceLogin().then((value) {
      currentUser.value = value!;
      isLoading.value = false;
      if (currentUser.value.role == 'student') {
        Get.offAllNamed(Routes.STUDENT, arguments: currentUser.value);
      } else {
        Get.offAllNamed(Routes.HOME, arguments: currentUser.value);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      log('Error persistantly logging in: $error $stackTrace',
          name: 'Persistance Login');
    });
  }

  Future<void> login(email, password) async {
    isLoading.value = true;
    await authRepo.login(email, password).then((value) {
      currentUser.value = value!;
      isLoading.value = false;
      if (currentUser.value.role == 'student') {
        Get.offAllNamed(Routes.STUDENT, arguments: currentUser.value);
      } else {
        Get.offAllNamed(Routes.HOME, arguments: currentUser.value);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      log('There was an internal server error $error');
    });
  }

  Future<void> signupUser(
      name, email, password, id, contact, department, subject, semester) async {
    isLoading.value = true;
    final role = showSignUp.value == SignUp.teacher ? 'teacher' : 'student';
    final userData = {
      'name': name,
      'studentID': id,
      'contact': contact,
      'department': department,
      'subject': subject,
      'semester': semester,
      'role': role,
    };
    await authRepo.singupUser(userData, email, password).then((value) {
      log('${value!.toJson()}');
      setCurrentUser(value);
    }).onError((error, stackTrace) {
      isLoading.value = false;
    });
    ;

    isLoading.value = false;
  }

  void clearEditors() {
    email.clear();
    name.clear();
    id.clear();
    department.clear();
    subject.clear();
    semester.clear();
    contact.clear();
    password.clear();
  }

  @override
  void onInit() {
    persistanceLogin();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    clearEditors();
    isLoading.close();
    showSignUp.close();
  }
}
