import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Config {



  
  static double getHeight(context){
    return MediaQuery.of(context).size.height;
  }
  static double getWidth(context){
    return MediaQuery.of(context).size.width;
  }
  static Uint8List convert(String data){
    Base64Decoder imageData = Base64Decoder();

    return imageData.convert(data);
  }
  static String deConvert(Uint8List data){
    Base64Encoder imageData = Base64Encoder();
    return imageData.convert(data);
  }

}