import 'dart:async';

enum Screen {
  MapScreen,
  MainScreen,
}

class DrawerBloc {
  DrawerBloc();

  StreamController<Screen> _screenStream = StreamController();
  Stream<Screen> get screenStream => _screenStream.stream;
  StreamSink<Screen> get changeScreenStrem => _screenStream.sink;

  dispose() {
    _screenStream.close();
  }
}