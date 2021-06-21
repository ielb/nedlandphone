import 'package:nedlandphone/config/Config.dart';

import '../providers/auth_provider.dart';
import 'SignIn.dart';

import '../config/Constants.dart';
import 'handldata.dart';
import 'widgets/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class SignUp extends StatefulWidget {
final Function toggleView;
SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscureText = true;
  DateTime selectedDate = DateTime.now() ;
  final _scafoldKey = GlobalKey<ScaffoldState>();
  final formey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  TextEditingController passwordController= TextEditingController();
  bool isLoading = false;
  bool isValidate = true;
  var f = DateFormat.yMMMEd();

 
  @override
  void dispose() {
    selectedDate=DateTime.now();
    passwordController.text='';
    emailController.text='';
    super.dispose();
  }
  signUp() async{
    
                    
  
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    return SafeArea(
          child: Scaffold(
            key: _scafoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: secondColor,
            body: Provider.of<AuthProvider>(context).busy
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Widgets.asset( Image.asset('assets/logo/NedLandPhone.png')),
                      SizedBox(height:Config.getHeight(context)/15),
                      _signUp(),
                      SizedBox(height:20),
                      SizedBox(height:Config.getHeight(context)/18),
                      Widgets.button('Sign Up',()async{
                        if(formey.currentState.validate()){
                          formey.currentState.save();
                          var result = await provider.register();
                            if (result) {
                                
                          var route = MaterialPageRoute(builder: (context) =>HandlData());
                            Navigator.of(context).pushReplacement(route);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: firstColor,
                            content: Text(provider.message),
                          ));
                        } 
                              setState(() {
                                isValidate = true;
                              });
                        }
                        else{
                          setState(() {
                            isValidate = false;
                          });
                      }
                      }),
                      SizedBox(height:10),
                      Widgets.textSign("Already have an account?"),
                      Widgets.signButton('Sign In !',() 
                      { 
                        var route = MaterialPageRoute(builder: (context) => SignIn(widget.toggleView));
                          Navigator.of(context).pushReplacement(route);}),
                      SizedBox(height:100),
                    ],
                          ),
              ),
                              ),
                    
    );
  }
  
 

  Widget _signUp(){
    var provider = Provider.of<AuthProvider>(context);
      return Align(
      alignment: AlignmentGeometry.lerp(Alignment.center,Alignment.bottomCenter,0.1),
        child: Container(
        height: !isValidate ? 330 : 300 ,
        width: 330,
        decoration: BoxDecoration(
          color: firstColor,
          boxShadow: [
            BoxShadow(
              color:firstColor.withOpacity(0.16),
              spreadRadius: 10,
              blurRadius: 15,
              offset: Offset(8,5).scale(1, 2)
            )
          ],
          borderRadius: BorderRadius.circular(25)
        ),
        child: Stack(
            children: [
              Widgets.text('Sign Up',26),
              Form(
                key: formey,
                child: Column(
                children :[
                  SizedBox(height:60),
                  Widgets.input(Icons.mail_outline,'Email', emailController, false,null,false,null,(String v){provider.user.email =v.trim();},null),
                  SizedBox(height:10),
                  Widgets.input(Icons.person,'Full Name',nameController,false,null,null,(){},(String data){
                    provider.user.fullName = data.trim();
                  },null
                  ),
                  SizedBox(height:10),
                  Widgets.input(Icons.lock_outline,'Password', passwordController, _obscureText,IconButton(icon: Icon( _obscureText ? Icons.visibility : Icons.visibility_off,color: mainColor , ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )  ,true,null,(String v) => provider.user.password = v.trim(),null),
                ])) ],
      ),
        ),
    
  ); 
  }  
  

}