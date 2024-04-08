import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:velocity_x/velocity_x.dart';


import '../../../Utils/Image_Constant.dart';
import '../../attendanceScreen/AttendanceScreen.dart';
import '../../attendanceScreen/ClassAttendance.dart';
import '../../homeworkScreen/HomeworkScreen.dart';
import '../../profilescreen/Profile.dart';
import '../../result/AddMarkstoclass.dart';
import '../../routine/TeacherRoutine.dart';


class homebutton extends StatelessWidget {

  const homebutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,

              mainAxisExtent: 190,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8.0
          ),itemCount: homelistTeacher.length, itemBuilder:(context, index){
        return  Column(children: [
          Container(
            height: 140.h,
            width: 125.w,
            decoration: BoxDecoration(color: Vx.green100,borderRadius: BorderRadius.circular(20.w.h)),
            child: Image.asset(homelistTeacher[index]),
          ),
          Text(Teacherhomelisttitle[index],style: TextStyle(fontSize: 18.w,fontWeight: FontWeight.w500),)

        ],).onTap(() {
          if(index==1){
          Navigator.push(context, MaterialPageRoute(builder: (context){
          return const TeacherHomeWorkScreen();
        })); }
          else if(index==0){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return AttendanceScreen() ;
            }));

          }else if(index==2){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ClassMarksScreen();
            }));

          }else if(index==3){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const TeacherRoutine();
            }));

          }else if(index==4){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const ProfileScreen();
            }));

          }
        }


        );
      }),
    );
  }
}
