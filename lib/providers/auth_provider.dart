import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:nedlandphone/Services/user_service.dart';
import 'package:nedlandphone/models/FriendModel.dart';
import '../Services/api.dart';
import '../Services/auth_service.dart';
import '../models/User.dart';
import 'conversation_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base_provider.dart';

class AuthProvider extends BaseProvider {
    AuthService _authService = AuthService();
    UserService _userService  = UserService();
    ConversationProvider _conversations ;
    Api _api =Api();
    UserModel _user = UserModel();
  
    UserModel get user => _user;
  
    setUser(UserModel user) {
      _user = user;
    }
  
    Future<UserModel> getUser() async {
      setBusy(true);
      bool tokenExist = await getToken();
      if (tokenExist) {
        var response = await _authService.getUser();
        var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          setUser(UserModel.fromJson(data['data']));
          return _user;
        } else
          setBusy(false);
        return null;
      }
      setBusy(false);
  
      return null;
    }
  
    Future<bool> getToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
  
      var token = prefs.getString('access_token');
      if (token != null) {
        _api.token = token;
        return true;
      }
      return false;
    }
  
    Future<void> saveToken(String token) async {
      try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('access_token');
      prefs.setString('access_token', token);
      _api.token = token;
      } catch (e) {
        print(e);
      }
    }
  
    Future<bool> login(String email,String password) async {
      setBusy(true);
      print("login");
      try {
      
      var response = await _authService.login(email.trim(), password.trim());
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        saveToken(data['access_token']);
        UserModel uss = await getUser();
      if(uss!=null){
          setBusy(false);
          return true;
      }
        
      } else if (response.statusCode >= 400) {
        print(data);
        setMessage(data["error"]);
        return false;
      }
      
      } catch (e) {
        print(e.toString());
      }
      setBusy(false);
      return false;

    }
  
    Future<bool> register() async {
      try {
        setBusy(true);
      var response = await _authService.register(_user);
      var json = jsonDecode(response.body); 
       print(json);   
      if (response.statusCode == 201) {
        var result = await login(_user.email.trim(), _user.password.trim());
        if (result) {
          return true;
        } else
          return false;
      }else {
        var message = json['errors']['email'][0];
        print(message);
        setBusy(false);
        setMessage(message);
        return false;
      }
      
      } catch (e) {
        print(e);
      }
      return false;
    }
  
    Future<bool> logout() async {
      try {
        setBusy(true);
        _conversations = ConversationProvider();
        var response = await _authService.logout();
        print(response.body);
      if(response.statusCode== 200){
        _conversations.clear();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('access_token');
      setBusy(false);
      }
      setBusy(false);
      } catch (e) {
        print(e);
      }
      
      setBusy(false);
      return true;
    }
    setUserPicture(String imageUrl) {
      user.imageUrl='';
      user.imageUrl=imageUrl;
      notifyListeners();
    }  
  
    Future<bool> updateUserEmail() async {
      setBusy(true);
      var response = await _userService.updateUserEmail(user);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        
        setUser(UserModel.fromJson(data['data']));
  
        setBusy(false);
        return true;
      }
      if (response.statusCode == 422 || response.statusCode == 404) {
        var message = data['errors']['email'][0];
        setMessage(message);
        return false;
      }
      setBusy(false);
      return false;
    }
    Future<String> changePassword(String currentPass,String newPass) async {
      var response = await _userService.changeUserPassword(currentPass, newPass);
      var data =response.body;
      if(response.statusCode == 200){        
        setMessage(data);
      }else{    
        setMessage(data);
      }
      return data;
    }
  
    Future<void> pickImage() async {
      try{
      ImagePicker picker = new ImagePicker();
      PickedFile image ;
        image = await picker.getImage(source: ImageSource.gallery).catchError(
          (onError) {print(onError.toString());}
      );
        
        if(image!=null){
        File  pickedImage = File(image.path);
        var response = await _userService.uploadImage(pickedImage);
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 ||response.statusCode == 201) {
        setUserPicture(data['data']['image_url']);
      
      
      }
        
        }
        
      }catch(e){
        print(e);
        }
      
    }
  
    Future<bool> setFcmToken(String token) async {
      var response =await _userService.setFcmToken(token);
      if(response.statusCode==200){
        UserModel v = await getUser();
        setUser(v);
        if(v!=null) return true ;
      }
      else{
        return false;
      }
      return false;
    }
    Future search(String uid) async {
      var response = await _userService.searching(uid);
      var data = jsonDecode(response.body);
      if(response.statusCode==200){
        return (FriendModel.fromJson(data['data']));
        
      }else{
        setMessage("the user you are searching for is not exist ! ");
      }
    }

    Future<bool> deleteUser() async{
      var response = await _userService.delete(user);
      if(response.statusCode == 200){
      setMessage(response.body);
      _conversations.clear();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('access_token');
      return true;
      }
      setMessage(response.body);
      return true;

    }
    Future<List<FriendModel>> gettingUserFriends() async{
      if(_user.friends.isNotEmpty) return _user.friends; 
      var response = await _userService.gettingUserFriends();
        var data = jsonDecode(response.body);
        List list = data['data'];
    if(response.statusCode == 200){
        list.forEach((value) => _user.friends.add(FriendModel.fromJson(value['userID'])));
    
    }
    return _user.friends;
    
    }
    addFriend(String uid) async{
      if(_user.friends.length==0){
        
          var response = await _userService.addFriend(uid);
        var data = jsonDecode(response.body);
      if(response.statusCode == 200){ 
      _user.friends.add(FriendModel.fromJson(data['data']));
    }
      }else{

      
      for (var i = 0; i < _user.friends.length; i++) {
            
      if(_user.friends[i].uid==uid){
        print('alreddy have this one');
        return;
      }else{
        var response = await _userService.addFriend(uid);
        var data = jsonDecode(response.body);
        print('$data');
      if(response.statusCode == 200){ 
      _user.friends.add(FriendModel.fromJson(data['data']));
    }
      }
          }
      }
    } 
  
}
