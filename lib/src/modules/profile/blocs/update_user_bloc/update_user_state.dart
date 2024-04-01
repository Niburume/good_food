part of 'update_user_bloc.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();
  
  @override
  List<Object> get props => [];
}

class UpdateUserInfoInitial extends UpdateUserState {}

class UploadPictureFailure extends UpdateUserState {}
class UploadPictureLoading extends UpdateUserState {}
class UploadPictureSuccess extends UpdateUserState {
	final String userImage;

	const UploadPictureSuccess(this.userImage);

	@override
  List<Object> get props => [userImage];
}

class DeleteUserFailure extends UpdateUserState {}
class DeleteUserLoading extends UpdateUserState {}
class DeleteUserSuccess extends UpdateUserState {}

class DeleteUserPictureFailure extends UpdateUserState {}
class DeleteUserPictureLoading extends UpdateUserState {}
class DeleteUserPictureSuccess extends UpdateUserState {}
