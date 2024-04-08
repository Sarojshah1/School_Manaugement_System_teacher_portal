import 'package:equatable/equatable.dart';

class Routine extends Equatable {
  final String day;
  final String time;
  final String className;
  final String subject;
  final String teacherId;

  Routine({
    required this.day,
    required this.time,
    required this.className,
    required this.subject,
    required this.teacherId,
  });

  @override
  List<Object?> get props => [day, time, className, subject, teacherId];

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      day: json['day'],
      time: json['time'],
      className: json['className'],
      subject: json['subject'],
      teacherId: json['teacherId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'time': time,
      'className': className,
      'subject': subject,
      'teacherId': teacherId,
    };
  }
}
