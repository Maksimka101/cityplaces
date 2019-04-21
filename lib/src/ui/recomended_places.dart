import 'package:cityplaces/src/bloc/recomended_places_bloc.dart';
import 'package:cityplaces/src/models/place_card_model.dart';
import 'package:cityplaces/src/ui/place_card.dart';
import 'package:flutter/material.dart';

class FavoritePlacesScreen extends StatefulWidget {
  @override
  _FavoritePlacesScreenState createState() => _FavoritePlacesScreenState();
}

class _FavoritePlacesScreenState extends State<FavoritePlacesScreen> {
  RecomendedPlacesBloc _recomendedPlacesBloc;
  @override
  void initState() {
    _recomendedPlacesBloc = RecomendedPlacesBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PlaceInfo>>(
      stream: _recomendedPlacesBloc.placesStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, id) {
            return RouteCard(
              imageUrl: snapshot.data[id].imagesUrl.first,
              info: snapshot.data[id].description,
              name: snapshot.data[id].name,
              stars: snapshot.data[id].userRating,
            );
          },
        );
      },
    );
  }
}
