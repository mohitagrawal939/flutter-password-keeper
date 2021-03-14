import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import 'PasswordList.dart';

class InstructionsPage extends StatelessWidget {
  final pages = [
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      bubbleBackgroundColor: Colors.black,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text('Welcome to smart passwords Keeper'.toUpperCase(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
          SizedBox(height:7.0),
          Text('Store your ID\'s, Passwords, ATM Pins, Cards, Account Numbers & Lot More.',
            style: TextStyle(color: Colors.black54,fontSize: 16.0),
          ),
        ],
      ),
      mainImage: Image.asset('assets/PasswordKeeper1.png',width: 285.0,alignment: Alignment.center,),
      textStyle: TextStyle(color: Colors.black),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      iconColor: null,
      bubbleBackgroundColor: Colors.black,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text('Works offline completely'.toUpperCase(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
          SizedBox(height:5.0),
          Text('Store your all important pins along with ID\'s Offline and organize your smart passwords keeper.',
            style: TextStyle(color: Colors.black54,fontSize: 16.0),
          ),
        ],
      ),
      mainImage: Image.asset('assets/PasswordKeeper2.png',width: 285.0,alignment: Alignment.center,),
      textStyle: TextStyle(color: Colors.black),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      iconColor: null,
      bubbleBackgroundColor: Colors.black,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text('Stores Locally & 100% secure'.toUpperCase(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
          SizedBox(height:5.0),
          Text('Organize your ID\'s & Passwords and get access to passwords anytime anywhere.',
            style: TextStyle(color: Colors.black54,fontSize: 16.0),
          ),
        ],
      ),
      mainImage: Image.asset('assets/PasswordKeeper3.png',width: 285.0,alignment: Alignment.center),
      textStyle: TextStyle(color: Colors.black),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PwdList()));
        },
        child: new Scaffold(
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                IntroViewsFlutter(
                  pages,
                  onTapDoneButton: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => PwdList()),);
                  },
                  showSkipButton: false,
                  doneText: Text("DONE",),
                  pageButtonsColor: Colors.black,
                  pageButtonTextStyles: new TextStyle(fontSize: 16.0,fontFamily: "Regular",),
                ),
                Positioned(
                    top: 20.0,
                    left: MediaQuery.of(context).size.width/2 - 40,
                    child: Image.asset('assets/PasswordKeeperLogo.png', width: 80,)
                )
              ],
            ),
          ),
        )
    );
  }
}