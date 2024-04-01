part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

/// [AuthenticationUserChanged] handles the change of current user.
/// 
/// It takes a [MyUser] property.
class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user);

  final MyUser? user;
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}