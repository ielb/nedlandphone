import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nedlandphone/Services/socket_service.dart';
import 'package:nedlandphone/config/Config.dart';
import 'package:nedlandphone/config/Constants.dart';
import 'package:nedlandphone/models/Conversation.dart';
import 'package:nedlandphone/screens/imageV.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagesView extends StatefulWidget {
  ImagesView({this.service,this.conversation});
    final SocketService service ;
    final ConversationModel conversation;

  @override
  _ImagesViewState createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
  List<AssetEntity>  data = List.empty(growable: true);



  void  fetshImages()async{
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
  final recentAlbum = albums.first;

  // Now that we got the album, fetch all the assets it contains
  final recentAssets = await recentAlbum.getAssetListRange(
    start: 0, // start at index 0
    end: 1000000, // end at a very big index (to get all the assets)
  );

  
  setState(() => data = recentAssets);
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetshImages();
    });
    
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:secondColor,
        title: Container(margin: EdgeInsets.fromLTRB(30, 0, 0, 0),child:Text("Send to ${widget.conversation.user.fullName}",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w400),)),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
      ),
      backgroundColor: secondColor ,
      body: SafeArea(
        child: Container(
          height: Config.getHeight(context),
          width: Config.getWidth(context),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                  crossAxisCount: 2,
                  crossAxisSpacing:0,
                  mainAxisSpacing: 0,
                ),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
              if(data.length == 0) return Center(child: Text("There no picture to show please add them "),);
              return  AssetThumbnail(asset: data[index],service:widget.service,conversation:widget.conversation);
              },
          ),
        ),
      ),
    );
  }
}

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail({
    @required this.asset,
    this.service,
    this.conversation

  });
  final SocketService service;
  final ConversationModel conversation;
  final AssetEntity asset;

  @override
  Widget build(BuildContext context) {
    // We're using a FutureBuilder since thumbData is a future
    return FutureBuilder<Uint8List>(
      future: asset.thumbData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;      
        if (bytes == null) return CircularProgressIndicator();
        return GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageV(data: bytes,service: this.service,conversation: this.conversation,)));},
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  height: 260,
                  width: 200,
                  decoration: BoxDecoration(
                    color: firstColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Image.memory(bytes, fit: BoxFit.cover,filterQuality: FilterQuality.high,)
        ));
      },
    );
  }
}