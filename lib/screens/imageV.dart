
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nedlandphone/Services/socket_service.dart';
import 'package:nedlandphone/config/Config.dart';
import 'package:nedlandphone/config/Constants.dart';
import 'package:nedlandphone/models/Conversation.dart';
import 'package:nedlandphone/models/Message.dart';
import 'package:nedlandphone/providers/auth_provider.dart';
import 'package:nedlandphone/providers/conversation_provider.dart';
import 'package:nedlandphone/screens/chat.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class ImageV extends StatefulWidget {
  ImageV({this.data,this.service,this.conversation});
  final SocketService service ;
  final Uint8List data;
  final ConversationModel conversation;
  @override
  _ImageVState createState() => _ImageVState();
}

class _ImageVState extends State<ImageV> {

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context,listen: false);
    var conversationP = Provider.of<ConversationProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:secondColor,
        title: Container(margin: EdgeInsets.fromLTRB(30, 0, 0, 0),child:Text("Send to ${widget.conversation.user.fullName}",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w400),)),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
        height: 70,
        width: 70,
        decoration: BoxDecoration(color: firstColor,borderRadius: BorderRadius.circular(35)),
        child: IconButton(onPressed: (){
          MessageModal message = MessageModal();
          message.createdAt= DateTime.now().toString();
          message.isImage=1;
          message.userId = auth.user.uid;
          message.body = Config.deConvert(widget.data);
          message.conversationId=widget.conversation.id;
          if(mounted){
              setState(() { 
                  conversationP.addMessageToConversation(message);
                  conversationP.storeMessage(message);
                });
          }

          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Chat(conversation: widget.conversation,socketService: widget.service,)));
        },icon: Icon(Icons.send),)
      ),
      backgroundColor: secondColor ,
      body: SafeArea(
        child: Container(
          color: secondColor,
          height: Config.getHeight(context),
          width: Config.getWidth(context),
          child: Container(child: PhotoView(imageProvider: MemoryImage(widget.data),filterQuality: FilterQuality.high,))
        ),
      ),
    );
  }
}