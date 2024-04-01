import 'package:cloud_firestore/cloud_firestore.dart';

class MyUserEntity {
	final String id;
	final String token;
	final String email;
	final String name;
	final String? picture;

	const MyUserEntity({
		required this.id,
		required this.token,
		required this.email,
		required this.name,
		this.picture,
	});

	Map<String, Object?> toDocument() {
    return {
      'id': id,
			'token': token,
			'email': email,
      'name': name,
      'picture': picture,
    };
  }

	static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
			token: doc['token'] as String,
			email: doc['email'] as String,
      name: doc['name'] as String,
      picture: doc['picture'] as String?
    );
  }

	static MyUserEntity fromSnapshot(DocumentSnapshot<Map<dynamic, dynamic>>  snap) {
    return MyUserEntity(
      id: snap.data()!['id'],
			token: snap.data()!['token'],
			email: snap.data()!['email'],
      name: snap.data()!['name'],
      picture: snap.data()?['picture']
    );
  }

}