

class MessageModal {
  String id;
  String body;
  int read;
  int isImage;
  String userId;
  String attachmentPath;
  String conversationId;
  String createdAt;
  String updatedAt;

  MessageModal(
      {this.id,
      this.body,
      this.read,
      this.userId,
      this.conversationId,
      this.createdAt,
      this.updatedAt});

  MessageModal.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString() ;
    body = json['body'];
    if(json['attachmentPath']!=null)
    attachmentPath = json['attachmentPath'];
    isImage = json['isImage'];
    read = 0 ;
    userId = json['user_id'].toString();
    conversationId = json['conversation_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  MessageModal.fromSocket(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] ;
    body = json['body'];
    if(json['attachmentPath']!=null)
    attachmentPath = json['attachmentPath'];
    isImage = json['isImage'];
    read = 0 ;
    userId = json['user_id'].toString();
    conversationId = json['conversation_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


  Map<String, String> toJson() {
    final Map<String, dynamic> data = new Map<String, String>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['isImage'] = this.isImage.toString();
    data['read'] = this.read.toString();
    data['user_id'] =this.userId;
    data['conversation_id'] = this.conversationId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}