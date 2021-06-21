




import '../../config/Constants.dart';
import 'package:flutter/material.dart';

class Widgets{
  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
  static   Widget asset(Image image){
    return Align(
    alignment: Alignment.lerp(Alignment.center, Alignment.bottomCenter, -1.1),
    child: Container(
      height: 180,
      width: 180,
      child: image,)
    );
  }
static Widget text(String text,double size){
      return Align(
        alignment: AlignmentGeometry.lerp(Alignment.topLeft,Alignment.centerRight,0.1),
        child : Text(text,style: TextStyle(color: textColor,fontWeight:FontWeight.w700,fontSize: size),),
      );
    }
  static   Widget textSign(String label){
    return Align(
      alignment: AlignmentGeometry.lerp(Alignment.center,Alignment.bottomCenter, 0.86),
        child: Text(label,style: TextStyle(color: textColor),), );
  }
static   Widget button(String label,Function onPressed){
    return  new Align(
      alignment: AlignmentGeometry.lerp(Alignment.center,Alignment.bottomCenter, 0.79),
      child:GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(35)
          ),
          child:  new Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 26.0, color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
      );
  }

 static Align accountWidget(Function onTap,String label , IconData icon){
      return Align(
        alignment:Alignment.lerp(Alignment.center, Alignment.topCenter, -0.15) ,
        child: GestureDetector(
          onTap: (){onTap();},
            child: Container(
              width: 380,
              height: 50,
              decoration: BoxDecoration(color: firstColor,
              borderRadius:BorderRadius.circular(20),
              ),child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  SizedBox(width:10),
                  Icon(icon,color:textColor),                  
                  SizedBox(width:10),
                  Text(label,style: TextStyle(color: textColor,fontSize: 20)),
                  Spacer(),
                  GestureDetector(
                    child: Icon(Icons.arrow_forward_ios,color: textColor,),
                    onTap: (){print('Privacy Taped');}
                    ),
                  SizedBox(width:10)
                  ]
                  ),
                  )
                  ),
                  );
          }
                //Password input   
static Widget input(IconData icon, String hint, TextEditingController controller, bool obsecure, Widget suffixIcon,dynamic isPassword,Function onTap,Function onSaved,String initialValue) {
      return  Align(
    child:Container(
      width: 280,
      child: TextFormField(
        initialValue: initialValue,
        onTap: onTap,
        onSaved: onSaved,
          validator: (val) {
            if(isPassword != null){
            if(isPassword){
              if (val.isEmpty) {
                return 'input require';
              } else if (val.trim().length < 6) {
                return 'this password is too short';
              } 
            } else {
                if (val.isEmpty) {
                return 'input require';
                } else if (!isEmail(val)) {
                return 'email invalide';
                }
              } 
            }
              return null;
              },
          controller: controller,
          obscureText: obsecure,
          style: TextStyle(fontSize: 16,  color: textColor),
          decoration: InputDecoration(
              hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,color: Colors.white.withOpacity(0.6)),
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 1.5,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 3,
                ),
              ),
              suffixIcon: suffixIcon,
              prefixIcon: Padding(
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue),
                  child: Icon(icon),
                ),
                padding: EdgeInsets.only(left: 10, right: 10),
              )),
        ),
      ));
    }
          
        static  redWidget(IconData icon,String hint,Function onTape){
          return Align(
            alignment:Alignment.lerp(Alignment.center, Alignment.topCenter, -0.9) ,
            child: GestureDetector(
              onTap:  onTape,
              child: Container(
                width: 380,
                height: 50,
                decoration: BoxDecoration(
                  color: firstColor,
                  borderRadius:BorderRadius.circular(20),
                  ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    SizedBox(width:10),
                    Icon(icon,color:buttonColor),
                    SizedBox(width:10),
                    Text(hint,style: TextStyle(color: buttonColor,fontSize: 20)),
                    Spacer(),
                    GestureDetector(child: Icon(Icons.arrow_forward_ios,color: buttonColor,),
                    onTap: onTape,
                    ),
                    SizedBox(width:10)
                  ]
                ),
              )
            ),
          );
        }
    static Widget signButton(String label , Function onPressed){
    return Align(
      alignment: AlignmentGeometry.lerp(Alignment.center,Alignment.bottomCenter, 0.99),
      child: TextButton(
        onPressed: onPressed,
        child: Text(label,
        style: TextStyle(
          color: buttonColor,
          fontSize: 16,
          
      ),)),
    );
  }

}