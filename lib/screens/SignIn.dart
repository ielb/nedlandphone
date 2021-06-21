import 'package:nedlandphone/config/Config.dart';
import 'package:nedlandphone/screens/handldata.dart';
import 'package:nedlandphone/screens/splash.dart';
import 'package:toast/toast.dart';

import '../providers/auth_provider.dart';
import 'SignUp.dart';
import 'CostumerService.dart';
import '../config/Constants.dart';
import 'widgets/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  double height ;
  bool _obscureText = true;
  var emailController = TextEditingController();
  TextEditingController passwordController= TextEditingController();
  ScrollController scrollController = new ScrollController();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isValidate = true;
@override
void initState() { 
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    height = Config.getHeight(context)/2.6;
    var provider =Provider.of<AuthProvider>(context,listen: false);
    return SafeArea(
          child: Scaffold(
            key: _scafoldKey,
            resizeToAvoidBottomInset: false,
            extendBody: true,
              backgroundColor: secondColor,
              body: provider.busy
          ? Center(
              child: Splash()
            )  : SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                      child: Column(
                      children: [
                        Widgets.asset( Image.asset('assets/logo/NedLandPhone.png')),
                        SizedBox(height:Config.getHeight(context)/24),
                        _signIn(),
                        SizedBox(height:Config.getHeight(context)/15),
                        Widgets.button('Sign In',() async => await signIn(provider)),
                        SizedBox(height:10),
                        Widgets.textSign("Don't have an account?") ,
                        Widgets.signButton('Get yours now!',(){
                            var route = MaterialPageRoute(builder: (context) => SignUp(widget.toggleView));
                            Navigator.of(context).push(route);
                      }),
                        SizedBox(height:140),
                      ],
                    ),
              ),
              ),
    );
  }
  //Sign In Conatainer 
  Widget _signIn(){
      return Align(
      alignment: AlignmentGeometry.lerp(Alignment.center,Alignment.bottomCenter,0),
        child: Container(
        height:  height,
        width: Config.getWidth(context)/1.15,
        decoration: BoxDecoration(
          color: firstColor,
          boxShadow: [
            BoxShadow(
              color:Colors.black.withOpacity(0.1),
              spreadRadius:1,
              blurRadius:30,
              offset: Offset(5,5).scale(5,5)
            )
          ],
          borderRadius: BorderRadius.circular(25)
        ),
        child:  Stack( children : [
              Widgets.text('Log in',26),
              Form(
              key: formKey,
              child :Column(
                children: [
                  SizedBox(height:60 ),
                  Widgets.input(Icons.mail_outline,'Email', emailController, false,null,false,null,null,null),
                  SizedBox(height:15 ),
                  Widgets.input(Icons.lock_outline,'Password', passwordController, _obscureText,IconButton(icon: Icon( _obscureText ? Icons.visibility : Icons.visibility_off,color: mainColor , ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )  ,true,null,null,null),
                  _forgetPasswordButton( AlignmentGeometry.lerp(Alignment.bottomLeft,Alignment.centerRight,0.1))
                          ]
              ) 
              ),
              
            ]
          )  ,
    ),
  ); 
  }
    // forgert pass button   
    Widget _forgetPasswordButton(AlignmentGeometry alignment){
    return Align(
      alignment: alignment, 
      child:TextButton(
        onPressed: (){
          var route = MaterialPageRoute(builder: (context) => CostumerService(false));
          Navigator.of(context).push(route);
        },
        child: Text('Forget Password?',
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          decoration: TextDecoration.underline,
      ),)),
    );
  }

  signIn(provider) async{
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      var login = await provider.login(emailController.text.trim(), passwordController.text.trim());
      if (login) {
        var route = MaterialPageRoute(builder: (context) =>HandlData());
        Navigator.of(context).pushReplacement(route);
      } else {
        Toast.show(provider.message.toString(), context);
      }
    }else{
      setState(() {
        height = Config.getHeight(context)/2.4;
      });
    }                        
  }
  

}
