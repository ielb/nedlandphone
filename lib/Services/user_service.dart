import '../models/User.dart';
import 'package:http/http.dart' as http;
import 'BaseApi.dart';

class UserService extends BaseApi {
  Future<http.Response> updateUserEmail(UserModel user) async {
    return await api .httpPost('user/update/email', {'email': user.email});
  }
  Future<http.Response> changeUserPassword(String currentPass,String newPass) async {
    return await api .httpPost('user/password', {
      'current_password': currentPass,
      'new_password': newPass,
    });
  }


  Future<http.Response> uploadImage(var file) async {
    
    return await api.httpPostWithFile('user/photo', file: file);
  }

  Future<http.Response> setFcmToken(String token) async {
    return await api.httpPost('fcm', {'fcm_token': token});
  }


  Future<http.Response> delete(UserModel user) async {
        return await api.httpPost('user/delete', {'id': user.uid});  
  }


  Future<http.Response> searching(String uid) async {
      return await api.httpPost('user/search',{'user_id' : uid});
  }

  Future<http.Response> gettingUserFriends() async{
    return await api.httpGet('user/friends');
  }
  Future<http.Response> addFriend(String uid) async{
    return await api.httpPost('user/firends/create',{'user_id' : uid});
  }
}