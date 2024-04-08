
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/Image_Constant.dart';
import 'Services/bloc/profile_bloc.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc _profileBloc;
  @override
  void initState() {
    super.initState();
    _profileBloc = ProfileBloc();
    _profileBloc.add(FetchUserByUsername(AutofillHints.username));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileLoaded) {
              final user = state.teacherProfileModel;
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipOval(
                        child: Image.asset(
                          profilepic,
                          fit: BoxFit.fill,
                        ), // Provide a default asset path
                      ),
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(height: 30.h),
                    _buildText('Full Name', user.fullname),
                    _buildText('Class Teacher', user.className),
                    _buildText('Gender', user.gender),
                    _buildText('Date Of Birth', user.dateofbirth),
                    _buildText('Guardian’s Contact Number', user.phonenumber),
                    _buildText('Address', user.address),
                    _buildText('Role', user.role),
                    _buildText('subject', user.subject),



                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add functionality to edit profile
                        // For example, navigate to an edit profile screen
                      },
                      child: Text('Edit Profile'),
                    ),
                  ],
                ),
              );
            } else if (state is ProfileError) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else {
              return Container(); // Handle other states if needed
            }
          },
        ),
      ),
    );
  }
  Widget _buildText(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20.w,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          value ?? 'N/A',
          style: TextStyle(
            fontSize: 16.w,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}

