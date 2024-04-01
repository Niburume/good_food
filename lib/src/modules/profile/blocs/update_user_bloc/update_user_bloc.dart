import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UserRepository _userRepository;

  UpdateUserBloc({
		required UserRepository userRepository
	}) : 	_userRepository = userRepository, 
	super(UpdateUserInfoInitial()) {
    on<UploadPicture>((event, emit) async {
			emit(UploadPictureLoading());
      try {
				String userImage = await _userRepository.uploadPicture(event.file, event.userId);
        emit(UploadPictureSuccess(userImage));
      } catch (e) {
        emit(UploadPictureFailure());
      }
    });
		on<DeleteUser>((event, emit) async {
			emit(DeleteUserLoading());
      try {
				await _userRepository.deleteUser(event.myUser);
        emit(DeleteUserSuccess());
      } catch (e) {
        emit(DeleteUserFailure());
      }
    });
		on<DeleteUserPicture>((event, emit) async {
			emit(DeleteUserPictureLoading());
      try {
				await _userRepository.deleteUserPicture(event.myUser);
        emit(DeleteUserPictureSuccess());
      } catch (e) {
        emit(DeleteUserPictureFailure());
      }
    });
  }
}
