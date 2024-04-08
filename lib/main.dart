import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacherportal/Screens/attendanceScreen/attendance/AttendanceService.dart';
import 'package:teacherportal/Screens/attendanceScreen/attendance/bloc/attendance_bloc.dart';
import 'package:teacherportal/Screens/result/services/resultrepo.dart';

import 'Screens/LoginScreen/services/auth_services.dart';
import 'Screens/LoginScreen/services/bloc/authentication_bloc.dart';
import 'Screens/homeworkScreen/services/bloc/homework_bloc.dart';
import 'Screens/homeworkScreen/services/homeworkrepo.dart';
import 'Screens/result/services/bloc/result_bloc.dart';
import 'Screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService(baseUrl: "http://localhost:7000/Student");
    final AssignmentRepository Service = AssignmentRepository(baseUrl: "http://192.168.56.1:7000/Add_assignment");
    final AssignmentRepository assignmentRepository = AssignmentRepository(baseUrl: "http://192.168.56.1:7000/Add_assignment");
    final ResultService resultService = ResultService();
    return  MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(authService: authService),
        ),BlocProvider<HomeworkBloc>(
          create: (context) => HomeworkBloc(Service),
        ),BlocProvider<AttendanceBloc>(
          create: (context) => AttendanceBloc(attendanceService: AttendanceService()),
        ),BlocProvider<ResultBloc>(
          create: (context) => ResultBloc(resultService),
        ),

        // Add more BlocProviders if needed
      ],
      child: ScreenUtilInit(
        builder: (_, child) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.green),
          home: child,
        ),
        designSize: const Size(375, 812),
        child: const SplashScreen(),
      ),
    );
  }
}
