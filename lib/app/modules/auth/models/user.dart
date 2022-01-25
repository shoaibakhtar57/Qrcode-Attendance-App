class UserModel {
  String name;
  String email;
  String studentID;
  String contact;
  String department;
  String semester;
  String role;
  String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.contact,
    required this.department,
    required this.semester,
    required this.role,
    required this.studentID,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      contact: json['contact'],
      department: json['department'],
      semester: json['semester'],
      studentID: json['studentID'],
      role: json['role'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'email': this.email,
        'studentID': this.studentID,
        'contact': this.contact,
        'department': this.department,
        'semester': this.semester,
      };
}
