import 'package:nedlandphone/screens/SignIn.dart';
import '../providers/auth_provider.dart';
import 'changeEmail.dart';
import 'widgets/Widgets.dart';
import 'package:flutter/material.dart';
import '../config/Constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'CostumerService.dart';
import 'changePass.dart';


class AccountPage extends StatefulWidget {


  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _scafoldKey = GlobalKey<ScaffoldState>();
  var f = DateFormat.yMMMEd();
 

@override
void initState() { 
  
  super.initState();
}



  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context,listen: false);
    return SafeArea(
          child: Scaffold(
            key: _scafoldKey,
            backgroundColor: secondColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  
                    SizedBox(height:30),
                    _profilePicture( auth.user.imageUrl != null?NetworkImage(    auth.user.imageUrl):AssetImage("assets/avatar/avatar.png"),
                    ()async{
                      await Provider.of<AuthProvider>(context,listen: false).pickImage();
                    }
                    ),
                    SizedBox(height:20),
                    _user( Provider.of<AuthProvider>(context).user.fullName),
                    SizedBox(height:20),
                    Widgets.text('Account',16),
                    SizedBox(height:10),
                    Widgets.accountWidget((){
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ChangeEmail()));
                      },'Change email',Icons.mail_outline_outlined),
                    SizedBox(height:15),
                    Widgets.accountWidget((){
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ChangePass()));
                      },'Change password',Icons.lock_outline),
                    SizedBox(height:15),
                    Widgets.redWidget(Icons.delete_outline, 'Delete your account', (){
                      showAlertDialogDate(context,'Delete account','Delete',buttonColor,'All your data will be Deleted ',() async {
                        bool result = await Provider.of<AuthProvider>(context,listen: false).deleteUser();
                        if(result){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: firstColor,
                              content: Text(auth.message),
                          ));
                          Provider.of<AuthProvider>(context,listen: false).logout();
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SignIn((){})));
                        }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: firstColor,
                              content: Text(auth.message),
                          ));
                        }
                      });
                    }),
                    SizedBox(height:15),
                    Widgets.text('others',16),
                    SizedBox(height:10),
                    Widgets.accountWidget((){print('privacy Taped');},'Privacy & Security',Icons.policy_outlined),
                    SizedBox(height:15),
                    Widgets.accountWidget((){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => CostumerService(true)));},'Customer Services',Icons.contact_support_outlined),
                    SizedBox(height:15),
                    Widgets.redWidget(Icons.logout, 'Log out', (){
                      auth.logout();
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SignIn((){})));
                    }
                    ),
                    SizedBox(height:50),
                ],
              ),
            ),
          ),
    );
  }
              _profilePicture(ImageProvider<Object> backgroundImage,Function onTap){
                  return Align(
                alignment: Alignment.lerp(Alignment.center, Alignment.topCenter, 0.98),
                  child: GestureDetector( 
                    onTap: (){},
                    child:  CircleAvatar(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(                          
                    height: 10 * 3.0,
                    width: 10 * 3.0,
                    decoration: BoxDecoration(
                        color:Color(0xffffe66d) ,
                        shape: BoxShape.circle,
                    ),
                    child: Center(
                        heightFactor: 10 * 1.5,
                        widthFactor: 10 * 1.5,
                        child: GestureDetector(
                          onTap: onTap,
                          child: Icon(
                          Icons.edit,
                          color:mainColor ,
                          size: 25,
                          ),
                          ),
                          ),),
                      ),
                    maxRadius: 70,
                    backgroundImage: backgroundImage,                   
              )
              )
              );
              }


    
    _user(String user){
      return Align(
        alignment:Alignment.lerp(Alignment.center, Alignment.topCenter, 0.37) ,
        child:Text('$user',
          style: TextStyle(color: textColor,fontSize: 26),
          )
          );
    }
                          
    showAlertDialogDate(BuildContext context,String title , String buttonTitle,Color color,String content,Function onpressed ) {
      //Settup buttons
      Widget firstButton = TextButton(
        
        child: Text(buttonTitle,style: TextStyle(fontSize: 20,color: color),),
        onPressed:  onpressed,
        );
      Widget cancelButton = TextButton(
        child: Text("Cancel",style: TextStyle(fontSize: 20),),
        onPressed:  () {Navigator.of(context).pop();},
        );
        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Center(child: Text(title,style: TextStyle(color: textColor),)),
          content:  Text(content,style: TextStyle(color: textColor),),
          backgroundColor: firstColor,
          actions: [
            firstButton,cancelButton
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        );
        //show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
    } 
}