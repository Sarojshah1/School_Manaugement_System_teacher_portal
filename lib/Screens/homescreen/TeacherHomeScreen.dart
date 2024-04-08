import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';

import '../../Utils/Image_Constant.dart';
import '../LoginScreen/LoginScreen.dart';
import 'Widgets/HomeCustomButton.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({Key? key}) : super(key: key);

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
      IconButton(
      icon: Icon(Icons.logout),
      onPressed: () {
        // Implement logout functionality here
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      },
    ),
      ]
      ),
      body: Column(
        children: [
          Center(
            child: Stack(children: [
              Container(
                width: 170.w,
                height: 170.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 4.w, color: Colors.white),

                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                    child: Image.asset(
                      profilepic,
                      fit: BoxFit.fill,
                    ) // Provide a default asset path
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 50.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2.w,
                          color: Colors.white,
                        ),
                        color: Colors.green),
                    child: Center(
                      child: IconButton(
                        onPressed: () {

                        },
                        icon: Icon(Icons.edit,color: Colors.white,size: 20.h.w),
                        color: Colors.white,
                      ),
                    ),
                  ))
            ]),
          ),
          const Gap(15),
          Container(height: 150,width: 380,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20),),child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text("Welcome Message",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16.w,),),
              Text("We are delighted to welcome you to the Teacher Portal.This innovative platform is designed to streamline your teaching experience, providing you with tools and resources to enhance your classroom interactions and contribute to the academic success of our students.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 13.w,),)
            ],
          ),),
          Gap(30.h),

         const homebutton()


        ],

      ),
    );
  }
}
