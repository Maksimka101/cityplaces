import 'dart:async';
import 'package:cityplaces/src/models/place_type_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cityplaces/src/models/place_card_model.dart';

class NetworkRepository {
  NetworkRepository() {
    _loadPlaces().then((places) => _placesStream.sink.add(places));
  }

  StreamController<List<PlaceInfo>> _placesStream = StreamController();
  Stream<List<PlaceInfo>> get places => _placesStream.stream;

  void getFilteredPlaces({List<PlaceType> types}) => _loadPlaces(types: types)
      .then((places) => _placesStream.sink.add(places));

  Future<List<PlaceInfo>> _loadPlaces({List<PlaceType> types}) async {
    var filters = "";
    if (types != null) {
      filters += "?tags=";
      for (final type in types) {
        if (!type.isPrice) {
          if (type.toRequest != "") filters += type.toRequest + ";";
        }
      }
      if (filters == "?tags=") filters = "?";
      for (final type in types) {
        if (type.isPrice) {
          filters += "&priceUpTo=" + type.toRequest;
        }
      }
    }
    print(filters);
    final response = await http.get("http://35.187.0.44:8080/places" + filters);
    return _placeInfoListFromDynamic(jsonDecode(response.body));
  }

  List<PlaceInfo> _placeInfoListFromDynamic(List<dynamic> places) {
    final _places = <PlaceInfo>[];
    for (final place in places) {
      _places.add(PlaceInfo.fromMap(place));
    }
    return _places;
  }

  Future<List<String>> sendRouteAndGetThem(List<PlaceInfo> route) async {
    var ids = '?palaceIds=';
    route.forEach((place) => ids += place.id + ';');
    final request =
        await http.post("http://35.187.0.44:8080/customRoute" + ids);
        print(jsonDecode(request.body)["palaceIds"]);
    return jsonDecode(request.body)["palaceIds"]
        .map((id) => id.toString())
        .toList();
  }

  void dispose() {
    _placesStream.close();
  }
}
