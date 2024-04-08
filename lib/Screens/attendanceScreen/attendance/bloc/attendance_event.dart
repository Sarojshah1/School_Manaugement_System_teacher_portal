part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}
class AddAttendanceEvent extends AttendanceEvent {
  final List<Attendance> attendances;

  AddAttendanceEvent(this.attendances);
  @override
  List<Object> get props => [attendances];

}
