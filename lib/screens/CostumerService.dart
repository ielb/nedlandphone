
import '../config/Constants.dart';
import 'ControlPages.dart';
import 'widgets/Widgets.dart';
import 'package:flutter/material.dart';



class CostumerService extends StatefulWidget {
  final bool isFromAccountPage;
  CostumerService(this.isFromAccountPage);

  @override
  _CostumerServiceState createState() => _CostumerServiceState();
}

class _CostumerServiceState extends State<CostumerService> {
var formKey = GlobalKey<FormState>();
  var messageController = TextEditingController();
  var emailController =TextEditingController();

  message(){
    if(formKey.currentState.validate()){
    formKey.currentState.save();
      print('is valide');
    }
    else{
      print('is not valide');
    }
  }
  @override
  void initState() { 
    super.initState();
      //getting firebaseToken
     
  }


  




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
          appBar :AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: mainColor,), onPressed: (){
              !widget.isFromAccountPage ?
            Navigator.of(context).pop() : Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ControlPages(2)));
            },color: Colors.white,),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            bottomOpacity: 0,
          ),
          backgroundColor: firstColor,
              body:SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Widgets.asset( Image.asset('assets/logo/NedLandPhone.png')),
                      SizedBox(height: 20,),
                      _text('Contact Support'),
                      SizedBox(height: 20,),
                      
                      Widgets.input(Icons.mail_outline,'Email', emailController, false,null,false,null,null,null),
                      SizedBox(height: 20,),
                      _inputMessage(Icon(Icons.support_agent_outlined), 'Message', messageController, Alignment.lerp(Alignment.center, Alignment.bottomCenter, 0.35)),
                      SizedBox(height: 80,),
                      _messageButton(),
                      SizedBox(height: 100,),
                      ]
                      ),
                              ),
              ),
                    ),
    );
  }



    Widget _inputMessage(Icon icon, String hint, TextEditingController controller,AlignmentGeometry alignment) {
      return  Align(
    alignment: alignment,
    child:Container(
      width: 280,
      height: 100,
      child: TextFormField(
          validator: (email){
            if (email.isEmpty) {
                return 'Please enter some text';
              }
              return null;
          },
          maxLines: 3,
          controller: controller,
          style: TextStyle(fontSize: 16, ),
          decoration: InputDecoration(
              hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,color: Colors.white.withOpacity(0.6)),
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 3,
                ),
              ),
              prefixIcon: Padding(
                child: IconTheme(
                  data: IconThemeData(color: Theme.of(context).primaryColor),
                  child: icon,
                ),
                padding: EdgeInsets.only(left: 10, right: 10,bottom: 38),
              )),
        ),
      ));
    }
    Widget _text(String text){
      return Align(
        alignment: AlignmentGeometry.lerp(Alignment.center,Alignment.bottomCenter,-0.35),
        child : Text(text,style: TextStyle(color: textColor,fontWeight:FontWeight.w700,fontSize: 30),),
      );
    }

  Widget _messageButton(){
    return  new Align(
      alignment: AlignmentGeometry.lerp(Alignment.center,Alignment.bottomCenter, 0.75),
      child:Container(
        height: 50,
        width: 200,
        child: new ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xffDA5151)),
                    overlayColor: MaterialStateProperty.all(Color(0xffDA5151)),
                    shape:MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(22.0))) ,
                      ),                  
                    child: Center(
                      child: Text(
                        'Send',
                        style: TextStyle(
                          fontSize: 29.0, color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: (){
                      message();
                    },
                  ),
      ),
      );
  }

}