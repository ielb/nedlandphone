
import 'package:nedlandphone/providers/auth_provider.dart';

import '../config/Constants.dart';
import '../models/FriendModel.dart';
import 'widgets/userTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ControlPages.dart';
import 'package:toast/toast.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _inputSearchFormKey = GlobalKey<FormState>();
  var _inputSearchController = TextEditingController();
  FriendModel user ;
  final _scafoldKey = GlobalKey<ScaffoldState>();
  bool isSearching = false;
  bool isLoading = false;
  @override
  void initState()  {
    super.initState();
  }
  
void _startSearching(){
    setState(() {
      isSearching = true;
    });
  }
  void _stopSearching(){
    setState(() {
      isSearching = false;
    });
  }
  userList(){
    return FutureBuilder(
      future:  Provider.of<AuthProvider>(context,listen: false).gettingUserFriends(),
      initialData: Provider.of<AuthProvider>(context,listen: false).user.friends,
      builder: (context , snapshot){
        return snapshot.hasData ?  ListView.builder(
      shrinkWrap: true,
      itemCount:snapshot.data.length,
      itemBuilder: (context, index){
        return   UserTille(snapshot.data[index]);
        }) : Align(
          alignment: Alignment.center,
          child: Text("You don't have any friends yet \n Add them now !",style: TextStyle(color: textColor,fontSize:20,fontWeight: FontWeight.w300),),
        ); 
      },
    );
  }
    searcheduser(){
    return  ListView.builder(
      shrinkWrap: true,
      itemCount:1,
      itemBuilder: (context, index){
        return  UserTille(user);
        }) ;
  }
  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<AuthProvider>(context);
    return SafeArea(
          child: Scaffold(
          key: _scafoldKey ,
          backgroundColor: secondColor,
          body: isSearching ?  Center(child: CircularProgressIndicator()): isLoading ?  searcheduser()  : userList() ,
          appBar: AppBar( 
          centerTitle: false,
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          bottomOpacity: 0,
          title: isSearching ? new TextFormField(
            onEditingComplete: ()async{
              FocusScope.of(context).requestFocus(FocusNode());
              if(_inputSearchController.text.isNotEmpty){

                setState(() {
                  isLoading = true;
                });
              if(_inputSearchController.text!=provider.user.uid.toString()){
                var userr = await provider.search(_inputSearchController.text); 
                if (userr == null ) { Toast.show(provider.message,context,duration: 5);
                return;
                }

                setState(() {
                  user = userr;
                    _inputSearchController.text = ''; 
                });
                _stopSearching();  
              }else{
                Toast.show("Please search for someone else  not your self",context,duration: 5);
              }
            }
            },
          key: _inputSearchFormKey,
          controller: _inputSearchController,
          autofocus: true,
          decoration:  InputDecoration(
          focusedBorder :new  UnderlineInputBorder(
          borderSide: new BorderSide(
          color:mainColor.withOpacity(0.4)
        )),
          hintText: 'Search...',
          hintStyle:  TextStyle(color: textColor,),
          ),
          style:  TextStyle(color: textColor, fontSize: 16.0),
      ) : Text('Search',style:TextStyle(color:textColor,fontSize: 26,fontWeight: FontWeight.w700)),
          leading: IconButton(icon:Icon(Icons.arrow_back),color: textColor,onPressed: (){  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ControlPages(0)));},iconSize: 26),
          actions: [ isSearching ? new IconButton(icon : Icon(Icons.clear),color: textColor,iconSize: 26, onPressed: _stopSearching,): new IconButton(icon : Icon(Icons.search),color: textColor,iconSize: 26, onPressed:_startSearching,),
    ],
          ),
      ),
    );
  }




}