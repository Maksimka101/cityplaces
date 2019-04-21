import 'package:firebase_auth/firebase_auth.dart';

class User {
  User({
    String userName,
    String userId,
  }) {
    User.userId = userId;
    User.userName = userName;
  }

  static String userName;
  static String userId;

  static User fromFirebaseUser(FirebaseUser user) =>
      User(userId: user.uid, userName: user.displayName);
}
