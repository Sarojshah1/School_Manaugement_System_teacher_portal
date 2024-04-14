import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:teacherportal/singletons/resultclasssingleton.dart';
import 'package:teacherportal/singletons/subjectSingleton.dart';
import 'package:teacherportal/singletons/termSingleton.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import '../../Utils/Image_Constant.dart';
import '../LoginScreen/Widgets/customButton.dart';
import '../LoginScreen/Widgets/customTextfield.dart';
import '../homeworkScreen/HomeworkScreen.dart';
import 'AddMarksScreen.dart';

class ClassMarksScreen extends StatefulWidget {
  @override
  State<ClassMarksScreen> createState() => _ClassMarksScreenState();
}

class _ClassMarksScreenState extends State<ClassMarksScreen> {
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController(text: '');
  final TextEditingController _termController = TextEditingController();

  Map<String, String> subjectIdMap = {}; // Map to hold subject names and their IDs
  List<String> subjects = []; // List to hold subject names fetched from the backend
  String? _selectedSubject;
  Future<void> fetchSubjects() async {
    final url = Uri.parse('https://school-management-system-backend-eight.vercel.app/Subjects');
    final response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        // Store subject names and their IDs in the map
        subjectIdMap = Map.fromIterable(data, key: (subject) => subject['name'] as String, value: (subject) => subject['_id'] as String);
        subjects = data.map((subject) => subject['name'] as String).toList();
        print(subjects);

      });
      print(subjectIdMap);
    } else {
      throw Exception('Failed to fetch subjects');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSubjects(); // Fetch subjects when the widget initializes
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue700,
        leading: Image.asset(Examscreen),
        title: Text("ADD RESULT",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 24.w,color: Colors.white),),
      ),
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Welcome to the Result Section!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Dear Teachers,',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'We are excited to introduce the Result Section, a dedicated space for adding the Marks to students efficiently. The guidelines and rules for teachers to add marks for each term can vary depending on the educational institution, grade level, and specific curriculum. However, here are some general guidelines and rules that teachers often follow when assigning marks for each term:',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 20),
            FeatureItem(text: 'Teachers should thoroughly understand the curriculum for their subject and grade level. This includes knowing the learning objectives, key concepts, and skills that students are expected to master.'),
            FeatureItem(text: 'Provide clear rubrics or grading criteria for each assessment. This helps students understand expectations and allows for consistent and fair grading.'),
            FeatureItem(text: 'Use professional judgment when assigning marks. Consider factors such as student effort, improvement over time, and extenuating circumstances that may impact performance.'),
            const Gap(30),
            CustomTextfield(controller: _classController,ispass: false,decoration: InputDecoration(hintText: "Class(1-10)",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),),
            Gap(30.h),
            DropdownButtonFormField(
              value: _selectedSubject, // Current selected value
              items: subjects.map((String subject) {
                return DropdownMenuItem(
                  value: subject,
                  child: Text(subject),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSubject = newValue;

                });
              },
              decoration: InputDecoration(
                hintText: "Subject",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            Gap(30.h),
            CustomTextfield(controller:_termController,ispass: false,decoration: InputDecoration(hintText: "Term",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),),
            Gap(30.h),
            Center(
              child: MyButton(
                ontap: () {
                  final subjectId = subjectIdMap[_selectedSubject];
                  print(subjectId);
                 ResultClassNameManager().setClassName(_classController.text);
                 SubjectManager().setsubject(subjectId);
                 TermManager().setterm(_termController.text);
                 print(ResultClassNameManager().className);
                 print(SubjectManager().subject);
                 print(TermManager().term);
                 Navigator.push(context, MaterialPageRoute(builder: (context) => AddMarks(),));
                },
                height: 60.h,
                width: 290.w,
                radius: 20.h.w,
                text: "Next",
              ),
            )


          ],
        ),
      ),
    );
  }
}
