import 'dart:async';

import 'package:cityplaces/src/models/place_card_model.dart';
import 'package:cityplaces/src/resources/network_repository.dart';

class RecomendedPlacesBloc {
  RecomendedPlacesBloc() {
    _networkRep.places.listen((places) {
      _listenForPlaces(places);
    });
  }

  final _networkRep = NetworkRepository();

  StreamController<List<PlaceInfo>> _placeInfoStream = StreamController();
  Stream<List<PlaceInfo>> get placesStream => _placeInfoStream.stream;

  void _listenForPlaces(List<PlaceInfo> places) {
    _placeInfoStream.sink.add(places);
  }

  void dispose() {
    _placeInfoStream.close();
  }
}