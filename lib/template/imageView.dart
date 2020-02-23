import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String img;
  const ImageViewer({@required this.img});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onDoubleTap: (){
      
        Navigator.pop(context);
      },child:Stack(children: <Widget>[ 
       
      Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Text(''),
      ),
      Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(image: DecorationImage(image: FileImage(File(img)),fit: BoxFit.cover)),
    )
    ],),);
  }
}