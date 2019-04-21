import 'dart:async';

import 'package:cityplaces/src/models/place_card_model.dart';
import 'package:cityplaces/src/resources/cache_user_routes.dart';
import 'package:cityplaces/src/resources/network_repository.dart';

class RouteBloc {
  RouteBloc() {
    CacheUserRoutes.isRouteStarted.then((isStarted) {
      isRouteStarted = isStarted;
    });
    CacheUserRoutes.userRoutes.then((route) {
      _route = route;
      _routePlaces.sink.add(_route);
    });
  }

  var _route = <PlaceInfo>[];
  bool isRouteStarted;

  StreamController<List<PlaceInfo>> _routePlaces =
      StreamController<List<PlaceInfo>>.broadcast();
  Stream<List<PlaceInfo>> get routePlaces {
    Future.delayed(Duration(milliseconds: 200))
        .then((_) => _routePlaces.sink.add(_route));

    return _routePlaces.stream;
  }

  StreamController<bool> _isRouteStartedStream = StreamController();
  Stream<bool> get isRouteStartedStream => _isRouteStartedStream.stream;

  set newPlace(PlaceInfo place) {
    if (!_route.map((place) => place.id).toList().contains(place.id)) {
      CacheUserRoutes.addUserRoute(place).then((_) {});
      _route.add(place);
      _routePlaces.sink.add(_route);
      // NetworkRepository().sendRouteAndGetThem(_route).then((route) {
      //   _route = _sortById(_route, route);
      //   print(route);
      //   CacheUserRoutes.rewriteRoute(_route);
      // _routePlaces.sink.add(_route);
      // });
    }
  }

  List<PlaceInfo> _sortById(List<PlaceInfo> places, List<String> ids) {
    final sorted = <PlaceInfo>[];
    for (final id in ids) {
      for (final place in places) {
        if (place.id == id) {
          sorted.add(place);
          break;
        }
      }
    }
    return sorted;
  }

  void deliteRoute() {
    _route.clear();
    CacheUserRoutes.removeAllRoutes();
  }
  void dispose() {
    // _routePlaces.close();
    // _isRouteStartedStream.close();
  }
}
