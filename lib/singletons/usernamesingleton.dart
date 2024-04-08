
class UserManager {
  static final UserManager _instance = UserManager._internal();

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  String? _username;

  void setUserName(String username) {
    _username = username;
  }

  String? get username => _username;
}
