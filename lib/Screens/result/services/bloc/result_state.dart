part of 'result_bloc.dart';

sealed class ResultState extends Equatable {
  const ResultState();
  
  @override
  List<Object> get props => [];
}
class ResultInitial extends ResultState {}
class ResultLoading extends ResultState {}
class Resultloaded extends ResultState {
}
class Resultfailure extends ResultState {
}
