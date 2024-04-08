import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:teacherportal/Screens/LoginScreen/services/bloc/authentication_bloc.dart';
import 'package:teacherportal/Screens/LoginScreen/services/bloc/authentication_event.dart';
import 'package:teacherportal/Screens/LoginScreen/services/bloc/authentication_state.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Utils/Image_Constant.dart';
import '../homescreen/TeacherHomeScreen.dart';
import 'Widgets/customButton.dart';
import 'Widgets/customTextfield.dart';
import 'otp.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationAuthenticated) {
            //   // Navigate to home screen after successful login
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => TeacherHome()),
            );
            VxToast.show(context, msg: "Logged in to teacher Protel");


          }


        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return LoginForm();
            }
          },
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Gap(70.h),
            Center(child: Image.asset(LoginTop),),
            Gap(50.h),
            CustomTextfield(
                controller: emailcontroller,
                decoration: InputDecoration(hintText: "Username",suffixIcon: const Icon(Icons.person),border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),isDense: true,),ispass: false),
            Gap(40.h),
            CustomTextfield(
                controller: passwordcontroller,
                decoration: InputDecoration(hintText: "password",suffixIcon: const Icon(Icons.password_outlined),border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),isDense: true,),ispass: true),
            Gap(40.h),
            MyButton(ontap: (){
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoginButtonPressed(
                  username: emailcontroller.text,
                  password: passwordcontroller.text,
                ),
              );
            }, height: 50, width: 290,text: "Login",radius: 20,),
            Gap(10.h),
            TextButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context) => SendOTPPage(),));

            }, child: Text("Forget Password?",style: TextStyle(fontSize: 14.w,fontWeight: FontWeight.w500),))
          ],
        ),
      ),
    ) ;
  }
}

