class Subject {
  String subjectID;
  String subjectName;
  String teacherName;

  Subject(
      {required this.subjectID,
      required this.subjectName,
      required this.teacherName});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
        subjectID: json['subjectID'],
        subjectName: json['subjectName'],
        teacherName: json['teacherName']);
  }

  Map<String, dynamic> toJson() => {
        'subjectID': this.subjectID,
        'subjectName': this.subjectName,
        'teacherName': this.teacherName,
      };
}
