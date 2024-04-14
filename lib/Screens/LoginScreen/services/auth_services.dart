import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teacherportal/model/teacherprofilemodel.dart';
import 'package:teacherportal/singletons/classSingleton.dart';
import 'package:teacherportal/singletons/usernamesingleton.dart';

import '../../../singletons/useridSingleton.dart';




class AuthService {
  final String baseUrl;

  AuthService({required this.baseUrl});

  Future<String> login({required String username, required String password}) async {
    final loginUrl = Uri.parse('https://school-management-system-backend-eight.vercel.app/users/login');
    final profileUrl = Uri.parse('https://school-management-system-backend-eight.vercel.app/user/$username');

    try {
      // Login request
      final loginResponse = await http.post(
        loginUrl,
        body: jsonEncode({"username": username, "password": password}),
        headers: {'Content-Type': 'application/json'},
      );
      print(loginResponse.body);

      if (loginResponse.statusCode != 200) {
        throw Exception('Failed to login (Status code: ${loginResponse.statusCode})');
      }

      final Map<String, dynamic> loginData = json.decode(loginResponse.body);
      final String token = loginData['token'];

      // Fetch user profile
      final profileResponse = await http.get(profileUrl);
      print(profileResponse.body);

      if (profileResponse.statusCode != 200) {
        throw Exception('Failed to fetch user profile (Status code: ${profileResponse.statusCode})');
      }

      final Map<String, dynamic> profileData = json.decode(profileResponse.body);
      final Map<String, dynamic> userData = profileData['user'];
      final teacherProfileModel = TeacherprofileModel.fromJson(userData);
      String? className=teacherProfileModel.className;
      String? teacherId = teacherProfileModel.id;
      String? usernames = teacherProfileModel.username;
      ClassNameManager().setClassName(className);
      TeacherIdManager().setStudentId(teacherId);
      UserManager().setUserName(usernames!);
      print(TeacherIdManager().studentId);
      print(UserManager().username);

      print('Login successful!');
      return token;
    } catch (error) {
      print('Error during login: $error');
      throw LoginException(error.toString());
    }
  }

}

class LoginException implements Exception {
  final String message;

  LoginException(this.message);
}