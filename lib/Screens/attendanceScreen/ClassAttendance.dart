import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Utils/Image_Constant.dart';
import 'AttendanceScreen.dart';

class ClassAttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.blue700,
        leading: Image.asset(attendanceScreen),
        title: Text("CLASSES",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 24.w,color: Colors.white),),


      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 1; i <= 10; i++)
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>const AttendanceScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          'Class $i',
                          style: TextStyle(fontSize: 24.w, color: Colors.white),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
          ],
        ),
      ),
    );
  }
}
