import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/AttendanceModel.dart';

class AttendanceService {
  final String baseUrl = 'http://192.168.56.1:7000/Add_attendance';

  Future<void> addAttendance(List<Attendance> attendances) async {
    final List<Map<String, dynamic>> jsonData =
    attendances.map((attendance) => attendance.toJson()).toList();

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'attendances': jsonData}),
    );

    if (response.statusCode == 200) {
      print('Attendance recorded successfully');
    } else {
      throw Exception('Failed to record attendance');
    }
  }
}
