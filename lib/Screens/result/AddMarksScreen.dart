import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacherportal/Screens/result/services/bloc/result_bloc.dart';
import 'package:teacherportal/Screens/result/services/resultrepo.dart';
import 'package:teacherportal/model/resultModel.dart';
import 'package:teacherportal/singletons/resultclasssingleton.dart';
import 'package:teacherportal/singletons/subjectSingleton.dart';
import 'package:teacherportal/singletons/termSingleton.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import '../../Utils/Image_Constant.dart';
import '../HomeScreen/TeacherHomeScreen.dart';

class AddMarks extends StatefulWidget {
  const AddMarks({Key? key}) : super(key: key);

  @override
  State<AddMarks> createState() => _AddMarksState();
}

class _AddMarksState extends State<AddMarks> {
late ResultBloc _resultBloc;
  List<TextEditingController> markControllers = [];
  List<dynamic> students = [];

  Future<void> fetchStudents() async {
    final response = await http.get(Uri.parse('https://school-management-system-backend-eight.vercel.app/Students'));
    final jsonData = jsonDecode(response.body);
    setState(() {
      students = jsonData['students'].where((student) => student['className'] == ResultClassNameManager().className).toList();
      markControllers = List.generate(
        students.length,
            (index) => TextEditingController(),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    fetchStudents();
    _resultBloc=ResultBloc(ResultService());

  }
  // List<Student> students = List.generate(
  //   20,
  //       (index) => Student(id: index + 1, name: 'Student ${index + 1}', marks: 0),
  // );

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize a TextEditingController for each student

  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue700,
        leading: Image.asset(Examscreen),
        title: Text("ADD MARKS",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 24.w,color: Colors.white),),
      ),
      body: BlocListener<ResultBloc, ResultState>(
        bloc: _resultBloc,
        listener: (context,state){

        },
        child: Column(
          children: [
            Container(
              color: Vx.blue200,
              padding: EdgeInsets.all(16.w.h),
              child: Row(
                children: [
                  const Text("Student name"),
                  SizedBox(width: 200.w,),
                  const Text("Marks")

                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(students[index]['fullname']),
                    subtitle: Text('ID: ${students[index]['username']}'),
                    trailing: SizedBox(
                      width: 60.w,
                      height: 40.h,
                      child: TextField(
                        controller: markControllers[index],
                        keyboardType: TextInputType.number,
                        decoration:const InputDecoration(
                          hintText: 'Marks',
                        ),
                      ),
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
            List<Result> marksList = [];
            int term = int.parse(TermManager().term.toString());
            for (int i = 0; i < students.length; i++) {
              if (students[i]['_id'] != null) { // Add a null check
                int marks = int.tryParse(markControllers[i].text) ?? 0;
                marksList.add(Result(studentId: students[i]['_id'].toString(), subjectId: SubjectManager().subject.toString(), term: term, marks: marks));
              }
            }
            print(marksList);
            _resultBloc.add(AddResult(marksList));
            VxToast.show(context, msg: "marks insterded successfully");
          },
          child:const Icon(Icons.check),
        ),
    );
  }
}
