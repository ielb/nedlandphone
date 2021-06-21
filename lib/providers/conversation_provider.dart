import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nedlandphone/models/User.dart';
import '../Services/conversation_service.dart';
import '../models/Conversation.dart';
import '../models/Message.dart';
import 'package:file_picker/file_picker.dart';
import 'base_provider.dart';

class ConversationProvider extends BaseProvider {
  ConversationService _conversationService = ConversationService();
    // ignore: deprecated_member_use
    List<ConversationModel> _conversations = new List.empty(growable: true);
    List<ConversationModel> get conversations => _conversations;
    // ignore: unused_field
    List<File> _files = [];
    Future<List<ConversationModel>> getConversations() async {
      var response = await _conversationService.getConversations();
      var data;
        if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        if(data['data'].length != _conversations.length ){
            if(data['data'].length > _conversations.length )
            data['data'].forEach((conversation) =>
            _conversations.add(ConversationModel.fromJson(conversation)));

        }else{
          return _conversations;
        }
      }
      if (_conversations.isNotEmpty) return _conversations;
      setBusy(true);
      clear();
        if(data==null) return null;
        data['data'].forEach((conversation) =>
            _conversations.add(ConversationModel.fromJson(conversation)));

      setBusy(false);
      return _conversations;
    }

    Future<void> storeMessage(MessageModal message) async {
      setBusy(true);
      var response = await _conversationService.storeMessage(message);
      if (response.statusCode == 201) {
        setBusy(false);
      }

      setBusy(false);
    }
    clear(){
      _conversations.clear();
    }
      Future createChat(String uid) async {
      setBusy(true);
      var response = await _conversationService.createChat(uid);
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
          _conversations.add(  ConversationModel.fromJson(data['data']))  ;
          setBusy(false);
          return ConversationModel.fromJson(data['data']);
      }
      setBusy(false);
      }
  addMessageToConversation( MessageModal message) {
    print("Conversation proider " + message.conversationId);
    var conversation = _conversations
        .firstWhere((conversation) => conversation.id == message.conversationId);
    conversation.messages.add(message);
    toTheTop(conversation);
    notifyListeners();
  }
    toTheTop(ConversationModel conversation) {
      var index = _conversations.indexOf(conversation);
      for (var i = index; i > 0; i--) {
        var x = _conversations[i];
        _conversations[i] = _conversations[i - 1];
        _conversations[i - 1] = x;
      }
    }

    storeAttachmentToConversation() async {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        type: FileType.any,
        allowMultiple: true  
      );
      if(result != null) {
      } else {

      }
    }

  Future<UserModel> getUserfromConversation(String id)async{
      try{
        Response response = await _conversationService.getUserFromConversation(id);
        var data = jsonDecode(response.body);
        var user = UserModel.fromJson(data['data']);
        return user;
      }catch(edx){
        print(edx.message);
      }
      return null ;
      
    }


    storePicturesToConversation() async {
      print('somtiond');
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg','jpeg','png','gif','mp4','mov','avi'],
        allowCompression: true,
        allowMultiple: true   
      ).onError((error, stackTrace) => null);
      if(result != null) {
          
      } else {
        return;
      }
    }
    storePicturesFromCameraToConversation() async {
      ImagePicker picker = new ImagePicker();
      PickedFile  image = await picker.getImage(source: ImageSource.camera).catchError(
          (onError) {print(onError.toString());}
      );
      print(image.path);
    }
    delete(String id) async{
    Response response = await _conversationService.delete(id);
    var data = response.body.toString();
      print(data);
      if(data =="1"){
        var conversation = _conversations.firstWhere((element) => element.id ==id);
      bool deleted = _conversations.remove(conversation);
      if(deleted){
        return "Conversation was deleted with succes!";
      }else{
          return "Something went wrong in the server!";
      }
        
      }else{
        if(data=="0"&&data=="00"){
          return "Something went wrong in the server!";
        }
      }
    }
}
