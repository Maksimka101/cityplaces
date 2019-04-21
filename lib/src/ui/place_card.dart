import 'package:flutter/material.dart';

class RouteCard extends StatelessWidget {
  
  final String name;
  final String info;
  final int stars;
  final String imageUrl;

  RouteCard({
    this.imageUrl,
    this.info,
    this.name,
    this.stars,
  });

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

  @override
  Widget build(BuildContext context) {
    return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    imageUrl,
                    height: MediaQuery.of(context).size.width * 0.60,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                    child: Text(
                      name,
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Row(
                      children: <Widget>[
                        _getStars(stars),
                        Text(
                          "   " + stars.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      info,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
  }
}