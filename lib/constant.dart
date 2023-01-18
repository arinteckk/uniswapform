import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class Constant{
  static String daiImg =  'images/dailogo.png';
  static String etheLogo =  'images/ethlogo.png';
  static String url = "https://uniwapapi.onrender.com";

  static MaterialColor color = MaterialColor(
    const Color.fromRGBO(28, 17, 80, 1).value, const <int, Color>{
    50: Color.fromRGBO(28, 17, 80, 0.1),
    100: Color.fromRGBO(28, 17, 80, 0.2),
    200: Color.fromRGBO(28, 17, 80, 0.3),
    300: Color.fromRGBO(28, 17, 80, 0.4),
    400: Color.fromRGBO(28, 17, 80, 0.5),
    500: Color.fromRGBO(28, 17, 80, 0.6),
    600: Color.fromRGBO(28, 17, 80, 0.7),
    700: Color.fromRGBO(28, 17, 80, 0.8),
    800: Color.fromRGBO(28, 17, 80, 0.9),
    900: Color.fromRGBO(28, 17, 80, 1),
  });



  static String? numValidator(String num) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (num.isEmpty) {
      return 'Champ requis';
    }else if (!regExp.hasMatch(num)) {
      return 'Saisie invalide';
    }
    return null;
  }

  static alertToast({String msg = '', Color color = Colors.red}){
    Fluttertoast.showToast(
        msg: msg,
        textColor: Colors.white,
        backgroundColor: color,
        gravity: ToastGravity.BOTTOM);
  }

  static Widget shimmer(){
    return Shimmer(
      duration: const Duration(milliseconds: 2000),
      interval: const Duration(milliseconds: 100),
      color: const Color.fromRGBO(42, 34, 86, 1),
      colorOpacity: 1,
      enabled: true,
      direction: const ShimmerDirection.fromLeftToRight(),
      child: Container(
        height: 18, width: 60,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(79, 65, 149, 1),
            borderRadius: BorderRadius.circular(5)
        ),
      ),
    );
  }


  static Widget paddingZero(){
    return const Padding(padding: EdgeInsets.zero);
  }

}