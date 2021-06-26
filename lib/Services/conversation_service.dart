import '../models/Message.dart';
import 'package:http/http.dart' as http;

import 'BaseApi.dart';

class ConversationService extends BaseApi {
  Future<http.Response> getConversations() async {
    return await api.httpGet('conversation');
  }

  Future<http.Response> storeMessage(MessageModal message) async {
    return await api.httpPost('message', {
      'body': message.body.toString(),
      'to' :message.userId,
      'conversation_id': message.conversationId.toString()
    });
  }
  Future<http.Response> createChat(String uid) async {
    return await api.httpPost('conversation/create', {
      
      'userID' : uid,
    
    });
  }
  Future<http.Response> delete(String id) async {
    try {
      return await api.httpPost('conversation/delete', {'id':id});
    } catch (e) {
      print(e);
    }
    return null;
  }

  // http://localhost:8012/backend/public/api/conversation/user

   Future<http.Response> getUserFromConversation(String id) async {
    try {
      return await api.httpPost('conversation/user', {'id':id});
    } catch (e) {
      print(e);
    }
    return null;
  }


}