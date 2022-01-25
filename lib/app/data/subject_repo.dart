import 'dart:developer';

import 'package:attendance_app/app/modules/student/models/attendance.dart';
import 'package:attendance_app/app/modules/student/models/subject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late CollectionReference subjectsRef;

  SubjectRepo() {
    subjectsRef = _firestore.collection('subjects');
  }

  Future<List<Subject>> getStudentSubjects() async {
    final subjectsDocs = await subjectsRef.get();
    final subjects = subjectsDocs.docs
        .map((e) => Subject.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return subjects;
  }

  Future<bool> markAttendance(Attendance attendance) async {
    try {
      await _firestore.collection('attendance').add(attendance.toJson());
      return true;
    } on FirebaseException catch (e) {
      print('There was an issue marking attendance $e');
      return false;
    }
  }
}
