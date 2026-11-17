class Student {
  const Student({required this.name, required this.studentId, required this.email, required this.password});
  final String name;
  final String studentId;
  final String email;
  final String password;

  Student copyWith({String? password}) => Student(
    name: name, studentId: studentId, email: email, password: password ?? this.password,
  );
}
