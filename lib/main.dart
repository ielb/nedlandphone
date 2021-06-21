import 'package:nedlandphone/providers/provider_setup.dart';
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


class NedLandPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return MultiProvider(
      providers:providers,
      child:  FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            showSemanticsDebugger: false,
            debugShowCheckedModeBanner: false,
            debugShowMaterialGrid: false,
            home: Splash()
          );
        } else {
          // Loading is done, return the app:
          return MaterialApp(
                    showSemanticsDebugger: false,
                    debugShowCheckedModeBanner: false,
                    debugShowMaterialGrid: false,
                    home:    Authenticate()
        );
        }
      },
    )
    );
  }  
  
}

