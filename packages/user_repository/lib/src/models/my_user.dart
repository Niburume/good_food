// ignore_for_file: must_be_immutable
import '../entities/entities.dart';

class MyUser {
	String id;
	String token;
	String email;
	String name;
	String? picture;

	MyUser({
		required this.id,
		required this.token,
		required this.email,
		required this.name,
		this.picture,
	});

	/// Empty user which represents an unauthenticated user.
  static final empty = MyUser(
		id: '', 
		token: '', 
		email: '',
		name: '', 
		picture: ''
	);

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MyUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != MyUser.empty;

	MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      token: token,
      email: email,
      name: name,
      picture: picture,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      token: entity.token,
      email: entity.email,
      name: entity.name,
      picture: entity.picture,
    );
  }

  @override
  String toString() {
    return '''MyUser: {
      id: $id
      token: $token
      email: $email
      name: $name
      picture: $picture
    }''';
  }
		
}
