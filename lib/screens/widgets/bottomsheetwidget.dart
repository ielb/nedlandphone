import 'package:nedlandphone/Services/socket_service.dart';
import 'package:nedlandphone/screens/imageWidget.dart';
import 'package:provider/provider.dart';

import '../../models/Conversation.dart';

import '../../config/Constants.dart';
import '../../providers/conversation_provider.dart';
import '../Files_list.dart';
import 'package:flutter/material.dart';


class BottomSheetWidget extends StatefulWidget {
  final ConversationModel conversation;
  BottomSheetWidget(this.conversation,this.service);
  final SocketService service;
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState(this.conversation,this.service);
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  _BottomSheetWidgetState(this.conversation,this.service);
  ConversationModel conversation ;
  SocketService service;
  @override
  void initState() { 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(conversation.id);
    var prov =Provider.of<ConversationProvider>(context,listen: false);
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 100,top: 5, left: 15, right: 50),
        height: 240,
        width: 80,
        child:  Container(
              height: 200,
              decoration: BoxDecoration(
                  color: firstColor,
                  borderRadius: BorderRadius.circular(15),),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Files()));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 5),
                          height: 60,
                          width: 60,
                            child: Icon(Icons.insert_drive_file,color:Colors.white.withOpacity(0.8),size: 28,),
                          decoration: BoxDecoration(
                            color: Color(0xff00BBF9),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            ),
                      ),
                    ),
                  GestureDetector(
                      onTap: () async {
                          await prov.storePicturesFromCameraToConversation();
                          
                      },child: Container(
                        margin: const EdgeInsets.only(top: 15),
                          height: 60,
                          width: 60,
                            child: Icon(Icons.camera_alt,color:Colors.white.withOpacity(0.8),size: 28,),
                          decoration: BoxDecoration(
                            color: Color(0xffFEE440),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            ),
                      ),
                  ),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ImagesView(service :this.service,conversation:this.conversation)));
                      },
                    child: Container(
                        margin: const EdgeInsets.only(top: 15),
                          height: 60,
                          width: 60,
                          child: Icon(Icons.image,color:Colors.white.withOpacity(0.8),size: 28,),
                          decoration: BoxDecoration(
                            color: Color(0xff9B5DE5),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            ),
                      ),
                  ),
                  
                ],
              ),
        ),
      ),
    );
  }
}