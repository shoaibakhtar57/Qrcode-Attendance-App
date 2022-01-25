import 'package:attendance_app/app/modules/student/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatelessWidget {
  QrCodeScreen({Key? key, required this.subject}) : super(key: key);

  Subject subject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RepaintBoundary(
          //    key: globalKey,
          child: QrImage(
            data: '${subject.subjectName} ${subject.teacherName}',
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(80, 120),
            ),
          ),
        ),
      ),
    );
  }
}
