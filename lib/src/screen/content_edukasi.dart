import 'package:myrscm/constant.dart';
import 'package:myrscm/src/screen/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'SelectedImage.dart';

class ContentEdukasiPage extends StatefulWidget {
  @override
  _ContentEdukasiPageState createState() => _ContentEdukasiPageState();
}

List<StaggeredTile> _myStaggeredTiles = const<StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),

  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),

  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),

];

List<Widget> _tiles = const <Widget>[
  const _Example01Tile(Colors.white70, Icons.widgets, 'assets/edukasi7.jpeg'),
  const _Example01Tile(Colors.white70, Icons.wifi, 'assets/edukasi8.jpeg'),
  const _Example01Tile(Colors.white70, Icons.panorama_wide_angle, 'assets/edukasi9.jpeg'),
  const _Example01Tile(Colors.white70, Icons.map, 'assets/edukasi10.jpeg'),
  const _Example01Tile(Colors.white70, Icons.send, 'assets/edukasi11.jpeg'),

  const _Example01Tile(Colors.white70, Icons.airline_seat_flat, 'assets/edukasi12.jpeg'),
  const _Example01Tile(Colors.white70, Icons.bluetooth, 'assets/edukasi13.jpeg'),
  const _Example01Tile(Colors.white70, Icons.battery_alert, 'assets/edukasi4.jpeg'),
  const _Example01Tile(Colors.white70, Icons.desktop_windows, 'assets/edukasi2.jpeg'),
  const _Example01Tile(Colors.white70, Icons.radio, 'assets/edukasi1.jpeg'),

  const _Example01Tile(Colors.white70, Icons.widgets, 'assets/edukasi14.jpeg'),
  const _Example01Tile(Colors.white70, Icons.wifi, 'assets/edukasi15.jpeg'),
  const _Example01Tile(Colors.white70, Icons.panorama_wide_angle, 'assets/edukasi5.jpeg'),
  const _Example01Tile(Colors.white70, Icons.map, 'assets/edukasi3.jpeg'),
  const _Example01Tile(Colors.white70, Icons.send, 'assets/edukasi6.jpeg'),
];

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.backgroundColor, this.iconData, this.imageUrl);

  final Color backgroundColor;
  final IconData iconData;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
          child: Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: backgroundColor,
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.fitWidth
          )
        )
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedImage(imageURL: imageUrl)));
      },
    );
  }
}

class _ContentEdukasiPageState extends State<ContentEdukasiPage> {
  @override
  Widget build(BuildContext context) {

    //check user session
    new MySharedPreferences(context: context).checkBoolean();

    //if user login
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edukasi'),
        backgroundColor: defaultAppbarColor,
      ),
      body:
      new Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: new StaggeredGridView.count(
          crossAxisCount: 4,
          staggeredTiles: _myStaggeredTiles,
          children: _tiles,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          padding: const EdgeInsets.all(4.0),
        )
      )
    );
  }
}