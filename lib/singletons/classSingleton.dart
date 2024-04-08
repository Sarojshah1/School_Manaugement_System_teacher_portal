class ClassNameManager {
  static final ClassNameManager _instance = ClassNameManager._internal();

  factory ClassNameManager() {
    return _instance;
  }

  ClassNameManager._internal();

  String? _className;

  void setClassName(String? className) {
    _className = className;
  }

  String? get className => _className;
}
