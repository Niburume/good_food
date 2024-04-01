import '../user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseUserRepository implements UserRepository {
	FirebaseUserRepository({
		FirebaseAuth? firebaseAuth,
	})  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

	final FirebaseAuth _firebaseAuth;
	final usersCollection = FirebaseFirestore.instance.collection('users');
	final FirebaseMessaging _fcm = FirebaseMessaging.instance;

	/// Stream of [MyUser] which will emit the current user when
	/// the authentication state changes.
	///
	/// Emits [MyUser.empty] if the user is not authenticated.
  @override
  Stream<MyUser?> get user {
		return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
			if(firebaseUser == null) {
        yield MyUser.empty;
      } else {
        yield await usersCollection
          .doc(firebaseUser.uid)
          .get()
          .then((value) => MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!)));
      }
		});
	}
	
	@override
	Future<MyUser> signUp(MyUser myUser, String password) async {
		try {
			myUser.token = (await _fcm.getToken())!;
			UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
				email: myUser.email,
				password: password
			);
			myUser.id = user.user!.uid;	
			return myUser;
		} catch (e) {
			rethrow;
		}
	}

	@override
	Future<void> setUserData(MyUser user) async {
		try {
			await usersCollection
        .doc(user.id)
        .set(user.toEntity()
        .toDocument());
		} catch(e) {
			rethrow;
		}
	}

	@override
	Future<void> signIn(String email, String password) async {
		try {
			await _firebaseAuth.signInWithEmailAndPassword(
				email: email,
				password: password
			);
		} catch (e) {
			rethrow;
		}
	}

	@override
	Future<void> logOut() async {
		await _firebaseAuth.signOut();
	}

	@override
	Future<void> resetPassword(String email) async {
		try {
			await _firebaseAuth.sendPasswordResetEmail(email: email);
		} catch (e) {
			rethrow;
		}
	}

	@override
  Future<MyUser> getMyUser(String myUserId) async {
    try {
      return usersCollection.doc(myUserId).get().then((value) =>
				MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!))
			);
    } catch (e) {
      rethrow;
    }
  }

	@override
  Future<String> uploadPicture(String file, String userId) async {
    try {
      File imageFile = File(file);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('$userId/PP/${userId}_lead');
      await firebaseStorageRef.putFile(
        imageFile,
      );
      String url = await firebaseStorageRef.getDownloadURL();
      await usersCollection.doc(userId).update({'picture': url});
      String image = await firebaseStorageRef.getDownloadURL();
      return image;
    } catch (e) {
      rethrow;
    }
  }

	@override
	Future<void> deleteUser(MyUser myUser) async {
		try {
			var storageRef = FirebaseStorage.instance.ref();

			var ppRef = storageRef.child("${myUser.id}/PP/");
			await ppRef.listAll().then((result) {
				for (var file in result.items) {
					file.delete();
				}
			}).onError((error, stackTrace) {
				log(error.toString());
			});

			await usersCollection
				.doc(myUser.id)
				.delete();
			await FirebaseAuth.instance.currentUser!.delete();
		} catch (e) {
			log(e.toString());
		  rethrow;
		}
	}

	@override
  Future<void> deleteUserPicture(MyUser user) async {
    try {
      await usersCollection
				.doc(user.id)
				.update({
					'picture': '',
				});
			var storageRef = FirebaseStorage.instance.ref();
			await storageRef.child("${user.id}/PP/${user.id}_lead").delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

}