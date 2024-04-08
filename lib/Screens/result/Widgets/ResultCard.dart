import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ReportCard extends StatelessWidget {
  final String term;
  final Map<String, String> grades;
  final String comments;

  const ReportCard({
    Key? key,
    required this.grades,
    required this.comments,
    required this.term
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 20.h),
      child: Padding(
        padding: EdgeInsets.all(16.0.w.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          "Exam Report of $term",
          style: TextStyle(
            fontSize: 18.w,
            fontWeight: FontWeight.bold,
          ),),
            SizedBox(height: 10.h),
            Text(
              'Grades',
              style: TextStyle(
                fontSize: 18.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Column(
              children: grades.entries
                  .map((entry) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key),
                  Text(entry.value),
                ],
              ))
                  .toList(),
            ),
            SizedBox(height: 20.h),
            Text(
              'Comments',
              style: TextStyle(
                fontSize: 18.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              comments,
              style: TextStyle(fontSize: 14.w),
            ),
          ],
        ),
      ),
    );
  }
}