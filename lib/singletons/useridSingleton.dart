class TeacherIdManager {
  static final TeacherIdManager _instance = TeacherIdManager._internal();

  factory TeacherIdManager() {
    return _instance;
  }

  TeacherIdManager._internal();

  String? _studentId;

  void setStudentId(String? studentId) {
    _studentId = studentId;
  }

  String? get studentId => _studentId;
}
