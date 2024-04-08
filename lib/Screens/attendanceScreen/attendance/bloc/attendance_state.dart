part of 'attendance_bloc.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();
  
  @override
  List<Object> get props => [];
}

final class AttendanceInitial extends AttendanceState {}
class AttendanceSuccess extends AttendanceState {}

class AttendanceFailure extends AttendanceState {}