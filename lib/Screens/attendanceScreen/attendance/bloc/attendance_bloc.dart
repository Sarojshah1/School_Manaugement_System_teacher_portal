import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../model/AttendanceModel.dart';
import '../AttendanceService.dart';// Adjust the path as per your project structure

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceService attendanceService;

  AttendanceBloc({required this.attendanceService}) : super(AttendanceInitial())
  { on<AddAttendanceEvent>(_onAddAttendanceEvent);}
  void _onAddAttendanceEvent(AddAttendanceEvent event, Emitter<AttendanceState> emit) async {
    emit(AttendanceInitial());

    try {
      await attendanceService.addAttendance(event.attendances);
      emit(AttendanceSuccess());
    } catch (error) {
      emit(AttendanceFailure());
    }
  }

}