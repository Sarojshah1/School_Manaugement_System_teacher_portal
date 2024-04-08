import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacherportal/Screens/routine/services/api_service.dart';
import 'package:teacherportal/Screens/routine/services/bloc/routine_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Utils/Image_Constant.dart';
import '../../model/routine.dart';


class TeacherRoutine extends StatefulWidget {
  const TeacherRoutine({Key? key}) : super(key: key);

  @override
  State<TeacherRoutine> createState() => _TeacherRoutineState();
}

class _TeacherRoutineState extends State<TeacherRoutine> {
  late RoutineBloc _RoutineBloc;
  late RoutineRepository _routineRepository;

  @override
  void initState() {
    super.initState();
    _routineRepository = RoutineRepository();
    _RoutineBloc = RoutineBloc(repository:_routineRepository );
    _RoutineBloc.add(FetchRoutine()); // Fetch routine data when widget initializes
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue700,
        leading: Image.asset(Examscreen),
        title: Text("YOUR ROUTINE",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 24.w,color: Colors.white),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<RoutineBloc, RoutineState>(
                      bloc: _RoutineBloc,
                      builder: (context, state) {
                        if (state is RoutineLoading) {
                          return CircularProgressIndicator();
                        } else if (state is RoutineLoaded) {
                          Map<String, List<Routine>> routinesByDay = {};
                          for (var routine in state.routines) {
                            if (!routinesByDay.containsKey(routine.day)) {
                              routinesByDay[routine.day] = [];
                            }
                            routinesByDay[routine.day]!.add(routine);
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var day in routinesByDay.keys)
                                  SingleChildScrollView(
                                    scrollDirection: Axis.vertical,

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          day,
                                          style: TextStyle(
                                            fontSize: 20.w,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        ...routinesByDay[day]!.map((routine) => Column(
                                          children: [
                                            ScheduleItem(
                                              time: routine.time,
                                              subject: routine.subject,
                                            ),
                                            SizedBox(height: 10.h), // Adjust the height as per your requirement
                                          ],
                                        )),
                                        SizedBox(height: 20.h),

                                      ],
                                    ),
                                  ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          );
                        } else if (state is RoutineError) {
                          print(state.message);
                          return Text('Error: ${state.message}');
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),

              // Add more days and schedule items as needed
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleItem extends StatelessWidget {
  final String time;
  final String subject;

  const ScheduleItem({
    Key? key,
    required this.time,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: EdgeInsets.all(20.w.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Vx.blue200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subject,
            style:const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Text(time),
        ],
      ),
    );
  }
}
