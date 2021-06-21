

import '../../models/Conversation.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatTille extends StatelessWidget {
  final ConversationModel conversation;
  final Function onTap;
  const ChatTille({this.conversation,this.onTap});
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: onTap,         
          child: Align(alignment: Alignment.center,
          child: Container(
          key: key,
          margin:  EdgeInsets.only(top: 10.0, bottom: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 15, ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          
            ),
            child:  Center(
              child: Row(
                children: [
            GestureDetector( 
                    onTap: (){},
                    child: Stack(
                      children:[ CircleAvatar(
                        child: conversation.user !=null ? conversation.user.isOnline == 1 ? Align(alignment : Alignment.bottomRight,
                        child: Container(height: 10,width: 10,decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(25)
                        ) ) ,
                        // ignore: dead_code
                        ) : Container() : Container(),
                      maxRadius: 25,
                    backgroundImage: conversation.user!= null ? conversation.user.imageUrl !=null ? NetworkImage( conversation.user.imageUrl) :AssetImage("assets/avatar/avatar.png") : AssetImage("assets/avatar/avatar.png"), 
                
              ),
              ]
                    )),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text( conversation.user == null ?  '' : conversation.user.fullName,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'OverpassRegular',
                          fontWeight: FontWeight.w300)),
                          SizedBox(height:5),
                    Text(conversation.messages.isNotEmpty  ? "${conversation.messages.last.body ?? ''}" :"No messages yet",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'OverpassRegular',
                            fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              Spacer(),
              Text(conversation.messages.isNotEmpty ?'${timeago.format(DateTime.parse(conversation.messages.last.createdAt))}' : '${timeago.format(conversation.createdAt)}',style: TextStyle(color:Colors.white,fontSize: 14)
              )
          ],
          ),
          ),
        ),
        ),
    );
  }
}