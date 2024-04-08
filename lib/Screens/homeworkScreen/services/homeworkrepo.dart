import 'dart:convert';
import 'package:http/http.dart' as http;

class AssignmentRepository {
  final String baseUrl;
  AssignmentRepository({required this.baseUrl});
  Future<void> addAssignment({
    required String subject,
    required String teacherId,
    required String title,
    required String description,
    required String dueDate,
    required String className,
  }) async {
    final url = Uri.parse('http://192.168.56.1:7000/Add_assignment');
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> body = {
      'subject': subject,
      'teacherId': teacherId,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'className': className,
    };

    try {
      final response = await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 201) {
        // Assignment added successfully
        print('Assignment added successfully');
      } else {
        // Error adding assignment
        print('Error adding assignment: ${response.statusCode}');
      }
    } catch (error) {
      print('Error adding assignment: $error');
    }
  }
}
