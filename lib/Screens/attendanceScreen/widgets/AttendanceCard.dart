import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceCard extends StatelessWidget {
  final int totalClasses;
  final int attendedClasses;
  final double attendancePercentage;

  const AttendanceCard({
    Key? key,
    required this.totalClasses,
    required this.attendedClasses,
    required this.attendancePercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Padding(
        padding: EdgeInsets.all(16.0.w.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatTile('Total Classes', totalClasses.toString()),
                _buildStatTile('Attended Classes', attendedClasses.toString()),
                _buildStatTile('Attendance', '${attendancePercentage.toStringAsFixed(2)}%'),
              ],
            ),
            SizedBox(height: 10.h),
            LinearProgressIndicator(
              value: attendancePercentage,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                attendancePercentage >= 80 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.w,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.w,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
