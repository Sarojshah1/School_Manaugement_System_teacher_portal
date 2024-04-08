part of 'result_bloc.dart';

sealed class ResultEvent extends Equatable {
  const ResultEvent();

  @override
  List<Object> get props => [];
}
class AddResult extends ResultEvent {
  final List<Result> result;

  const AddResult(this.result);

  @override
  List<Object> get props => [result];
}