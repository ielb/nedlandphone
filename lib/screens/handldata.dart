import 'package:flutter/material.dart';
import 'package:nedlandphone/providers/auth_provider.dart';
import 'package:nedlandphone/providers/conversation_provider.dart';
import 'package:nedlandphone/screens/ControlPages.dart';
import 'package:nedlandphone/screens/SignIn.dart';
import 'package:nedlandphone/screens/splash.dart';
import 'package:provider/provider.dart';
class HandlData extends StatefulWidget {
  HandlData({Key key}) : super(key: key);

  @override
  _HandlDataState createState() => _HandlDataState();
}

class _HandlDataState extends State<HandlData> {
  @override
void initState() { 
  WidgetsBinding.instance.addPostFrameCallback((_){
      checkUser();
    }
    );
  super.initState(); 
}
checkUser()async{
  var userEsist = await Provider.of<AuthProvider>(context,listen: false).getUser();
      if (userEsist!=null) {
        Provider.of<ConversationProvider>(context,listen: false).getConversations();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>ControlPages(0)));
      }else{
        var auth = Provider.of<AuthProvider>(context,listen : false);
        if( auth.user.uid == null){
        auth.logout();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn((){})));
        }
        
      }
}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp( showSemanticsDebugger: false,
                    debugShowCheckedModeBanner: false,
                    debugShowMaterialGrid: false,home: Splash());
        } 
        return ControlPages(0);
      }
    );
}

}