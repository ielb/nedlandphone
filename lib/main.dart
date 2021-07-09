import 'package:nedlandphone/providers/provider_setup.dart';
import 'package:permission_handler/permission_handler.dart';
import 'providers/locator.dart';
import 'screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'helper/authenticate.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(NedLandPhone());
}


class NedLandPhone extends StatefulWidget {
  @override
  _NedLandPhoneState createState() => _NedLandPhoneState();
}

class _NedLandPhoneState extends State<NedLandPhone> {

  @override
  void initState() {
    super.initState();
    requiresPermission();
  }
  requiresPermission()async{
    // ignore: unused_local_variable
    Map<Permission, PermissionStatus>  status =await [ 
      Permission.accessMediaLocation,
      Permission.storage,
      Permission.mediaLibrary,
      Permission.photos,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:providers,
      child:  MaterialApp(
          debugShowCheckedModeBanner: false,
        home:  FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  Splash();
        } else {
          return Authenticate();
        }
      },
    ),),
    );
  }  
}

