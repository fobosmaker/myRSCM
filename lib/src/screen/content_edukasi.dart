import 'package:myrscm/constant.dart';
import 'package:myrscm/src/screen/page_loading.dart';
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
  const _Example01Tile(Colors.white70, 'assets/edukasi7.jpeg'),
  const _Example01Tile(Colors.white70, 'assets/edukasi8.jpeg'),
  const _Example01Tile(Colors.white70, 'assets/edukasi9.jpeg'),
  const _Example01Tile(Colors.white70, 'assets/edukasi10.jpeg'),
  const _Example01Tile(Colors.white70, 'assets/edukasi11.jpeg'),

  const _Example01Tile(Colors.white70, 'assets/edukasi12.jpeg'),
  const _Example01Tile(Colors.white70, 'assets/edukasi13.jpeg'),
  const _Example01Tile(Colors.white70, 'assets/edukasi4.jpeg'),
  const _Example01Tile(Colors.white70, 'assets/edukasi2.jpeg'),
  const _Example01Tile(Colors.white70, 'assets/edukasi1.jpeg'),

  const _Example01Tile(Colors.white70, 'assets/edukasi14.jpeg'),
  const _Example01Tile(Colors.white70, 'assets/edukasi15.jpeg'),
  const _Example01Tile(Colors.white70, 'assets/edukasi5.jpeg'),
  const _Example01Tile(Colors.white70, 'assets/edukasi3.jpeg'),
  const _Example01Tile(Colors.white70, 'assets/edukasi6.jpeg'),
];

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.backgroundColor, this.imageUrl);

  final Color backgroundColor;
  //final IconData iconData;
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
  MySharedPreferences sp;
  bool isGetPref = false;
  @override
  void initState() {
    sp = MySharedPreferences(context: context);
    sp.getPatientIsLogin().then((isLogin){
      print('initState: $isLogin');
      //if user not login, clear preferences and remove preferences data
      if(!isLogin) sp.clearData();

      //else get preferences done
      setState(() => isGetPref = true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isGetPref == true ?
      Scaffold(
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
    )
      :
      PageLoading()
    ;
  }
}