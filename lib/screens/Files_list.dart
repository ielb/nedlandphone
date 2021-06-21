

import 'dart:io';

import '../config/Constants.dart';
import 'package:flutter/material.dart';

// import 'package:ext_storage/ext_storage.dart';
    



class Files extends StatefulWidget {

  @override
  _FilesState createState() => _FilesState();
}

enum Sorts  { bySize ,byDate}

class _FilesState extends State<Files> {

    String directory;
    // ignore: unused_field
    List<FileSystemEntity>  _files;
    List<File> files ;
    var sorts = Sorts.bySize;

// void _listofFiles() async {
//         _files = List.empty(growable: true);
//         files = List.empty(growable: true);
//         directory = (await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS));
//         print(Directory("$directory").uri);

//           _files = Directory("$directory").listSync();
//           print(_files.isEmpty);
//           _files.forEach((file) =>print(file.path ));
          
//           // return _files;
//   }
  @override
  void initState() { 
    super.initState();
  //  _listofFiles();
  }
 
    

  @override
  Widget build(BuildContext context) {




    return SafeArea(
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: secondColor,
          title: Text('Documents'),
          leading: BackButton(
            color: textColor,
            onPressed: (){
                Navigator.of(context).pop();

          }),
          actions: [
            IconButton(icon:Icon(Icons.search),onPressed: (){},),
            
            PopupMenuButton(icon:Icon(Icons.sort),
            initialValue: Sorts.bySize,
            color: Color(0xff0D234B),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Sorts>>[
              const PopupMenuItem<Sorts>(
                value: Sorts.bySize,
                child: Text('Sort by size',style: TextStyle(color: Colors.white),),
              ),
              const PopupMenuItem<Sorts>(
                value: Sorts.bySize,
                child:Text('Sort by date',style :TextStyle(color: Colors.white)),
              ),
            ],
            onSelected: (s){
              setState(() {
                sorts = s;
              });
            },
            ),
          ],
        ),
        backgroundColor: firstColor,
         body:Container()
         ,
         // FutureBuilder(
      //     future: _listofFiles(),
      //     builder:(context,snapshot){
      //     if(snapshot.connectionState == ConnectionState.waiting){
      //               return new Text('Data is loading...');
      //     }else{
                // if(snapshot.hasData){
                //    return customBuild(context, snapshot);
                // }       
                //  return new Text('Data is loading...');
      //     }
      //     },
      // ),
      ),
    );
  }

  Widget customBuild(BuildContext context, AsyncSnapshot snapshot){
    return  GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
          itemCount: snapshot.data.length,
          itemBuilder : (context,index) {
            return Container(
              child:Image.file(File(snapshot.data[index].path),fit: BoxFit.fill,),
              height: 20,color:secondColor,margin:  EdgeInsets.only(top: 10.0, bottom: 5.0,left: 10,right:10),
            );
          },
          );
  }
}