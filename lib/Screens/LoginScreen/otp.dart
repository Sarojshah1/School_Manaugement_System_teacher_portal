import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:teacherportal/Screens/LoginScreen/Widgets/customButton.dart';
import 'package:teacherportal/Screens/LoginScreen/verifyotp.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import '../../Utils/Image_Constant.dart';
import 'Widgets/customTextfield.dart';

class SendOTPPage extends StatefulWidget {
  @override
  _SendOTPPageState createState() => _SendOTPPageState();
}

class _SendOTPPageState extends State<SendOTPPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  List<dynamic> teacher = [];

  Future<void> fetchteacher(String contact) async {
    final response = await http.get(Uri.parse('http://192.168.56.1:7000/Users'));
    final jsonData = jsonDecode(response.body);
    setState(() {
      teacher = jsonData['user'].where((teacher) => teacher['phonenumber'] == contact).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send OTP'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(40.h),
                Center(child: Image.asset(LoginTop),),
                Gap(50.h),
                CustomTextfield(
                controller: _usernameController,
                decoration: InputDecoration(hintText: "Username",suffixIcon: const Icon(Icons.verified_user),border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),isDense: true,),ispass:false,validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },),
                Gap(20.h),
                CustomTextfield(
                controller: _emailController,
                decoration: InputDecoration(hintText: "Email to send OTP",suffixIcon: const Icon(Icons.mail),border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),isDense: true,),ispass:false,validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },),
                Gap(20.h),
                CustomTextfield(
                controller: _phoneController,
                decoration: InputDecoration(hintText: "contact number",suffixIcon: const Icon(Icons.phone),border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),isDense: true,),ispass:false,validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },),
                SizedBox(height: 20.0),
                MyButton(ontap:() async{
                  String contactNumber = _phoneController.text;
                  await fetchteacher(contactNumber);
                  String Email =  _emailController.text;
                  String username =  _usernameController.text;
                  if (teacher.isNotEmpty){
                    print('Sending OTP to $Email');
                    EmailBloc emailBloc = EmailBloc();
                    emailBloc.sendEmail(Email);
                    VxToast.show(context, msg: "OTP send successfully");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOTPPage(phoneNumber: Email,username:username ),));
            
                  }else{
                    VxToast.show(context, msg: "Invalid contact or email");
            
                  }
            

            
                }, height: 20, width: 150,text: "Send otp"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class EmailBloc {
  Future<void> sendEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:7000/otp'),
        body: {
          'email': email,
        },
      );
      if (response.statusCode == 200) {
        print('Email sent successfully');
      } else {
        // Handle error
        print('Failed to send email. Status code: ${response.statusCode}');
        throw 'Failed to send email';
      }
    } catch (error) {
      // Handle error
      print('Error sending email: $error');
      throw error;
    }
  }
}