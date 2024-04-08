// models/assignment_model.dart

class Assignment {
  final String subject;
  final String teacherId;
  final String title;
  final String description;
  final String dueDate;
  final String className;

  Assignment({
    required this.subject,
    required this.teacherId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.className,
  });
}

