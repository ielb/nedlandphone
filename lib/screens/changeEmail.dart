import '../config/Constants.dart';
import '../providers/auth_provider.dart';
import 'widgets/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'ControlPages.dart';

class ChangeEmail extends StatefulWidget {
  ChangeEmail({Key key}) : super(key: key);

  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final _scafoldKey = GlobalKey<ScaffoldState>();
  var emailController = TextEditingController();
  bool  isIdentical=false;
  final formey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) { 
    var provider = Provider.of<AuthProvider>(context,listen: false);
    //emailController.text = provider.user.email;
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(elevation: 0.0,
      backgroundColor: firstColor,
      leading: IconButton(icon: Icon(Icons.arrow_back),iconSize: 26,
              onPressed: (){
              Navigator.of(context).pushReplacement((MaterialPageRoute(builder: (BuildContext context) => ControlPages(2))));
            },),
      ),
      backgroundColor: firstColor,
      body: SingleChildScrollView(
          child: Form (
          child :Column(
            children: [
              SizedBox(height:10),
              Align(alignment :Alignment.topLeft ,child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0,0, 0),
                child: RichText(text: TextSpan(text:'Change your current Email' ,style: TextStyle(color :textColor,fontSize:26),)),
              )),
              SizedBox(height:20),
              Widgets.asset( Image.asset('assets/logo/NedLandPhone.png')),
              SizedBox(height:20),
              Form(
                key:formey,
                child: Widgets.input(Icons.mail,'Your new email',emailController,false,null,false,null,(String v){
                  if(v!=provider.user.email){provider.user.email=v;
                  setState(() {
                      isIdentical = false;
                    });
                  }else{
                    setState(() {
                        isIdentical = true;
                    }); 
                  }
                  
                },null)),
                SizedBox(height:20),
              
              SizedBox(height:80),
              Widgets.button('Update', ()async {
                if(formey.currentState.validate()){
                formey.currentState.save();
                if(!isIdentical){
                var result = await provider.updateUserEmail();
                if(result){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: firstColor,
                    content: Text('Email updated with success'),
                  ));
                } else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: firstColor,
                            content: Text(Provider.of<AuthProvider>(context,listen :false).message)));
                }
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: firstColor,
                    content:  Text('Your new email is identical to the old one'),
                  ));
                }
              }
              }),
              SizedBox(height:80),
            ]
          ),
        ),
      ),
    );
  }
 

}