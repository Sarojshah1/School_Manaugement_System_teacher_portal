import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teacherportal/singletons/useridSingleton.dart';

import '../../../../model/AssignmentModel.dart';
import '../homeworkrepo.dart';

part 'homework_event.dart';
part 'homework_state.dart';

class HomeworkBloc extends Bloc<HomeworkEvent, HomeworkState> {
  final AssignmentRepository repository;

  HomeworkBloc(this.repository) : super(HomeworkInitial())
  { on<AddAssignment>(_onAddAssignment);}
  void _onAddAssignment(AddAssignment event, Emitter<HomeworkState> emit) async {
    emit(AssignmentLoading());

    try {
      await repository.addAssignment(
        subject: event.assignment.subject,
        teacherId: TeacherIdManager().studentId.toString(),
        title: event.assignment.title,
        description: event.assignment.description,
        dueDate: event.assignment.dueDate,
        className: event.assignment.className,
      );
      emit(AssignmentSuccess());
    } catch (error) {
      emit(AssignmentFailure(error.toString()));
    }
  }


}
