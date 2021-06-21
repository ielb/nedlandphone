
import 'package:nedlandphone/Services/socket_service.dart';
import 'package:nedlandphone/models/Conversation.dart';
import 'package:nedlandphone/providers/auth_provider.dart';
import 'package:toast/toast.dart';
import '../providers/conversation_provider.dart';
import 'Search.dart';
import '../config/Constants.dart';
import 'widgets/Conversation_Card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat.dart';



class MainChatRoom extends StatefulWidget {
  MainChatRoom({Key key}) : super(key: key);

  @override
  _MainChatRoomState createState() => _MainChatRoomState();
}

class _MainChatRoomState extends State<MainChatRoom> {
  SocketService socketService ;
  bool isSelected =false;
  var streamKey =Key('chat');
  String _id ;
  AuthProvider user ;
  Future<List<ConversationModel>> future;

  chatRoomsList() {
      return Provider.of<ConversationProvider>(context,listen: false).conversations != null ? FutureBuilder(
        future:future,
        builder :(context,snapshot){
            return snapshot.data != null ? ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context,index){
          return  GestureDetector(
          onLongPress:(){
            ConversationModel conversation= snapshot.data[index];
            setState((){ 
              _id="";
              _id=conversation.id.toString();
              isSelected = true;
            });
            },
            child: ChatTille(
              conversation:snapshot.data[index],
              onTap:()=>  Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => Chat(conversation: snapshot.data[index],socketService: socketService,))) ,
          ),
        );
          },
        ):Center(
          child: Text("Please chat with your friends",style: TextStyle(fontSize: 26,color: Colors.white),),
        );        
        }
      ):Center(
          child: Text("Please chat with your friends",style: TextStyle(fontSize: 26,color: Colors.white),),
        );
        
  }

@override
void initState() { 
  future = Provider.of<ConversationProvider>(context,listen: false).getConversations();
  user = Provider.of<AuthProvider>(context,listen: false); 
  socketService = SocketService();
  socketService.connect(user);
  
  super.initState();
  _id = "";
}

  
  @override
  Widget build(BuildContext context) {
    ConversationProvider provider =  Provider.of<ConversationProvider>(context,listen: false);   
      return SafeArea(
        child: Scaffold(
          backgroundColor: secondColor,
        body:  chatRoomsList(),
        appBar: AppBar(
          automaticallyImplyLeading: false, 
          centerTitle: false,
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          bottomOpacity: 0,
          title: Text('Messages',style:TextStyle(color:textColor,fontSize: 26,fontWeight: FontWeight.w700)),
          actions:isSelected  ?  [
            IconButton(icon: Icon(Icons.cancel_outlined,color: textColor,size: 28,), onPressed:(){setState(() {
              isSelected = false;
            });} ),
            IconButton(icon: Icon(Icons.archive_outlined,color: textColor,size: 28,), onPressed:(){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));}),
            IconButton(icon: Icon(Icons.delete_rounded,color: Colors.red,size: 28,), onPressed:() async{
                      String message = await provider.delete(_id);
                      Toast.show(message.toString(),context);
                      }
                      ), 
                      
            IconButton(icon: Icon(Icons.add_circle_outline,color: textColor,size: 28,), onPressed:(){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SearchPage())); } ),
          ]:[                
            IconButton(icon: Icon(Icons.add_circle_outline,color: textColor,size: 28,), onPressed:(){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));} ),
          ],
          ),
    ),
      );
  }
}


