import 'package:nedlandphone/models/Message.dart';
import 'package:nedlandphone/models/User.dart';
import 'package:nedlandphone/providers/auth_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
IO.Socket socket;
  void connect(AuthProvider userProvider) async {
    try{
      socket = IO.io('http://192.168.100.39:5000',
      OptionBuilder()
      .setTransports(['websocket'])
      .disableAutoConnect() 
      .build());
    if(socket.disconnected)
    socket.connect();
    if(socket.connected){
      print("connected");
      bool item = await userProvider.setFcmToken(socket.id);
      print(userProvider.user.email);
      if(item){
        socket.emit("/connect",userProvider.user);
      }else{
        print("Can't save socket id");
      }
    }
    }catch (ex){
      print(ex);
    }
    
  } 

  void recievingMessages(Function(dynamic) function){
    if(socket.connected){
    socket.on("/recieved", (data) {
        function(data);
      });
    }
  }
  void disconnect(UserModel user)  {
    if(socket.connected){
      socket.emit("/disconnect",user);
      socket.disconnect();
    }
  }
  void sendMessage(MessageModal message ,UserModel user)  {
    if(socket.connected){
      socket.emit("/message",[message.toJson(),user]);
    }else{
      print("please connect to send messages");
    }
  }  
}