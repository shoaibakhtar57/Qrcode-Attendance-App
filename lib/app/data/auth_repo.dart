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

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
