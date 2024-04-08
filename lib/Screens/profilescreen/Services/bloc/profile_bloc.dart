import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teacherportal/singletons/useridSingleton.dart';
import 'package:teacherportal/singletons/usernamesingleton.dart';

import '../../../../model/teacherprofilemodel.dart';
import 'package:http/http.dart' as http;

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()){
    on<FetchUserByUsername>(_fetchUser);
  }

  void _fetchUser(FetchUserByUsername event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final username = UserManager().username;
      final url = Uri.parse('http://192.168.56.1:7000/user/$username');
      final response = await http.get(url);
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> userData = data['user'];
        final teacherProfileModel = TeacherprofileModel.fromJson(userData);
        emit(ProfileLoaded(teacherProfileModel));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      emit(ProfileError(error.toString()));
      print(error);
    }
  }

}
