import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobigic/Widgets/custom_loader.dart';
import '../../../Widgets/custom_Text.dart';
import 'HomePage.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  bool isLoading = false;
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return Timer(_duration,
            () async{
              setState(() {
                isLoading = true;
              });

              Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));

              setState(() {
                isLoading = false;
              });
            });
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 85,
            margin: const EdgeInsets.only(top: 88, bottom: 64),
            child: Icon(Icons.grid_view_outlined, size: 50, color: Colors.purple,),
          ),

          Center(
            child: const Txt(
              text: 'Welcome to Grid Creation!!',
              textAlign: TextAlign.center,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),

          Container(
            height: 268,
            width: 258,
            margin: const EdgeInsets.only(top: 31, bottom: 36),
           child: CustomLoader(color: Colors.purple, size: 100,),
          ),

        ],
      ),
    );
  }
}


