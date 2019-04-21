import 'package:cityplaces/src/bloc/routes_bloc.dart';
import 'package:cityplaces/src/models/place_card_model.dart';
import 'package:cityplaces/src/ui/map_route_screen.dart';
import 'package:flutter/material.dart';

class RouteScreen extends StatefulWidget {
  RouteScreen({
    @required this.routeBloc,
  });
  final RouteBloc routeBloc;
  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  RouteBloc _routeBloc;

  @override
  void initState() {
    _routeBloc = widget.routeBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height-20,
      child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                child: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Text(
              "Маршрут",
              style: TextStyle(fontSize: 25),
            ),
            Divider(
              color: Colors.black26,
            ),
            StreamBuilder<List<PlaceInfo>>(
              stream: _routeBloc.routePlaces,
              builder: (context, placesSnap) {
                if (placesSnap.hasData && placesSnap.data.isNotEmpty)
                  return Container(
                    child: Column(
                      children: placesSnap.data
                          .map((place) => Card(
                            color: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 15),
                                  child: Text(
                                    place.name,
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  );
                else
                  return Container();
              },
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: FlatButton(
                  child: Text("Добавить место"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                  color: Colors.blue,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
                    child: Text(
                      "К маршруту",
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapRouteScreen(
                                  routeBloc: _routeBloc,
                                )));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
