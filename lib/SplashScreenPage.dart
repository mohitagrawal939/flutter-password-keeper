import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'PasswordList.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => new _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  startTime() async {
    var _duration = new Duration(seconds: 7);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(context,MaterialPageRoute(builder: (context) => PwdList()),);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new Center(
        child: new Image.asset('assets/PasswordKeeperGifSS.gif'),
      ),
        bottomNavigationBar:BottomAppBar(
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.08,),
            child: Text("PASSWORDS KEEPER",textAlign: TextAlign.center,style: TextStyle(color: Colors.tealAccent,fontWeight: FontWeight.bold,fontSize: 25),),
          )
        ),
    );
  }
}