import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Utils/Image_Constant.dart';
import 'LoginScreen/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    changescreen();
  }

  Future<void> changescreen() async {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return LoginScreen();
      }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [
      Positioned(child: Image.asset(top),),
      Center(child: Image.asset(logo),),

      Positioned(child:  Stack(children: [Image.asset(splashbottom),Text("Developed by:Saroj Kumar Sah",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)],alignment: AlignmentDirectional.center,),left: 13,bottom: 0,)
    ],),);
  }
}
