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
          uid: '',
          subject: '')
      .obs;
  Rx<SignUp> showSignUp = Rx<SignUp>(SignUp.none);
  RxBool isLoading = false.obs;

  void setCurrentUser(UserModel user) {
    currentUser.value = user;
    if (currentUser.value.role == 'student') {
      Get.offAllNamed(Routes.STUDENT, arguments: [currentUser.value]);
    } else {
      Get.offAllNamed(Routes.HOME, arguments: [currentUser.value]);
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
    Map<String, dynamic> userData = {
      'name': name,
      'studentID': id,
      'contact': contact,
      'department': department,
      'subject': subject,
      'semester': semester,
      'role': role,
      'email': email
    };
    final _firebaseAuth = FirebaseAuth.instance;
    final firebaseUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (firebaseUser.user != null) {
      userData = {
        ...userData,
        'uid': firebaseUser.user!.uid,
      };
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(firebaseUser.user!.uid)
            .set(userData)
            .then((value) {
          final user = UserModel.fromJson(userData as Map<String, dynamic>);
          setCurrentUser(user);
        }).onError((error, stackTrace) {
          isLoading.value = false;
        });
      } on FirebaseException catch (error, stacktrace) {
        log('There was an error while signing up: $error',
            name: 'SignUpAndToFirestore', stackTrace: stacktrace);
      }
    } else {
      isLoading.value = false;
      Get.snackbar('User Already Exsist', 'This user already exsists');
    }

    // await authRepo
    //     .singupUser(
    //         userData, email.toString().trim(), password.toString().trim())
    //     .then((value) {
    //   setCurrentUser(value!);
    // }).onError((error, stackTrace) {
    //   isLoading.value = false;
    // });
    // ;

    // isLoading.value = false;
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
