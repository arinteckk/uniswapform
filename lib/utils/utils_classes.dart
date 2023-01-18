import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../constant.dart';

class Jeton{
  final String? jetonName, image;
  final double? costInDollar;
  Color cardColor;
  TextEditingController? textCtrl;

  Jeton({this.jetonName, this.costInDollar, this.image, this.textCtrl, this.cardColor = Colors.transparent});
}

class CardFieldData extends ChangeNotifier{
  bool switchCardSimply = false;
  Color card1Color = Colors.transparent;
  Color card2Color = Colors.transparent;
  double firstJetonInDollar =  0.0;
  double firstJetonConv =  0.0;
  double secondJetonInDollar =  0.0;
  double secondJetonConv =  0.0;

  changeCardColor1({Color color = Colors.transparent}){
    card1Color = color;
    card2Color = Colors.transparent;
    notifyListeners();
  }

  changeCardColor2({Color color = Colors.transparent}){
    card2Color = color;
    card1Color = Colors.transparent;
    notifyListeners();
  }

  reset(){
    card1Color = Colors.transparent;
    card2Color = Colors.transparent;
  }

  List<Jeton> list = [
    Jeton(jetonName: 'ETH', costInDollar: 0.1, image : '', cardColor: Colors.transparent),
    Jeton(jetonName: 'DAI', costInDollar: 0.1, image : '', cardColor: Colors.transparent),
  ];

  updateCardColor(int i, Color color){}

  calculateInDollar(bool first, String jeton, int value){
    Map<String, double> conversion = {'ETH' : 1567.64, 'DAI' : 1};
    Map<String, double> switchValue = {'ETH' : 1545.88, 'DAI' : 0.00064};
    String resConv = (conversion[jeton]! * value).toStringAsFixed(2);
    double resultConv = double.parse(resConv);

    double resultSwitch = switchValue[jeton]! * value;

    if(first){
      firstJetonInDollar = 0.0;
      firstJetonInDollar = resultConv;

      secondJetonConv = 0.0;
      secondJetonConv = resultSwitch;
    }else{
      secondJetonInDollar = 0.0;
      secondJetonInDollar = resultConv;

      firstJetonConv = 0.0;
      firstJetonConv = resultSwitch;
    }
    notifyListeners();
  }

  resetConv(bool isF){
    if(isF){
      firstJetonInDollar = 0.0;
    }else{
      secondJetonInDollar = 0.0;
    }
    firstJetonConv = 0.0;
    secondJetonConv = 0.0;
    notifyListeners();
  }

  resetAll(){
    firstJetonInDollar = 0.0;
    secondJetonInDollar = 0.0;
    firstJetonConv = 0.0;
    secondJetonConv = 0.0;
    notifyListeners();
  }

  switchCardSimple(){
    switchCardSimply = !switchCardSimply;
    notifyListeners();
  }
}

class Api{

  static sendData(String value, String value2) async {
    var url = '${Constant.url}/saveData';
    var data = {
      "eth": value,
      "dai": value2,
    };
    http.post(Uri.parse(url),body: data).then((value){
      if(value.statusCode == 201){
        debugPrint('Ok saved');
        Constant.alertToast(msg: 'Ok données sauvergardé');
      }else{
        debugPrint('No saved');
        Constant.alertToast(msg: 'Erreur de sauvergarde');
      }
    }).catchError((err){
      debugPrint('Error $err');
      Constant.alertToast(msg: 'Erreur de sauvergard');
    });
  }
}