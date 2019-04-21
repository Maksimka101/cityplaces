import 'package:cityplaces/src/bloc/map_bloc.dart';
import 'package:cityplaces/src/models/place_type_model.dart';
import 'package:flutter/material.dart';

class FiltersButtomSheets extends StatefulWidget {
  FiltersButtomSheets({@required this.mapBloc});
  final MapBloc mapBloc;
  @override
  _FiltersButtomSheetsState createState() => _FiltersButtomSheetsState();
}

class _FiltersButtomSheetsState extends State<FiltersButtomSheets> {
  bool _isFullScreen = false;
  final _filters = <PlaceType>[Unknown()];
  final _priceFilters = <PlaceType>[
    OneThousand(),
    TwoThousand(),
  ];
  final _placeFilters = <PlaceType>[
    Caffe(),
    Tours(),
    Pub(),
    CultureObject(),
    Church(),
    Museum(),
    Parks(),
  ];
  MapBloc _mapBloc;

  Widget _buildSlim() => SizedBox(
      key: Key(""),
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        child: Icon(Icons.arrow_drop_up),
        onPressed: () => setState(() => _isFullScreen = true),
      ));

  Widget _buildFullScreen() => Column(
        key: Key(""),
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: FlatButton(
              child: Icon(Icons.arrow_downward),
              onPressed: () => setState(() => _isFullScreen = false),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Фильтры мест",
              style: TextStyle(
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 105,
            child: StreamBuilder<List<PlaceType>>(
              stream: _mapBloc.placesFilter,
              builder: (context, placeTypeSnap) {
                if (placeTypeSnap.hasData) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: ListView.builder(
                          itemCount: _placeFilters.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, id) {
                            while (id >= _placeFilters.length)
                              id -= _placeFilters.length;
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: RaisedButton(
                                textColor: Colors.white,
                                child: Text(_placeFilters[id].toString()),
                                color: placeTypeSnap.data
                                        .contains(_placeFilters[id])
                                    ? Colors.blue
                                    : Colors.grey,
                                onPressed: () {
                                  !placeTypeSnap.data
                                          .contains(_placeFilters[id])
                                      ? _filters.add(_placeFilters[id])
                                      : _filters.remove(_placeFilters[id]);
                                  _mapBloc.placesFilterStream.add(_filters);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 55,
                        child: ListView.builder(
                          itemCount: _priceFilters.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, id) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: RaisedButton(
                                textColor: Colors.white,
                                child: Text(_priceFilters[id].toString()),
                                color: placeTypeSnap.data
                                        .contains(_priceFilters[id])
                                    ? Colors.blue
                                    : Colors.grey,
                                onPressed: () {
                                  _filters.removeWhere((placeType) =>
                                      (placeType != _priceFilters[id] && placeType.isPrice));
                                  !placeTypeSnap.data
                                          .contains(_priceFilters[id])
                                      ? _filters.add(_priceFilters[id])
                                      : _filters.remove(_priceFilters[id]);
                                  _mapBloc.placesFilterStream.add(_filters);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  _mapBloc.placesFilterStream.add(_filters);
                  return Container();
                }
              },
            ),
          ),
        ],
      );

  @override
  void initState() {
    _mapBloc = widget.mapBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // build mini sheets
    return !_isFullScreen ? _buildSlim() : _buildFullScreen();
  }
}
