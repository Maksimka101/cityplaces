import 'dart:async';

import 'package:cityplaces/src/bloc/routes_bloc.dart';
import 'package:cityplaces/src/models/place_card_model.dart';
import 'package:cityplaces/src/models/place_type_model.dart';
import 'package:cityplaces/src/resources/network_repository.dart';

class MapBloc {
  MapBloc() {
    // todo sort places on server and add them
    _placesFilterStream.stream.listen((filters) {
      if (filters.isNotEmpty && filters.first != Unknown())
        _network.getFilteredPlaces(types: filters);
      else
        _network.getFilteredPlaces(types: filters);
    });
    // load places
    _network.places
        .listen((places) => _placesStream.sink.add(places));
  }

  final _routeBloc = RouteBloc();
  final _network = NetworkRepository();

  StreamController<List<PlaceInfo>> _placesStream = StreamController();
  Stream<List<PlaceInfo>> get placesStream => _placesStream.stream;

  StreamController<List<PlaceType>> _placesFilterStream =
      StreamController.broadcast();
  StreamSink<List<PlaceType>> get placesFilterStream =>
      _placesFilterStream.sink;
  Stream<List<PlaceType>> get placesFilter => _placesFilterStream.stream;

  RouteBloc get routeBloc => _routeBloc;

  dispose() {
    _placesFilterStream.close();
    _placesStream.close();
    _routeBloc.dispose();
  }
}
