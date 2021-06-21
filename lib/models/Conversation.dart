import 'Message.dart';
import 'User.dart';

class ConversationModel {
  String id;
  UserModel user;
  DateTime createdAt;
  List<MessageModal> messages = List.empty(growable: true);


  ConversationModel({this.id, this.user, this.createdAt, this.messages});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    
    id = json['id'].toString();
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    createdAt = json['created_at'] != null ? DateTime.parse(json['created_at'].toString()) : null;
    if (json['messages'] != null) {
      json['messages'].forEach((v) {
        messages.add(new MessageModal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['created_at'] = this.createdAt;
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}