import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'ContactPage.dart';
import 'InstructionsPage.dart';
import 'PasswordModel.dart';
import 'SecurityPage.dart';
import 'database_helper.dart';
import 'PasswordDetail.dart';

class PwdList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PwdListState();
  }
}

class PwdListState extends State<PwdList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Pwd> pwdList;
  int count = 0;

  @override
  void initState(){
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  Future<bool> onWillPop() {
    return showDialog(
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
        content: Text("Do you want to exit from app?", textAlign: TextAlign.left,style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          FlatButton(
            onPressed: () => exit(0),
            child: Text('YES',style: TextStyle(color: Colors.black),),
          ),
          FlatButton(
            autofocus: true,
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('NO',style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    ) ??false;
  }

  @override
  Widget build(BuildContext context) {
    if (pwdList == null) {
      pwdList = List<Pwd>();
      updateListView();
    }
    return new WillPopScope(
      onWillPop: onWillPop,
      child: new Scaffold(
        appBar: AppBar(
          title: Text('Passwords Keeper',style: TextStyle(color: Colors.white),),backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          leading: Image.asset('assets/PasswordKeeperGif.gif',height: 15,width: 15,),
        ),
        body: getPwdListView(),
        backgroundColor: Color(0xF6F6F7FF),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.black,
          mini: false,
          onPressed: () {
            navigateToDetail(Pwd('', '', '',''), 'Add Passwords');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: this._buildBottomAppBar(context),
      ),
    );

  }

  ListView getPwdListView() {
    return ListView.builder(
      padding: EdgeInsets.all(13.0),
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        count=count;
        int index = position+1;
        return Card(
          color: Colors.black,
          elevation: 5.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.tealAccent,
              child: Text(index.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
            ),
            title: Text(this.pwdList[position].title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
            subtitle: Text(this.pwdList[position].date,style: TextStyle(color: Colors.white)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.edit,color: Colors.white,),
                  onTap: () {
                    navigateToDetail(this.pwdList[position], 'Edit Passwords');
                  },
                ),
                SizedBox(width: 20),
                GestureDetector(
                  child: Icon(Icons.delete,color: Colors.white,),
                  onTap: () {
                    _delete(context, pwdList[position]);
                  },
                ),
              ],
            ),
            onTap: null,
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, Pwd pwd) async {
    int result = await databaseHelper.deletePwd(pwd.id);
    if (result != 0) {
      _showSnackBar(context, 'Password Deleted Successfully.');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message),elevation: 1.0,duration: Duration(seconds: 3),);
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Pwd pwd, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return PwdDetail(pwd, title);
        }
      ));
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Pwd>> pwdListFuture = databaseHelper.getPwdList();
      pwdListFuture.then((pwdList) {
        setState(() {
          this.pwdList = pwdList;
          this.count = pwdList.length;
        });
      });
    });
  }

  BottomAppBar _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle() ,
      color: Colors.black,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.settings,color: Colors.tealAccent,size: 27,),
            onPressed: (){
              bottomModalSheet();
            },
          ),
          GestureDetector(
            child: Text("SETTINGS",textAlign: TextAlign.left,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            onTap: (){
              bottomModalSheet();
            },
          ),
        ],
      ),
    );
  }

  bottomModalSheet() => showModalBottomSheet(
      context: context,
      builder: (context) => Material(
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Ink(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.tealAccent,maxRadius: 18,
                                child: Text(count.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black)),
                              ),
                              Text("  Total Saved Passwords",
                                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700, color: Colors.tealAccent),
                              ),
                            ],
                          )
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel,color: Colors.tealAccent,size: 28.0,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.home,color: Colors.black,size: 22.0,),
                        title: Text('HOME',style:new TextStyle(fontSize: 15.0, color: Colors.black)),
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => PwdList()),);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.verified_user,color: Colors.black,size: 22.0,),
                        title: Text('SECURITY',style:new TextStyle(fontSize: 15.0, color: Colors.black)),
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => SecurityPage()),);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.assignment_late,color: Colors.black,size: 22.0,),
                        title: Text('INSTRUCTIONS',style:new TextStyle(fontSize: 15.0, color: Colors.black)),
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => InstructionsPage()),);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.textsms,color: Colors.black,size: 22.0,),
                        title: Text('CONTACT',style:new TextStyle(fontSize: 15.0, color: Colors.black)),
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => ContactPage()),);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        child: Divider(color: Colors.black,),
                      ),
                      ListTile(
                        leading: Image.asset('assets/PasswordKeeperLogo.png',height: 40.0,width: 40.0,),
                        title: Text('About Passwords Keeper',style:new TextStyle(fontSize: 15.0, color: Colors.black,fontWeight: FontWeight.bold)),
                        onTap: () {
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
                                height: 45,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text("Developed By :- ", textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                          Text("Mohit Agrawal.", textAlign: TextAlign.left,style: TextStyle(color: Colors.black),),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top:5),
                                      child: Row(
                                        children: <Widget>[
                                          Text("Version :- ", textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                          Text("1.0.0", textAlign: TextAlign.left,style: TextStyle(color: Colors.black),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  autofocus: true,
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: Text('CLOSE',style: TextStyle(color: Colors.black),),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  )
              ),
            ],
          )
      )
  );
}