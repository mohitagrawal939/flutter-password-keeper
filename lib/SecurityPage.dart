import 'package:flutter/material.dart';
import 'PasswordList.dart';

class SecurityPage extends StatefulWidget {
  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PwdList()));
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Security", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PwdList()));
            },
          ),
        ),
        backgroundColor: Color(0xF6F6F7FF),
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15, bottom: 60, left: 18, right: 0),
                  color: Colors.tealAccent,
                  child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text("Security & Privacy",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ]
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16.0, 50.0,16.0,16.0),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25.0)
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.security,color: Colors.tealAccent,size: 40,),
                        title: Text("Passwords Keeper Security & Privacy ", style: TextStyle(color: Colors.tealAccent,fontSize: 16,fontWeight: FontWeight.bold),),
                        subtitle: Text("Updated on 15th Mar, 2020",style: TextStyle(color: Colors.tealAccent,fontStyle: FontStyle.italic,fontSize: 14),),
                      ),
                      SizedBox(height: 15.0),
                      Divider(color: Colors.tealAccent,),
                      SizedBox(height: 20.0,),
                      Text("        This application collects personal data but never shares with other person or particular. Although this appliction works totally offline (Works with network connection also) so no worry about data penetration.\n\n        This application stores data locally 100% so their is least amount of risk to violate security policy until someone connects mobile with other devices with or without permission of the owner. \n\n        Usually accessing local data is not easy but some third party applications tries to collect data. This application doesn't require any permission from mobile or with other application. This application shall replace the visuals used in it against copyright owner request.\n\n        The data stored in this application is non transferable and uninstalling application erases all data saved against the application. We recommened you to take backup before uninstalling.",
                        textAlign: TextAlign.justify,style: TextStyle(color: Colors.tealAccent,fontSize: 15),),
                      SizedBox(height: 30.0),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.copyright,color: Colors.tealAccent,size: 16,),
                            Text(" 2020 | By Mohit Agrawal",style: TextStyle(color: Colors.tealAccent,fontSize: 15),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text("Your Privacy Matters...",textAlign: TextAlign.left,style: TextStyle(color: Colors.tealAccent,fontSize: 15,fontStyle: FontStyle.italic),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}