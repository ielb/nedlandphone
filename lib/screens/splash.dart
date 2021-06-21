import '../config/Constants.dart';
import 'widgets/Widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondColor,
      body:Column(children: [
        SizedBox(height: 80,),
        Widgets.asset( Image.asset('assets/logo/NedLandPhone.png')),
        SizedBox(height: 100,),
        CircularProgressIndicator(),
      ],) ,
    
    );
  }
}