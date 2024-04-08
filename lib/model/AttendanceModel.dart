class Attendance {
  final String studentId;
  final String className;
  final bool isPresent;

  Attendance({
    required this.studentId,
    required this.className,
    required this.isPresent,
  });

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'className': className,
      'isPresent': isPresent,
    };
  }
}
