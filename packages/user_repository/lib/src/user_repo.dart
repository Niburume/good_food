import '../user_repository.dart';

abstract class UserRepository {

	Stream<MyUser?> get user;

	Future<MyUser> signUp(MyUser myUser, String password);

	Future<void> setUserData(MyUser user);

	Future<void> signIn(String email, String password);

	Future<void> logOut();

	Future<void> resetPassword(String email);

	Future<MyUser> getMyUser(String myUserId);

	Future<String> uploadPicture(String file, String userId);

	Future<void> deleteUser(MyUser myUser);
	
	Future<void> deleteUserPicture(MyUser user);

}
