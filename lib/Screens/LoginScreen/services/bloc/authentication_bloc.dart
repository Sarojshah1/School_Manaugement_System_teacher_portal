import 'dart:async';
import 'package:bloc/bloc.dart';
// import '../../../Profile/Services/detailssingleton.dart';
import '../auth_services.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService;

  AuthenticationBloc({required this.authService}) : super(AuthenticationInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }
  void _onLoginButtonPressed(LoginButtonPressed event, Emitter<AuthenticationState> emit) async {
    // Handle the LoginButtonPressed event
    // UserManager().setUserName(event.username);
    print("hello from onloginpressed");
    try {
      final token = await authService.login(
        username: event.username,
        password: event.password,
      );
      // print(token);

      if (token.isNotEmpty) {
        emit(AuthenticationAuthenticated(token: token));
        print("empty");
      } else {
        emit(AuthenticationFailure(error: 'Invalid credentials'));
      }
    } catch (error) {
      emit(AuthenticationFailure(error: error.toString()));
    }
  }
}


