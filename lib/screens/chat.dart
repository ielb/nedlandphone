import 'package:flutter/cupertino.dart';
import 'package:nedlandphone/Services/socket_service.dart';
import 'package:nedlandphone/models/User.dart';
import 'package:nedlandphone/providers/auth_provider.dart';
import '../models/Conversation.dart';
import '../models/Message.dart';
import '../providers/conversation_provider.dart';
import 'ControlPages.dart';
import '../config/Constants.dart';
import 'widgets/Message_card.dart';
import 'widgets/bottomsheetwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';






import 'Search.dart';


class Chat extends StatefulWidget {
  final ConversationModel conversation;
  final SocketService socketService;

  Chat({this.conversation,this.socketService});
 
  @override
  _ChatState createState() => _ChatState(this.conversation,this.socketService);
}

class _ChatState extends State<Chat> {
  _ChatState(this.conversation,this.socketService);
  final ConversationModel conversation;
  final SocketService socketService;
  final bool isEmojiVisible =false;
  final focusNode = FocusNode();
  UserModel user  = UserModel();
  var taped = false;
  MessageModal message ;
  ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected =false;
  ImageProvider placeHolderImage = AssetImage("assets/avatar/avatar.png");
  var isTaping = false;
  TextEditingController messageEditingController = new TextEditingController();
  @override
  void initState(){
    super.initState();
    getuser(); 
    //socketService.connect(Provider.of<AuthProvider>(context,listen: false));
    gettingMessages();
   
    message = new MessageModal();
    message.userId =  Provider.of<AuthProvider>(context,listen: false).user.uid;
    message.conversationId = conversation.id.toString();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }  


  void getuser()async{
    user =  await Provider.of<ConversationProvider>(context,listen: false).getUserfromConversation(this.conversation.user.uid); 
  }

  

gettingMessages(){
  this.socketService.recievingMessages(
    (data){
      print(data);
      MessageModal message = MessageModal.fromJson(data);
      addingMessages(message);
    }
  );
}


addingMessages(message){
  if(conversation.id == message.conversationId ){
      bool result = widget.conversation.messages.contains(message);
      if(!result)
      {
        setState(() {
          conversation.messages.add(message);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
        });      
      }
      }
}




  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context,listen: false);
    var prov =Provider.of<ConversationProvider>(context,listen: false);
    
    return SafeArea(
          child: Scaffold(
            key:scaffoldKey ,
            backgroundColor: secondColor,
            appBar: AppBar(
              elevation: 0.1,
              leading: IconButton(icon: Icon(!isSelected?Icons.arrow_back_rounded:Icons.cancel_sharp), onPressed: (){
                if(isSelected){
                  setState(() {
                    
                    isSelected = false;
                  });
                }else{
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => ControlPages(0)));
                }

              }),
              title: Row(
              children: [
                GestureDetector( 
                    onTap: (){},
                    child:  CircleAvatar(
                    maxRadius: 20,
                    backgroundImage:conversation.user.imageUrl != null ? NetworkImage(conversation.user.imageUrl): placeHolderImage,   
                )
              ),
                SizedBox(width:15),
                RichText(text:   conversation.user.isOnline == 1 ? TextSpan(
                  text :conversation.user.uid.toString(),
                  style: TextStyle(color:textColor,fontSize:18),
                  children: [
                    TextSpan(text: '\nonline ',  style: TextStyle(color:textColor,fontSize:13),) ,
                  ]
                ) :TextSpan(text: conversation.user.fullName.toString(),style: TextStyle(color:textColor,fontSize:20),)
                ,),
              ],
            ),
            actions: isSelected  ?  [
            IconButton(icon: Icon(Icons.delete_rounded,color: Colors.red,size: 28,), onPressed:(){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));}), 
            IconButton(icon: Icon(Icons.copy_outlined,color: Colors.white,size: 28,), onPressed:(){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));}), 
            SizedBox(width: 20)
          ]:[                
            
          ],
              backgroundColor: firstColor,
              ),
        body: Container(
          child: Column(
            children:<Widget> [
              
                Expanded(child:
                ListView.builder(
                  shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: conversation.messages.length+1,
                      itemBuilder: (context, index) {
                        if(index == conversation.messages.length){
                          return Container(
                            height: 70,
                          );
                        }
                        return conversation.messages[index].userId.toString() == provider.user.uid ?
                        GestureDetector(
                          onLongPress: (){
                            setState(() {
                            isSelected= true;
                            });
                          },
                          child: MessageTile(
                            message:  conversation.messages[index] ?? '',
                          ),
                        ) : FriendMessageTile(
                            func: (){
                            setState(() {
                            isSelected= true;
                            });
                            } ,
                            message:  conversation.messages[index] ?? '',
                        );



                      }
                        ),
                ),
              Container(
                padding: EdgeInsets.symmetric(horizontal:15, vertical: 20),
                alignment: Alignment.bottomCenter,
                width: 500,
                child: Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal:15, vertical: 10),
                  
                  decoration:BoxDecoration(
                    color: firstColor,
                    borderRadius:BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {      
                        prov.storePicturesToConversation();
                        },
                        //sendig Emojies
                        child:   Icon(Icons.emoji_emotions_outlined,color: mainColor) , 
                        ),
                      SizedBox(width: 16,),
                      Expanded(
                        child: TextField(     
                          textInputAction: TextInputAction.newline,
                          onTap: (){ 
                            _scrollController.position.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 800),
                              curve: Curves.ease,
                            );
                              setState(() {
                              
                                    isTaping = true;
                                });
                            },
                        focusNode: focusNode ,
                          controller: messageEditingController,
                          onSubmitted: (v){
                            setState(() {
                              messageEditingController.text= v.toString().trim();
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                          },
                          style: TextStyle(color: textColor),
                          decoration:  InputDecoration.collapsed(
                                hintText: "Message ...",
                                hintStyle: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none
                            ),
                          
                      ),
                          ),
                      SizedBox(width: 16,),
                      IconButton(icon: Icon(Icons.attach_file),onPressed: (){
                        scaffoldKey.currentState
                        .showBottomSheet(
                          (context) => new  BottomSheetWidget(this.conversation),elevation: 0,backgroundColor:Colors.transparent,);
                      },color: mainColor,),
                      IconButton(
                        icon: Icon(Icons.send,color: mainColor),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                            if (messageEditingController.text.isEmpty) return;
                              var body =messageEditingController.text.trim();
                              messageEditingController.clear();
                              message.body = body;
                              body = '';
                              message.userId = provider.user.uid;
                              message.createdAt = DateTime.now().toString();
                              message.updatedAt =DateTime.now().toString();
                              message.read=0;
                              _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 800),
                              curve: Curves.ease,
                            );
                            
                          setState(() {
                            prov.storeMessage(message);
                            prov.addMessageToConversation(message);
                            widget.socketService.sendMessage(message, user);
                            messageEditingController.clear();
                            isTaping = false ;
                          }
                                  );
                                }
                      ) 
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void onClickedEmoji() async {
    if (isEmojiVisible) {
      focusNode.requestFocus();
    } else if (isTaping) {
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await Future.delayed(Duration(milliseconds: 100));
    }
   // onBlurred();
  }


}




// ignore: non_constant_identifier_names


