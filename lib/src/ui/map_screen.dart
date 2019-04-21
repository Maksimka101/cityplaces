import 'package:cityplaces/src/bloc/map_bloc.dart';
import 'package:cityplaces/src/bloc/routes_bloc.dart';
import 'package:cityplaces/src/models/place_card_model.dart';
import 'package:cityplaces/src/ui/filters_buttom_sheet.dart';
import 'package:cityplaces/src/ui/place_info_buttom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _initCamersPosition = CameraPosition(
    target: LatLng(56.327375, 44.004472),
    zoom: 11,
  );

  MapBloc _mapBloc;
  RouteBloc _routeBloc;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _mapBloc = MapBloc();
    _routeBloc = RouteBloc();
    super.initState();
  }

  Set<Marker> placeInfoToMarker(List<PlaceInfo> places) => places
      .map((place) => Marker(
          markerId: MarkerId(place.name),
          position: LatLng(place.lat, place.long),
          infoWindow: InfoWindow(
            title: place.name,
          ),
          onTap: () => showPlaceInfo(place)))
      .toSet();

  void showPlaceInfo(PlaceInfo place) {
    _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        child: PlaceInfoSheet(
          place: place,
          routeBloc: _routeBloc,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          StreamBuilder<List<PlaceInfo>>(
            stream: _mapBloc.placesStream,
            builder: (context, markersSnap) {
              var markers = <Marker>{};
              if (markersSnap.hasData) {
                markers = placeInfoToMarker(markersSnap.data);
              }
              return Stack(
                children: <Widget>[
                  GoogleMap(
                    initialCameraPosition: _initCamersPosition,
                    markers: markers,
                  ),
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 35, horizontal: 10),
                child: FloatingActionButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              child: FiltersButtomSheets(
                mapBloc: _mapBloc,
              ),
            ),
          ),
        ],
      ),
      key: _scaffoldKey,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
