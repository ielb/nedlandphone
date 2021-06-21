import 'package:nedlandphone/providers/auth_provider.dart';

import '../config/Constants.dart';
import 'widgets/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ControlPages.dart';

class ChangePass extends StatefulWidget {
  ChangePass({Key key}) : super(key: key);

  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  var currentPassController = TextEditingController();
  var newPassController = TextEditingController();
    final formey = GlobalKey<FormState>();
      final _scafoldKey = GlobalKey<ScaffoldState>();
      bool _obscureText1 = true;
      bool _obscureText = true;



  @override
  Widget build(BuildContext context) {
      var provider = Provider.of<AuthProvider>(context,listen: false);
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
            key: formey,
          child :Column(
            children: [
              SizedBox(height:10),
              Align(alignment :Alignment.topLeft ,child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0,0, 0),
                child: RichText(text: TextSpan(text:'Change password' ,style: TextStyle(color :textColor,fontSize:28),)),
              )),
              SizedBox(height:20),
              Widgets.asset( Image.asset('assets/avatar/resetPass.png')),
              SizedBox(height:20),
              Widgets.input(Icons.lock_outline,'Old password',currentPassController,_obscureText1,IconButton(icon: Icon( _obscureText1 ? Icons.visibility : Icons.visibility_off,color: mainColor , ),
                    onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() {
                        _obscureText1 = !_obscureText1;
                      });
                    },
                  ) ,true,null,null,null),
              SizedBox(height:20),
              Widgets.input(Icons.lock_outline,'New password',newPassController,_obscureText,IconButton(icon: Icon( _obscureText ? Icons.visibility : Icons.visibility_off,color: mainColor , ),
                    onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ) ,true,null,null,null),
              SizedBox(height:80),
              Widgets.button('Update', () async{
                  if(formey.currentState.validate()){
                  formey.currentState.save();
                var val= await provider.changePassword(currentPassController.text.trim(), newPassController.text.trim());
                if(val == "password changed"){
                  _obscureText1 = true;
                  _obscureText= true;
                  currentPassController.text='';
                  newPassController.text='';
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: firstColor,
                            content: Text(val)));
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