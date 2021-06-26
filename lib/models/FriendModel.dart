
class FriendModel {

String uid;
String fullName;
String email;
String imageUrl;
int isOnline;
DateTime lastAcitve;


FriendModel({this.uid,this.fullName,this.email,this.imageUrl,this.isOnline,this.lastAcitve});
  
  FriendModel.fromJson(Map<String, dynamic> json) {
    if(json !=null){
    uid = json['id'].toString();
    fullName=json['fullName'].toString();
    email = json['email'];
    imageUrl = json['image_url'];
    isOnline =json['isOnline'] == true ? 1:0   ;
    lastAcitve =json['updated_at'] != null ? DateTime.parse(json['updated_at'].toString()) : DateTime.now();
    }
    else{
      return;
    }
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']= this.uid;
    data['email'] = this.email;
    data['image_url'] =this.imageUrl;
    data['isOnline'] = this.isOnline;
    return data;
  }

  
}
