import 'package:cityplaces/src/bloc/routes_bloc.dart';
import 'package:cityplaces/src/models/place_card_model.dart';
import 'package:cityplaces/src/ui/route_screen.dart';
import 'package:flutter/material.dart';

class PlaceInfoSheet extends StatefulWidget {
  PlaceInfoSheet({
    @required this.place,
    @required this.routeBloc,
  });
  final PlaceInfo place;
  final RouteBloc routeBloc;
  @override
  _PlaceInfoSheetState createState() =>
      _PlaceInfoSheetState(place: place, routeBloc: routeBloc);
}

class _PlaceInfoSheetState extends State<PlaceInfoSheet> {
  _PlaceInfoSheetState({
    @required this.place,
    @required this.routeBloc,
  });

  final RouteBloc routeBloc;
  bool _isFullScreen = false;
  bool _showRoutes = false;
  final PlaceInfo place;
  double _height = 200;
  final _duration = Duration(milliseconds: 230);

  Widget _getStars(int starCounts) {
    final _stars = <Widget>[];
    for (int i = 0; i < starCounts; i++)
      _stars.add(Icon(
        Icons.star,
        color: Colors.yellow[600],
        size: 18,
      ));

    for (int i = 0; i < 5 - starCounts; i++)
      _stars.add(Icon(
        Icons.star_border,
        color: Colors.yellow[600],
        size: 18,
      ));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _stars,
    );
  }

  Widget _buildSlim() => Column(
        key: Key(""),
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SizedBox(
              height: 25,
              child: FlatButton(
                child: Icon(Icons.arrow_drop_up),
                onPressed: () => setState(() {
                      _height = MediaQuery.of(context).size.height - 20;
                      _isFullScreen = true;
                    }),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
            child: Text(
              place.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 22, color: Colors.grey[700]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 0, bottom: 10),
            child: _getStars(place.userRating),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
            child: Text(
              place.description,
              style: TextStyle(
                color: Colors.grey,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      );

  Widget _buildFullScreen() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          key: Key(""),
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SizedBox(
                height: 25,
                child: FlatButton(
                  child: Icon(Icons.arrow_drop_down),
                  onPressed: () => setState(() {
                        _height = 200;
                        _isFullScreen = false;
                      }),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
              child: Text(
                place.name,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add, color: Colors.white,),
                    Text("В маршрут", style: TextStyle(color: Colors.white),),
                  ],
                ),
                color: Colors.blue,
                onPressed: () => setState(() {
                      routeBloc.newPlace = place;
                      _showRoutes = true;
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 0, bottom: 10),
              child: _getStars(place.userRating),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // Todo
                  children: (place.imagesUrl)
                      .map((image) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              height: 200,
                              child: Image.network(
                                image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
              child: Text(
                place.description,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    // build mini sheets
    if (!_showRoutes) {
      return AnimatedContainer(
        duration: _duration,
        height: _height,
        child: !_isFullScreen ? _buildSlim() : _buildFullScreen(),
      );
    } else
      return AnimatedContainer(
        height: _height,
        duration: _duration,
        child: RouteScreen(
          routeBloc: routeBloc,
        ),
      );
  }
}
