import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teacherportal/model/resultModel.dart';


class ResultService {
  final String baseUrl = 'https://school-management-system-backend-eight.vercel.app/Add_marks';

  Future<void> addResult(List<Result> results) async {
    final List<Map<String, dynamic>> jsonData =
    results.map((result) => result.toJson()).toList();

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 201) {
        print('Result recorded successfully');
      } else {
        print('Failed to record result: ${response.statusCode}');
        throw Exception('Failed to record result');
      }
    } catch (error) {
      print('Error adding result: $error');
      throw error; // Rethrow the error for the caller to handle
    }
  }
}
