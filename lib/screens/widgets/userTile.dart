import 'package:nedlandphone/providers/auth_provider.dart';

import '../../config/Constants.dart';
import '../../models/FriendModel.dart';
import '../../providers/conversation_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../chat.dart';

class UserTille extends StatelessWidget {
  UserTille(this.user);
  final   FriendModel user;

  @override
  Widget build(BuildContext context) {
    return  user != null ? Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
            GestureDetector( 
                    onTap: (){},
                    child: Stack(
                      children:[ CircleAvatar(
                      maxRadius: 25,
                    backgroundImage: user.imageUrl != null ? NetworkImage(user.imageUrl):AssetImage("assets/avatar/avatar.png"),
                
              ),
                      ],),),  
          SizedBox(width: 10,),         
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.uid == null? "": user.uid,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 18
                  ),
                ),
                Container(
                    child: Text(
                      user.email == null? "": user.email,
                      style: TextStyle(
                          color:textColor,
                          fontSize: 14
                      ),
                    ),
                  ),
                
              ],
          ),
            
          Spacer(),
          MaterialButton(
            onPressed: ()async{
              Provider.of<AuthProvider>(context,listen: false).addFriend(user.uid);
            var conversation = await Provider.of<ConversationProvider>(context ,listen :false ).createChat(user.uid);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => Chat(conversation:conversation,))); 
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7,vertical: 7),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(24)
              ),
              child: Text("Message",
                style: TextStyle(
                    color: textColor,
                    fontSize: 16
                ),),
            ),
          )
        ],
      ),
    ) : Container();
  }

}