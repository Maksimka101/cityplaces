import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cityplaces/src/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseRepository {
  FirebaseRepository() {
    getRegisterUser();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  StreamController<User> _userStream = StreamController();
  Stream<User> get userStrem => _userStream.stream;

  void getRegisterUser() async {
    final user = await FirebaseAuth.instance.currentUser();
    if (user != null)
      _userStream.sink.add(User.fromFirebaseUser(user));
    else
      _userStream.sink.add(null);
  }

  void registerUserAnonim() async {
    final user = await _auth.signInAnonymously();
    _userStream.sink.add(User.fromFirebaseUser(user));
  }

  void registerUser() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    _userStream.sink.add(User.fromFirebaseUser(user));
  }

  dispose() {
    _userStream.close();
  }
}
