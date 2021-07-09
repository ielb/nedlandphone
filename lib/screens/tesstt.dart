import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nedlandphone/config/Config.dart';

class Testt extends StatefulWidget {
  const Testt({ Key key }) : super(key: key);

  @override
  _TesttState createState() => _TesttState();
}

class _TesttState extends State<Testt> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
            children:[
              Container(
          padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
              left:  24,
              right: 0),
          alignment:  Alignment.centerLeft,
          child: Container(
            width: Config.getWidth(context)/2,
            margin:  EdgeInsets.only(right: 30),
            padding: EdgeInsets.only(
                top: 17, bottom: 17, left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: 
                BorderRadius.only(
            topLeft: Radius.circular(25),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20)),
                  color: Color(0xffE9F8FD),          
            ),
            child: Image.network("https://images.unsplash.com/photo-1624349083058-b58c504954d9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80")
          ),
        ),
        Align(alignment:  Alignment.centerLeft, child: Padding(
          padding:EdgeInsets.only(
              top: 0,
              bottom:0,
              left:  24,
              right: 0),
          child: Text(DateTime.now().toString().substring(10,16),style: TextStyle( color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w400),),
        ))
        ]
      ),
    );
  }
}