import 'dart:async';
import 'package:cityplaces/src/models/user.dart';
import 'package:cityplaces/src/resources/firebase_repository.dart';

enum BlocEvent {
  Login,
  LogginedIn,
  AcceptPermissins,
  LogOut,
  LoginAnonim,
}

class AuthBloc {
  AuthBloc() {
    _listenForUser();
  }

  final _firebase = FirebaseRepository();

  StreamController<BlocEvent> _authEvents = StreamController();
  Stream<BlocEvent> get authEventStream => _authEvents.stream;

  void _listenForUser() => _firebase.userStrem.listen((User user) {
    if (user != null) {
      _authEvents.sink.add(BlocEvent.LogginedIn);
    }
    else if (user == null) {
      _authEvents.sink.add(BlocEvent.Login);
    }
  });

  void signInWithGoogle() {
    _firebase.registerUser();
  }

  void signInAnonim() {
    _firebase.registerUserAnonim();
  }

  dispose() {
    _authEvents.close();
  }
}
