part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserByUsername extends ProfileEvent {
  final String username;

  FetchUserByUsername(this.username);

  @override
  List<Object> get props => [username];
}
