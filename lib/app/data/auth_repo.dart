import 'dart:developer';

import 'package:attendance_app/app/modules/auth/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late CollectionReference usersRef;

  AuthRepo() {
    initRefrences();
  }

  void initRefrences() {
    usersRef = _firestore.collection('Users');
  }

  Future<UserModel?> persistanceLogin() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      try {
        final userDoc = await usersRef.doc(firebaseUser.uid).get();
        final userData = userDoc.data();
        final appUser = UserModel.fromJson(userData as Map<String, dynamic>);
        return appUser;
      } on FirebaseAuthException catch (error, stacktrace) {
        throw 'There was an error while persistantly logging in: $error \n $stacktrace';
      }
    }
  }

  Future<UserModel?> login(email, password) async {
    final firebaseUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    print(firebaseUser.user);

    if (firebaseUser.user != null) {
      try {
        final userDoc = await usersRef.doc(firebaseUser.user!.uid).get();
        final userData = userDoc.data();
        final appUser = UserModel.fromJson(userData as Map<String, dynamic>);
        return appUser;
      } on FirebaseAuthException catch (error, stacktrace) {
        throw 'Error while logging user: $error \n $stacktrace';
      }
    } else {
      return null;
    }
  }

  Future<UserModel?> singupUser(userData, email, password) async {
    final firebaseUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (firebaseUser.user != null) {
      userData = {
        ...userData,
        'uid': firebaseUser.user!.uid,
      };
      log('USER IS NOT NULL $userData');
      try {
        print('INSIDE TRY');
        log('${UserModel.fromJson(userData)}');
        await _firestore
            .collection('Users')
            .doc(firebaseUser.user!.uid)
            .set(userData);
        log('${UserModel.fromJson(userData)}');
        return UserModel.fromJson(userData);
      } on FirebaseException catch (error, stacktrace) {
        log('There was an error while signing up: $error',
            name: 'SignUpAndToFirestore', stackTrace: stacktrace);
        return null;
      }
    } else {
      return null;
    }
  }
}
