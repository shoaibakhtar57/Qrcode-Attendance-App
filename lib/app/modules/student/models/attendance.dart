class Attendance {
  String subjectName;
  String teacherName;
  String studentName;
  String studentID;
  String studentUID;

  Attendance(
      {required this.studentID,
      required this.studentName,
      required this.studentUID,
      required this.subjectName,
      required this.teacherName});

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
        studentID: json['studentID'],
        studentName: json['studentName'],
        studentUID: json['studentUID'],
        subjectName: json['subjectName'],
        teacherName: json['teacherName']);
  }

  Map<String, dynamic> toJson() => {
        'studentID': this.studentID,
        'studentName': this.studentName,
        'studentUID': this.studentUID,
        'subjectName': this.subjectName,
        'teacherName': this.teacherName,
      };
}
