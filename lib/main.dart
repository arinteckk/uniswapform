import 'package:flutter/material.dart';
import 'package:uniswapform/utils/utils_classes.dart';
import 'constant.dart';
import 'components/interface_form.dart';
import 'package:provider/provider.dart';

//1 ETH = 1,545.88 DAI
//1 DAI = 0.00064 ETH

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CardFieldData>(create: (context) => CardFieldData()),
      ],
      child: MaterialApp(
        title: 'Uniswap',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Constant.color),
        home:  const InterfaceForm(),
      ),
    );
  }
}