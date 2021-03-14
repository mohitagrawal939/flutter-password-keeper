import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:system_setting/system_setting.dart';
import 'PasswordList.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

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
          title: new Text("Contact", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PwdList()));
            },
          ),
        ),
        backgroundColor: Color(0xF6F6F7FF),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              contactInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactInfo(BuildContext context){
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  height: 110,
                  margin: EdgeInsets.only(top: 40),
                child: Image.asset('assets/PasswordKeeperLogo.png',height: 115,width: 115,),
              ),
              Padding(padding: EdgeInsets.all(4),),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(10),
                child: Card(
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              padding:EdgeInsets.only(top: 15, bottom: 15),
                              child: Text('PASSWORDS KEEPER'.toUpperCase(),
                                  style: TextStyle(color: Colors.tealAccent,fontWeight: FontWeight.bold,fontSize: 18.0,letterSpacing: 2)
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("For Support Please Contact",
                                style: TextStyle(color: Colors.tealAccent,fontWeight: FontWeight.w500,fontSize: 18,),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Divider(color: Colors.tealAccent),
                            Container(
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      child: ListTile(
                                        contentPadding:EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        leading: Icon(Icons.phone,color: Colors.tealAccent,size: 20,),
                                        title: Text("Call",style: TextStyle(color: Colors.tealAccent,fontSize: 18),),
                                        trailing: Icon(Icons.arrow_forward,color: Colors.tealAccent,size: 20,),
                                      ),
                                      onTap:  _callMe,
                                    ),
                                    GestureDetector(
                                      child: ListTile(
                                        contentPadding:EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        leading: Icon(Icons.mail,color: Colors.tealAccent,size: 20,),
                                        title: Text("Mail",style: TextStyle(color: Colors.tealAccent,fontSize: 18),),
                                        trailing: Icon(Icons.arrow_forward,color: Colors.tealAccent,size: 20,),
                                      ),
                                      onTap: _launchEmail,
                                    ),
                                    GestureDetector(
                                      child: ListTile(
                                        contentPadding:EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        leading: Icon(Icons.language,color: Colors.tealAccent,size: 20,),
                                        title: Text("Website",style: TextStyle(color: Colors.tealAccent,fontSize: 18),),
                                        trailing: Icon(Icons.arrow_forward,color: Colors.tealAccent,size: 20,),
                                      ),
                                      onTap:  (){
                                        showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) => AlertDialog(
                                            title: Container(
                                              height: 40.0,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 40,
                                                          width: 40,
                                                          child: Image.asset('assets/PasswordKeeperLogo.png'),
                                                        ),
                                                        SizedBox(width: 15),
                                                        Container(
                                                          child: Text("Passwords Keeper", textAlign: TextAlign.left,style: TextStyle(color: Colors.black),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            content: Container(
                                              height: 85,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    child: Text("In order to open website make sure that your are connected to Network Connection.",textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0),),
                                                  ),
                                                  Container(
                                                    child: Text("\n(If already connected ignore this alert.)",style: TextStyle(fontSize: 12,color: Colors.black),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () => Navigator.of(context).pop(false),
                                                child: Text('CLOSE',style: TextStyle(color: Colors.black),),
                                              ),
                                              FlatButton(
                                                onPressed: _jumpToSetting,
                                                child: Text('SETTINGS',style: TextStyle(color: Colors.black),),
                                              ),
                                              FlatButton(
                                                autofocus: true,
                                                onPressed: _launchWebURL,
                                                child: Text('OPEN',style: TextStyle(color: Colors.black),),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                            )
                          ],
                        ),
                      ),color: Colors.black,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      )
    );
  }

  _jumpToSetting() {
    SystemSetting.goto(SettingTarget.WIFI);
  }

  _callMe() async {
    const uri = 'tel:+91 7774967429';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      const uri = 'tel:077-74-967-429';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  _launchEmail() async {
    final String subject = "Subject: Passwords Keeper Support";
    final String stringText = "Message: Type Your Message Here & Add Screenshots Here To Rectify Issue...";
    String uri = 'mailto:mohitagrawal939@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(stringText)}';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print("No email client found");
    }
  }

  _launchWebURL() async {
    const url = 'https://bit.ly/mohitagrawal';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
