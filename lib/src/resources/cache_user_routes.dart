import 'package:cityplaces/src/models/place_card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheUserRoutes {
  static const ROUTES_ID = "routesId";
  static const IS_ROUTE_STARTED = "isRouteStarted";

  static Future<List<PlaceInfo>> get userRoutes async {
    final sp = await SharedPreferences.getInstance();
    final places = <PlaceInfo>[];
    if (sp.getStringList(ROUTES_ID) != null &&
        sp.getStringList(ROUTES_ID).isNotEmpty)
      for (final placeId in sp.getStringList(ROUTES_ID)) {
        if (sp.getString(placeId) != null)
          places.add(PlaceInfo.fromJson(sp.getString(placeId)));
      }
    return places;
  }

  static Future<void> addUserRoute(PlaceInfo place) =>
      SharedPreferences.getInstance().then((sp) {
        var _routesId = sp.getStringList(ROUTES_ID);
        if (_routesId == null) {
          _routesId = <String>[];
        } else if (!_routesId.contains(place.id)) {
          _routesId.add(place.id);
        }
        sp.setString(place.id, place.toJson);
        sp.setStringList(ROUTES_ID, _routesId);
      });

  static void rewriteRoute(List<PlaceInfo> route) async {
    final sp = await SharedPreferences.getInstance();
    sp.setStringList(ROUTES_ID, route.map((place) => place.id).toList());
    for (final place in route) {
      sp.setString(place.id, place.toJson);
    }
  }

  static set isRouteStarted(bool isStarted) => SharedPreferences.getInstance()
      .then((sp) => sp.setBool(IS_ROUTE_STARTED, isStarted));

  static Future<bool> get isRouteStarted async {
    final sp = await SharedPreferences.getInstance();
    final isStarted = sp.getBool(IS_ROUTE_STARTED);
    if (isStarted == null || !isStarted)
      return false;
    else
      return true;
  }

  static void removeAllRoutes() async {
    final sp = await SharedPreferences.getInstance();
    sp.setStringList(ROUTES_ID, []);
  }
}
