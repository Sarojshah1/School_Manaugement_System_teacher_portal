part of 'routine_bloc.dart';

sealed class RoutineState extends Equatable {
  const RoutineState();
  
  @override
  List<Object> get props => [];
}

class RoutineInitial extends RoutineState {}

class RoutineLoading extends RoutineState {}

class RoutineLoaded extends RoutineState {
  final List<Routine> routines;

  RoutineLoaded(this.routines);

  @override
  List<Object> get props => [routines];
}

class RoutineError extends RoutineState {
  final String message;

  RoutineError(this.message);

  @override
  List<Object> get props => [message];
}