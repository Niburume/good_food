part of 'update_user_bloc.dart';

abstract class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object> get props => [];
}

class UploadPicture extends UpdateUserEvent {
	final String file;
	final String userId;

	const UploadPicture(this.file, this.userId);

	@override
  List<Object> get props => [file, userId];
}

class DeleteUser extends UpdateUserEvent {
	final MyUser myUser;

	const DeleteUser(this.myUser);

	@override
  List<Object> get props => [myUser];
}

class DeleteUserPicture extends UpdateUserEvent {
	final MyUser myUser;

	const DeleteUserPicture(this.myUser);

	@override
  List<Object> get props => [myUser];
}

