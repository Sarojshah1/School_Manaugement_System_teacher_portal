import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:teacherportal/Screens/LoginScreen/LoginScreen.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Utils/Image_Constant.dart';
import 'Widgets/customButton.dart';
import 'Widgets/customTextfield.dart';
import 'changepassword.dart';

class VerifyOTPPage extends StatefulWidget {
  final String phoneNumber;
  final String username;

  VerifyOTPPage({required this.phoneNumber,required this.username});

  @override
  _VerifyOTPPageState createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> checkOTP(String otp) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Make API call to check OTP
      final response = await http.post(
        Uri.parse('http://192.168.56.1:7000/verify'),
        body: {
          'email': widget.phoneNumber,
          'otp': otp,
        },
      );
      if (response.statusCode == 200) {
        VxToast.show(context, msg: "otp verified");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChangePasswordScreen(username: widget.username,)),
        );
      } else {
        // OTP verification failed, display error message
        setState(() {
          _errorMessage = 'Invalid OTP. Please try again.';
        });
      }
    } catch (error) {
      print('Error verifying OTP: $error');
      setState(() {
        _errorMessage = 'Failed to verify OTP. Please try again later.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(40.h),
              Center(child: Image.asset(LoginTop),),
              Gap(50.h),
              CustomTextfield(
                  controller: _otpController,
                  decoration: InputDecoration(hintText: "OTP",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),isDense: true,),ispass: false),
              SizedBox(height: 20.0),
              MyButton(ontap: () {
                String otp = _otpController.text;
                checkOTP(otp);
              }, height: 20, width: 150,text: "Verify OTP"),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}