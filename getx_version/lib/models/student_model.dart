class StudentModel {
  const StudentModel({required this.fullName, required this.studentId, required this.email, required this.password});
  final String fullName;
  final String studentId;
  final String email;
  final String password;
  StudentModel copyWith({String? password}) => StudentModel(
    fullName: fullName, studentId: studentId, email: email, password: password ?? this.password);
}
