import 'package:cityplaces/src/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({@required this.authBloc});
  final AuthBloc authBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: LoginWindow(
        authBloc: authBloc,
      ),
    );
  }
}

class LoginWindow extends StatefulWidget {
  LoginWindow({@required this.authBloc});
  final AuthBloc authBloc;
  @override
  _LoginWindowState createState() => _LoginWindowState();
}

class _LoginWindowState extends State<LoginWindow> {
  AuthBloc _authBloc;
  var _checkPermission = true;

  @override
  void initState() {
    _authBloc = widget.authBloc;
    super.initState();
  }

  void _showDialog(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Разрешение на геолокацию"),
              content: Text(
                  "Геолокация нужна для того, чтобы отображать ваше местоположение."),
              actions: <Widget>[
                FlatButton(
                    child: Text("Не разрешать"),
                    onPressed: () => Navigator.of(context).pop()),
                FlatButton(
                  child: Text("Разрешить"),
                  onPressed: () async {
                    await PermissionHandler()
                        .requestPermissions([PermissionGroup.location]);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    if (_checkPermission) {
      _checkPermission = false;
      _showDialog(context);
    }

    final _appLogo = CircleAvatar(
      radius: 50,
      child: Text(
        "CityPlaces",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
    );

    final _signIn = RaisedButton(
      color: Colors.blue,
      child: Text("Войти через Google"),
      onPressed: () {
        _authBloc.signInWithGoogle();
      },
    );

    final _signInAnonim = RaisedButton(
      color: Colors.grey,
      child: Text("Войти анонимно"),
      onPressed: () {
        _authBloc.signInWithGoogle();
      },
    );

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _appLogo,
          SizedBox(
            height: 100,
          ),
          _signIn,
          _signInAnonim,
        ],
      ),
    );
  }
}
