import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacherportal/singletons/classSingleton.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import '../../Utils/Image_Constant.dart';
import '../../model/AttendanceModel.dart';
import '../HomeScreen/TeacherHomeScreen.dart';
import 'attendance/AttendanceService.dart';
import 'attendance/bloc/attendance_bloc.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late AttendanceBloc _attendanceBloc;
  List<dynamic> students = [];

  Future<void> fetchStudents() async {
    final response = await http.get(Uri.parse('http://192.168.56.1:7000/Students'));
    final jsonData = jsonDecode(response.body);
    setState(() {
      students = jsonData['students'].where((student) => student['className'] == ClassNameManager().className).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchStudents();
    _attendanceBloc = AttendanceBloc(attendanceService: AttendanceService());
  }

  // List<Student> students = List.generate(
  //   20,
  //       (index) => Student(id: index + 1, name: 'Student ${index + 1}', isPresent: false),
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue700,
        leading: Image.asset(attendanceScreen),
        title: Text("ATTENDANCE",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 24.w,color: Colors.white),),


      ),

      body: BlocListener<AttendanceBloc, AttendanceState>(
        bloc: _attendanceBloc,
        listener: (context, state) {
          if(state is AttendanceSuccess){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const TeacherHome();
            }));
            VxToast.show(context, msg: "Attendance Added Successfully");

          }else if(state is AttendanceFailure){
            VxToast.show(context, msg: "You can Only Add Attendance once in a day");

          }
          // Handle state changes here if needed
        },
        child: Column(
          children: [
            Container(
              color: Vx.blue200,
              padding: EdgeInsets.all(16.w.h),
              child: Row(
                children: [
                  const Text("Student name"),
                  SizedBox(width: 200.w),
                  const Text("Present"),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Vx.gray100,
                    horizontalTitleGap: 10,
                    title: Text(students[index]['fullname'] ?? ""),
                    subtitle: Text('ID: ${students[index]['username'] ?? ""}'),
                    trailing: Checkbox(
                      value: students[index]['isPresent'] ?? false,
                      onChanged: (value) {
                        setState(() {
                          students[index]['isPresent'] = value;
                        });

                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<Attendance> attendanceList = [];
          for (int i = 0; i < students.length; i++) {
            if (students[i]['_id'] != null) { // Add a null check
              attendanceList.add(Attendance(
                studentId: students[i]['_id'].toString(),
                className: ClassNameManager().className.toString() ?? "Unknown",
                isPresent: students[i]['isPresent'] ?? false,
              ));
            }
          }
          print(attendanceList);
          _attendanceBloc.add(AddAttendanceEvent(attendanceList));

        },
        child: const Icon(Icons.check),
      ),
    );
  }
}