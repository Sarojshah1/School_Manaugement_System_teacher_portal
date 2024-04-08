part of 'homework_bloc.dart';

sealed class HomeworkEvent extends Equatable {
  const HomeworkEvent();

  @override
  List<Object> get props => [];
}
class AddAssignment extends HomeworkEvent {
  final Assignment assignment;

  AddAssignment(this.assignment);
  @override
  List<Object> get props => [assignment];

}
