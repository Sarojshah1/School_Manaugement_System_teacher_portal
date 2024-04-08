class SubjectManager {
  static final SubjectManager _instance = SubjectManager._internal();

  factory SubjectManager() {
    return _instance;
  }

  SubjectManager._internal();

  String? _subject;

  void setsubject(String? subject) {
    _subject = subject;
  }

  String? get subject => _subject;
}
