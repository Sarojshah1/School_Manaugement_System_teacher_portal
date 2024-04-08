part of 'homework_bloc.dart';

sealed class HomeworkState extends Equatable {
  const HomeworkState();
  
  @override
  List<Object> get props => [];
}

class HomeworkInitial extends HomeworkState {}
class AssignmentLoading extends HomeworkState {}
class AssignmentSuccess extends HomeworkState {}
class AssignmentFailure extends HomeworkState {
  final String errorMessage;

  AssignmentFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
