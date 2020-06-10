import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class SelectedImage extends StatelessWidget {

  final String imageURL;

  SelectedImage({this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
          child: PhotoView(
            imageProvider: AssetImage(imageURL),
          )
      ),
    );
  }
}