
import '../../models/Message.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
final MessageModal message;

  MessageTile({@required this.message});


  @override
  Widget build(BuildContext context) {
    return Column(
          children:[ Container(
        padding: EdgeInsets.only(
            top: 8,
            bottom: 8,
            left:  0 ,
            right:  24 ),
        alignment: Alignment.centerRight ,
        child: Container(
          margin:  EdgeInsets.only(left: 30)
              ,
          padding: EdgeInsets.only(
              top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(20)
              ) ,
                color:Color(0xff003F88) , 
          ),
          child: Text(this.message.body,
              textAlign: TextAlign.start,
              style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400)),
        ),
      ),
      Align(alignment:  Alignment.centerRight , child: Padding(
        padding:EdgeInsets.only(
            top: 0,
            bottom:0,
            left: 0 ,
            right: 24 ),
        child: Text(DateTime.parse(this.message.createdAt).toString().substring(10,16),style: TextStyle( color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w400),),
      ))
      ]
    );
  }
}

class FriendMessageTile extends StatelessWidget {
final MessageModal message;
final Function func;

  FriendMessageTile({this.message ,this.func});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: func,
      child: Column(
            children:[
              Container(
          padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
              left:  24,
              right: 0),
          alignment:  Alignment.centerLeft,
          child: Container(
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
            child: Text(this.message.body,
                textAlign: TextAlign.start,
                style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400)),
          ),
        ),
        Align(alignment:  Alignment.centerLeft, child: Padding(
          padding:EdgeInsets.only(
              top: 0,
              bottom:0,
              left:  24,
              right: 0),
          child: Text(DateTime.parse(this.message.createdAt).toString().substring(10,16),style: TextStyle( color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w400),),
        ))
        ]
      ),
    );
  }
}
