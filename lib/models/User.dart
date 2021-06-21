
import 'FriendModel.dart';

class UserModel {

String uid;
String fullName;
String email;
String password;
String imageUrl;
String fcmtoken;
int isOnline;
DateTime lastAcitve;
DateTime creationDate;
List<FriendModel> friends = [] ;

UserModel({this.uid,this.fullName,this.email,this.password,this.fcmtoken,this.imageUrl,this.isOnline,this.lastAcitve,this.creationDate});
  
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['id'].toString();
    email = json['email'];
    imageUrl = json['image_url'];
    isOnline =json['isOnline'] == true ? 1:0   ;
    fcmtoken =json['fcm_token'];
    if(json['friends'] != null)
    UserModel.fromFriendJs(json['friends']);
    lastAcitve =json['updated_at'] != null ? DateTime.parse(json['updated_at'].toString()) : DateTime.now();
    creationDate =  json['created_at'] != null ? DateTime.parse(json['created_at'].toString()) : null;
    fullName =  json['fullName'] ;
  }
  UserModel.fromFriendJs(Map<String, dynamic> json){
    if (json['friends'] != null) {
      friends =[];
      json['friends'].forEach((v) {
      friends.add(new FriendModel.fromJson(v));
      });
    }
  }
  

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']= this.uid;
    data['email'] = this.email;
    data['fcm_token'] =this.fcmtoken;
    data['image_url'] =this.imageUrl;
    data['isOnline'] = this.isOnline;
    data['friends'] = this.friends;
    data['fullName'] = this.fullName;
    return data;
  }

  
}


