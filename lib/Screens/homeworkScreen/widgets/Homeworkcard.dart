import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HomeworkCard extends StatelessWidget {
  final String subject;
  final String description;
  final String dueDate;

  const HomeworkCard({
    Key? key,
    required this.subject,
    required this.description,
    required this.dueDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Padding(
        padding: EdgeInsets.all(16.0.h.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject,
              style: TextStyle(
                fontSize: 18.h,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10.h),
            Text(
              dueDate,
              style: TextStyle(
                fontSize: 14.h,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}