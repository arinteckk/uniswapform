import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniswapform/utils/utils_classes.dart';
import '../constant.dart';

class InterfaceForm extends StatefulWidget {
  const InterfaceForm({Key? key}) : super(key: key);

  @override
  State<InterfaceForm> createState() => _InterfaceFormState();
}

class _InterfaceFormState extends State<InterfaceForm> {
  TextEditingController firstJetonCtrl = TextEditingController();
  TextEditingController secondJetonCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.color,
      appBar: AppBar(
       title: const Text('Uniswap Interface Form'),
        centerTitle: true,
      ),
      body: form(context),
    );
  }

  Widget form(BuildContext context){
    bool switchCard = context.watch<CardFieldData>().switchCardSimply;
    return InkWell(
      onTap: (){
        FocusScope.of(context).unfocus();
        context.read<CardFieldData>().reset();
      },
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                settingWidget(),

                Stack(
                  alignment: Alignment.center,
                  children: [
                    !switchCard ?
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: firstFieldCard(context, firstFormField(
                              voidCallback: () => context.read<CardFieldData>()
                                  .changeCardColor1(color: Colors.white38)), jeton(jetonImage: Constant.etheLogo)),
                        ),
                        secondFieldCard(context, secondFormField(
                            voidCallback: () => context.read<CardFieldData>()
                                .changeCardColor2(color: Colors.white38)),
                            jeton(jetonName: 'DAI', jetonImage: Constant.daiImg)),
                      ],
                    ) :
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: secondFieldCard(context, secondFormField(
                              voidCallback: () => context.read<CardFieldData>()
                                  .changeCardColor2(color: Colors.white38)),
                              jeton(jetonName: 'DAI', jetonImage: Constant.daiImg)),
                        ),
                        firstFieldCard(context, firstFormField(
                            voidCallback: () => context.read<CardFieldData>()
                                .changeCardColor1(color: Colors.white38)), jeton(jetonImage: Constant.etheLogo))
                      ],
                    ),
                    switchIcon()
                  ],
                ),
                sendButton(),
                appLanguageVersion()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget firstFieldCard(BuildContext context, Widget field, Widget jetonList){
    Color color =  context.watch<CardFieldData>().card1Color;
    double fValue =  context.watch<CardFieldData>().firstJetonInDollar;
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(12)
      ),

      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: field),
              jetonList
            ],
          ),

          fValue > 0 ? Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20),
              child: FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 5), () => fValue),
                  builder: (context, data){
                    if(data.connectionState == ConnectionState.waiting){
                      return Constant.shimmer();
                    }
                    return Text('\$ ${data.data!}', style: const TextStyle(color: Colors.white));
                  }),
            ),
          ) : Constant.paddingZero()
        ],
      ),
    );
  }

  Widget secondFieldCard(BuildContext context, Widget field, Widget jetonList){
    Color color = context.watch<CardFieldData>().card2Color;
    double sValue =  context.watch<CardFieldData>().secondJetonInDollar;
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(12)
      ),

      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: field),
              jetonList
            ],
          ),

          sValue > 0 ? Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20),
              child: FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 5), () => sValue),
                  builder: (context, data){
                    if(data.connectionState == ConnectionState.waiting){
                      return Constant.shimmer();
                    }
                    return Text('\$ ${data.data!}', style: const TextStyle(color: Colors.white));
                  }),
            ),
          ) : Constant.paddingZero()
        ],
      ),
    );
  }

  Widget settingWidget(){
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 7, right: 7, bottom: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Échanger', style: TextStyle(fontSize: 17, color: Colors.white)),
            InkWell(
                onTap: (){},
                child: const Icon(Icons.settings, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget firstFormField({String hintText = '0', VoidCallback? voidCallback}){
    double fConv =  context.watch<CardFieldData>().firstJetonConv;
    if(fConv > 0){
      firstJetonCtrl.text = fConv.toString();
    }
    return  Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        child: Theme(
          data: ThemeData(
              textSelectionTheme: const TextSelectionThemeData(
                  selectionHandleColor: Colors.transparent,
                  selectionColor: Colors.blue),
              primaryColor: Colors.white),
          child: TextFormField(
            onTap: () => voidCallback!(),
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis,),
            cursorColor: Colors.white,
            controller: firstJetonCtrl,
            decoration: InputDecoration(
              focusColor: Colors.white,
              hoverColor: Colors.white,
              fillColor: Colors.white,
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white38, fontSize: 15),
              //suffix: prefixIcon
            ),
            onChanged: (String str){
              secondJetonCtrl.clear();
              if(str.isNotEmpty){
                context.read<CardFieldData>().calculateInDollar(true, 'ETH', int.parse(str));
              }else{
                context.read<CardFieldData>().resetConv(true);
              }
            },
            onFieldSubmitted: (String s) {
              context.read<CardFieldData>().reset();
            },
          ),
        ),
      ),
    );
  }

  Widget secondFormField({String hintText = '0', VoidCallback? voidCallback}){
    double sConv =  context.watch<CardFieldData>().secondJetonConv;
    if(sConv > 0){
      secondJetonCtrl.text = sConv.toString();
    }
    return  Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        child: Theme(
          data: ThemeData(
              textSelectionTheme: const TextSelectionThemeData(
                  selectionHandleColor: Colors.transparent,
                  selectionColor: Colors.blue),
              primaryColor: Colors.white),
          child: TextFormField(
            onTap: () => voidCallback!(),
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis,),
            cursorColor: Colors.white,
            controller: secondJetonCtrl,
            decoration: InputDecoration(
              focusColor: Colors.white,
              hoverColor: Colors.white,
              fillColor: Colors.white,
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white38, fontSize: 15),
              //suffix: prefixIcon
            ),
            onChanged: (String str){
              firstJetonCtrl.clear();
              if(str.isNotEmpty){
                context.read<CardFieldData>().calculateInDollar(false, 'DAI', int.parse(str));
              }else{
                context.read<CardFieldData>().resetConv(false);
              }
            },
            onFieldSubmitted: (String s) {
              context.read<CardFieldData>().reset();
            },
          ),
        ),
      ),
    );
  }

  Widget appLanguageVersion(){
    return  Padding(
      padding: const EdgeInsets.only(top: 25),
      child: SizedBox(
        child: RichText(
            text: const TextSpan(
                text: 'Uniswap disponible en : ',
                style: TextStyle(fontSize: 13, color: Colors.white),
                children: [
                  TextSpan(
                      text: 'English',
                      style: TextStyle(fontSize: 13, color: Color.fromRGBO(67, 45, 173, 1)))
                ]
            )),
      ),
    );
  }

  Widget switchIcon(){
    return InkWell(
      onTap: (){
        context.read<CardFieldData>().switchCardSimple();
      },
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        height: 30,
        width: 35,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(22, 7, 93, 1),
            borderRadius: BorderRadius.circular(9)
        ),
        child: const Icon(Icons.arrow_downward_rounded, color: Colors.white,),
      ),
    );
  }

  Widget jeton({String jetonName = 'ETH', String jetonImage = ''}){
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(22, 7, 93, 1),
            borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children:  [
             SizedBox(
              child: CircleAvatar(
                backgroundImage: AssetImage(jetonImage),
                backgroundColor: Colors.white,),
            ),
            Text(jetonName,style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white,)
          ],
        ),
      ),
    );
  }

  Widget sendButton(){
    return InkWell(
      onTap: (){
        Api.sendData(firstJetonCtrl.text, secondJetonCtrl.text);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 11),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(41, 21, 142, 1),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Text('ENVOYER',
                style: TextStyle(fontSize: 18, color: Colors.blue[700], fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }


  Widget mapping(BuildContext context){
    var list = context.watch<CardFieldData>().list;
    return Column(
      children: list.map((e) {
        e.textCtrl = TextEditingController();
        return Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(color: e.cardColor),
                borderRadius: BorderRadius.circular(12)
            ),

            child: Row(
              children: [
                Expanded(child: firstFormField(
                    voidCallback: () => context.read<CardFieldData>().updateCardColor(list.indexOf(e), Colors.white38))),
                jeton(jetonName: e.jetonName!, jetonImage: e.image!)
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}