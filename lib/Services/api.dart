import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;


class Api {
  static final _api =Api._internal();
factory Api(){
  return _api;
}
  Api._internal();
  String token;
  String baseUrl = "192.168.100.39:8012";
  String path = "backend/public/api";

  // ignore: missing_return
  Future<http.Response> httpGet(String endPath,{Map<dynamic,dynamic> query}){
    try{
    Uri uri = Uri.http(baseUrl, '$path/$endPath');
    if(query!=null){
       // ignore: unused_local_variable
      Uri uri = Uri.http(baseUrl, '$path/$endPath',query); 
    }
      return http.get(uri,headers:{
      'Authorization':'Bearer $token',
      'Accept':'application/json',
      
      });
    }catch(e){
      print(e);
    }
  
  }
  
  // ignore: missing_return
  Future<http.Response> httpPost(String endPath,Object body)async{
    try{
    Uri uri = Uri.http(baseUrl, '$path/$endPath'); 
      return http.post(uri,body:body,headers:{
      'Authorization':'Bearer $token',
      'Accept':'application/json',
      
      });  
    }catch(e){
      print(e);
    }
  }
  
  // ignore: missing_return
  Future<http.Response> httpPostWithFile(String endPath, {File file}) async {
    try{
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var uri = Uri.parse("http://${this.baseUrl}/${this.path}/$endPath");
    var length = await file.length();
    http.MultipartRequest request = new http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..files.add(
        http.MultipartFile('file', file.openRead(), length,
            filename: basename(file.path)),
      );
    return await http.Response.fromStream(await request.send());
  }catch(e){
    print(e);
  }

}
}