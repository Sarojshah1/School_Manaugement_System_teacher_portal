part of 'otp_bloc.dart';

sealed class OtpState extends Equatable {
  const OtpState();
  
  @override
  List<Object> get props => [];
}

final class OtpInitial extends OtpState {}
