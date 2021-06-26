


import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nedlandphone/config/Config.dart';
import 'package:nedlandphone/config/Constants.dart';
import 'package:nedlandphone/providers/conversation_provider.dart';
import 'package:provider/provider.dart';
// import 'package:audioplayers/audioplayers.dart';

class TestPage extends StatefulWidget {
  TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {  
  Uint8List file ;
    // AudioPlayer audioPlayer = AudioPlayer();
  final focusNode = FocusNode();
  var isTaping = false;
  var isRecording = false;
  TextEditingController messageEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Config.getHeight(context),
        width: Config.getWidth(context),
        color: secondColor, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 500,
              width: 340,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.indigoAccent[700]),
              child:file!=null ?  Image.memory(file,fit: BoxFit.cover,) : Container(),
            ),
            SizedBox(height: 50,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  height: 60,
                  width: Config.getWidth(context)/1.3,
                  decoration: BoxDecoration(
                    color: firstColor,
                    borderRadius: BorderRadius.all(Radius.circular(26))
                  ),
                  child: Row(
                    children: [                     
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Icon(Icons.emoji_emotions_rounded,color: mainColor,size: 30,)
                      ),
                      Expanded(
                        child: TextField(     
                          textInputAction: TextInputAction.newline,
                          onTap: (){
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
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Icon(Icons.camera_alt_rounded,color: mainColor,size: 26,)
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Icon(Icons.attach_file_rounded,color: mainColor,size: 26,)
                      ),
                    ],
                  ),
                ),
                  GestureDetector(
                    onLongPressStart: (_){
                      print("Start recording ....");
                      setState(() {
                        isRecording = !isRecording;
                      });
                    },
                    onLongPressEnd: (_){
                      setState(() {
                        isRecording = !isRecording;
                      });
                    },
                    onTap: ()async{
                      var provider  = Provider.of<ConversationProvider>(context,listen: false);
                      Uint8List ss = await provider.storePicturesFromCameraToConversation();
                      var  oo=  Base64Encoder();
                      var ll =oo.convert(ss);
                      print(ll);
                      Base64Decoder sssss = Base64Decoder();
                      setState(() {
                        file = sssss.convert(ll);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: firstColor,
                        borderRadius: BorderRadius.all(Radius.circular(44))
                      ),
                      child: Icon(Icons.send,color: mainColor,size: 30,),
                    ),
                  ),
              ],
            ),
        ],),
      ),
    );
  }
}