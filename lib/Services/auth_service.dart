

import '../models/User.dart';
import 'package:http/http.dart' as http;
import 'BaseApi.dart';

class AuthService extends BaseApi {
  // ignore: missing_return
  Future<http.Response> getUser() async {
    try {
        return await api.httpGet('user');
    } catch (e) {
        print(e.message);
    }
   
  }

  // ignore: missing_return
  Future<http.Response> login(String email, String password) async {
    try {
        return await api.httpPost('login', {'email': email, 'password': password});
    } catch (e) {
      print(e);
    }
  
  }

  // ignore: missing_return
  Future<http.Response> register(UserModel user) async {
    try {
        return await api.httpPost('register',{'email': user.email.trim(), 'password': user.password.trim(),'fullName':user.fullName.toString()});
    } catch (e) {
        print(e);
    }
  }

  // ignore: missing_return
  Future<http.Response> logout() async {
    try {
      return await api.httpPost('logout', {});
    } catch (e) {
        print(e);
    }
    
  }
}