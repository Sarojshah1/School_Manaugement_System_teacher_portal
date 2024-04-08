class TermManager {
  static final TermManager _instance = TermManager._internal();

  factory TermManager() {
    return _instance;
  }

  TermManager._internal();

  String? _term;

  void setterm(String? term) {
    _term = term;
  }

  String? get term => _term;
}
