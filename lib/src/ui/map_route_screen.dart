import 'package:cityplaces/src/bloc/routes_bloc.dart';
import 'package:cityplaces/src/models/place_card_model.dart';
import 'package:cityplaces/src/ui/place_info_buttom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRouteScreen extends StatefulWidget {
  MapRouteScreen({@required this.routeBloc});
  final RouteBloc routeBloc;
  @override
  _MapRouteScreenState createState() => _MapRouteScreenState();
}

class _MapRouteScreenState extends State<MapRouteScreen> {
  final _initCamersPosition = CameraPosition(
    target: LatLng(56.327375, 44.004472),
    zoom: 11,
  );

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  RouteBloc _routeBloc;

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
  void initState() {
    _routeBloc = widget.routeBloc;
    super.initState();
  }

  Polyline _makePolyline(List<PlaceInfo> places) {
    final polLine = Polyline(
      polylineId: PolylineId("polylineId"),
      color: Colors.yellow,
      points: places != null
          ? places.map((place) => LatLng(place.lat, place.long)).toList()
          : null,
    );
    return polLine;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          StreamBuilder<List<PlaceInfo>>(
            stream: _routeBloc.routePlaces,
            builder: (context, markersSnapshot) {
              var markers = <Marker>{};
              if (markersSnapshot.hasData) {
                markers = placeInfoToMarker(markersSnapshot.data);
              }
              return GoogleMap(
                initialCameraPosition: _initCamersPosition,
                markers: markers,
                polylines: {_makePolyline(markersSnapshot.data)},
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                icon: Icon(Icons.stop),
                label: Text("Закончить маршрут"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _routeBloc.deliteRoute();
                },
                heroTag: "",
              ),
            ),
          )
        ],
      ),
      key: _scaffoldKey,
    );
  }

  @override
  void dispose() {
    _routeBloc.dispose();
    super.dispose();
  }
}
