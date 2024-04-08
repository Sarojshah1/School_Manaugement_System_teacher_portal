part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final TeacherprofileModel teacherProfileModel;

  ProfileLoaded(this.teacherProfileModel);

  @override
  List<Object> get props => [teacherProfileModel];
}

class ProfileError extends ProfileState {
  final String errorMessage;

  ProfileError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
