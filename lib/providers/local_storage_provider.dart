
// ignore: unused_import

import 'package:localstorage/localstorage.dart';
import 'package:nedlandphone/models/Conversation.dart';
import 'package:nedlandphone/models/User.dart';
import 'package:nedlandphone/providers/auth_provider.dart';
import 'package:nedlandphone/providers/base_provider.dart';
import 'conversation_provider.dart';
import 'locator.dart';

class LocalStorageProvider extends BaseProvider {
  ConversationProvider _conversations = locator<ConversationProvider>();
  AuthProvider _userProvider = AuthProvider();
  UserModel _userModel = new UserModel();
  UserModel  get userModel => _userModel;
  ConversationModel _userConversations = new ConversationModel();
  ConversationModel get userConversations => _userConversations;
  final _userdata = LocalStorage('/storage/emulated/0/NedlandPhone/userdata');

  storeUserData() async {
  var ready = await _userdata.ready;
  if(ready){
    //ready to storing data    
    await _userdata.setItem('user_data',_userProvider.user.toJson());
  }else{
    //something went wrong
    print('somthing went wrong');
  }
  }

  fetchUserData() async {
  var ready = await _userdata.ready;
  if(ready){
    //getting data    
  _userModel = await _userdata.getItem('user_data');
  }else{
    print('somthing went wrong');
  }
  }
  storeUserConversations() async {
    var ready =  await  _userdata.ready;
    if(ready){
    //getting user conversations    
    await _userdata.setItem('userconversation',_conversations.conversations);
  }else{
    //somthing went wrong
    print('somthing went wrong');
  }
  }
  fetchUserConversations() async {
  var ready = await _userdata.ready;
  if(ready){
    //getting data    
  _userConversations = await _userdata.getItem('userconversation');
  }else{
    print('somthing went wrong');
  }
  }


    

}