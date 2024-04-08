import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../model/resultModel.dart';
import '../resultrepo.dart';

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final ResultService resultService;
  ResultBloc(this.resultService) : super(ResultInitial()) {
    { on<AddResult>(_onAddresult);}
  }
  void _onAddresult(AddResult Event, Emitter<ResultState> emit)async{
      emit(ResultLoading());
      try{
        await resultService.addResult(Event.result);
        emit(Resultloaded());

      }catch (error) {
        emit(Resultfailure());
      }
    }
}
