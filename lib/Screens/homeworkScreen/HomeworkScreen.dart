import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:teacherportal/Screens/homeworkScreen/services/bloc/homework_bloc.dart';
import 'package:teacherportal/singletons/useridSingleton.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Utils/Image_Constant.dart';
import '../../model/AssignmentModel.dart';
import '../HomeScreen/TeacherHomeScreen.dart';
import '../LoginScreen/Widgets/customButton.dart';
import '../LoginScreen/Widgets/customTextfield.dart';
import '../pushnotification.dart';



class TeacherHomeWorkScreen extends StatefulWidget {
  const TeacherHomeWorkScreen({Key? key}) : super(key: key);

  @override
  State<TeacherHomeWorkScreen> createState() => _TeacherHomeWorkScreenState();
}

class _TeacherHomeWorkScreenState extends State<TeacherHomeWorkScreen> {
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

 final String? ID=TeacherIdManager().studentId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue700,
        leading: Image.asset(homeworkscreen),
        title: Text("HOMEWORK",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 24.w,color: Colors.white),),
      ),
      body: BlocListener<HomeworkBloc, HomeworkState>(
        listener: (context, state) {
          if (state is AssignmentSuccess) {
            // Navigate back to TeacherHome on successful submission
            // sendNotification("New homework assigned: ${_titleController.text}");

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TeacherHome()));
          } else if (state is AssignmentFailure) {
            // Show error message if submission fails
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
            ));
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to the Homework Section!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Dear Teachers,',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                'We are excited to introduce the Homework Section, a dedicated space for managing and assigning homework efficiently. This feature allows you to:',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 10),
              FeatureItem(text: 'Assign and schedule homework tasks.'),
              FeatureItem(text: 'Track upcoming deadlines and submissions.'),
              FeatureItem(text: 'Provide feedback and grades for assignments.'),
              const Gap(30),
              CustomTextfield(controller: _classController,ispass: false,decoration: InputDecoration(hintText: "Class(1-10)",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),),
              Gap(30.h),
              CustomTextfield(controller: _subjectController,ispass: false,decoration: InputDecoration(hintText: "Subject",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),),
              Gap(30.h),
              CustomTextfield(controller:_titleController,ispass: false,decoration: InputDecoration(hintText: "Homework Title",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),),
              Gap(30.h),
              CustomTextfield(controller: _descriptionController,ispass: false,decoration: InputDecoration(hintText: "description",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),),
              Gap(30.h),
              CustomTextfield(controller: _dueDateController,ispass: false,decoration: InputDecoration(hintText: "Due Date(YYYY-MM-DD)",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),),
              Gap(30.h),
              Center(
                child: MyButton(
                  ontap: () {
                    // Add assignment submission logic
                    final assignmentBloc = BlocProvider.of<HomeworkBloc>(context);
                    assignmentBloc.add(
                      AddAssignment(
                        Assignment(
                          subject: _subjectController.text,
                          teacherId: ID.toString(), // Add teacherId
                          title: _titleController.text,
                          description: _descriptionController.text,
                          dueDate: _dueDateController.text,
                          className: _classController.text,
                        ),
                      ),

                    );
                  },
                  height: 60.h,
                  width: 290.w,
                  radius: 20.h.w,
                  text: "Submit",
                ),
              )
            ],
          ),
        ),
      ),


    );
  }
}
class FeatureItem extends StatelessWidget {
  final String text;

  const FeatureItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check, color: Colors.green),
        SizedBox(width: 8.0.w),
        Expanded(child: Text(text)),
      ],
    );
  }
}