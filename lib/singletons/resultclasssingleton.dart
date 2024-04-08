class ResultClassNameManager {
  static final ResultClassNameManager _instance = ResultClassNameManager._internal();

  factory ResultClassNameManager() {
    return _instance;
  }

  ResultClassNameManager._internal();

  String? _className;

  void setClassName(String? className) {
    _className = className;
  }

  String? get className => _className;
}
