import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({ Key? key }) : super(key: key);

  static const route = "/Gallery";

  @override
  Widget build(BuildContext context) {
    List<Image> images = [];
    images.add(Image(image: AssetImage('assets/robot.png'),));
    images.add(Image(image: AssetImage('assets/robot.png'),));  
    return Container(
      child: Wrap(
        children: <Widget>[
          for(var i=0; i < images.length; i++)
            images[i]
        ],
      )
    );
  }
}