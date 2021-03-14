import 'dart:async';
import 'package:flutter/material.dart';
import 'PasswordModel.dart';
import 'database_helper.dart';
import 'package:intl/intl.dart';

class PwdDetail extends StatefulWidget {
  final String appBarTitle;
  final Pwd pwd;
  PwdDetail(this.pwd, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return PwdDetailState(this.pwd, this.appBarTitle);
  }
}

class PwdDetailState extends State<PwdDetail> {
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Pwd pwd;
  TextEditingController titleController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  PwdDetailState(this.pwd, this.appBarTitle);
  bool _obscureText = true;
  bool passwordVisible = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = pwd.title;
    usernameController.text = pwd.username;
    passwordController.text = pwd.password;
    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                moveToLastScreen();
              }
            ),
          ),
          backgroundColor: Color(0xF6F6F7FF),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: new TextFormField(
                    controller: titleController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: 'TITLE',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                    onChanged: (value) {
                      updateTitle();
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: new TextFormField(
                    controller: usernameController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: 'USERNAME',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                    onChanged: (value) {
                      updateUsername();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: new TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    obscureText: _obscureText,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'PASSWORD',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: _toggle,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                    onChanged: (value) {
                      updatePassword();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child:RaisedButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          elevation: 15,
                          color: Colors.tealAccent,
                          textColor: Colors.black,
                          child: Row( mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Save  ",textScaleFactor: 1.3,),
                              Icon(Icons.done_all),
                            ],
                          ),
                          onPressed: () {
                            if(titleController.text.isEmpty){
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.of(context).pop(true);
                                    });
                                    return new WillPopScope(
                                        onWillPop: () async => true,
                                        child: SimpleDialog(
                                            backgroundColor: Colors.black,
                                            children: <Widget>[
                                              Center(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.error,color: Colors.tealAccent,),
                                                    SizedBox(height: 30,width: 10,),
                                                    Text("Title is required",style: TextStyle(color: Colors.tealAccent),)
                                                  ],
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                ),
                                              )
                                            ]
                                        )
                                    );
                                  }
                              );
                            }else{
                              setState(() {
                                _save();
                              });
                            }
                          },
                        ),
                      ),
                      Container(width: 15.0,),
                      Expanded(
                        child:RaisedButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          elevation: 15,
                          color: Colors.black,
                          textColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Delete  ",textScaleFactor: 1.3,),
                              Icon(Icons.delete_forever),
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateTitle(){
    pwd.title = titleController.text;
  }

  void updateUsername() {
    pwd.username = usernameController.text;
  }

  void updatePassword() {
    pwd.password = passwordController.text;
  }

  void _save() async {
    moveToLastScreen();
    pwd.date = DateFormat("dd-MM-yyyy / kk:mm").format(DateTime.now());
    int result;
    if (pwd.id != null) {
      result = await helper.updatePwd(pwd);
    } else {
      result = await helper.insertPwd(pwd);
    }

    if (result != 0) {
      _showAlertDialog('Password Saved Successfully');
    } else {
      _showAlertDialog1('Problem Saving Password');
    }
  }


  void _delete() async {
    moveToLastScreen();
    if (pwd.id == null) {
      _showAlertDialog('No Password was deleted');
      return;
    }

    int result = await helper.deletePwd(pwd.id);
    if (result != 0) {
      _showAlertDialog('Password Deleted Successfully');
    } else {
      _showAlertDialog1('Error Occured while Deleting Password');
    }
  }

  void _showAlertDialog(String message) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Row(
                        children: [
                          Icon(Icons.check_circle,color: Colors.black,),
                          SizedBox(height: 30,width: 10,),
                          Text("$message",style: TextStyle(color: Colors.black),)
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    )
                  ]
              )
          );
        }
    );
  }

  void _showAlertDialog1(String message) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Row(
                        children: [
                          Icon(Icons.error,color: Colors.black,),
                          SizedBox(height: 30,width: 10,),
                          Text("$message",style: TextStyle(color: Colors.black),)
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    )
                  ]
              )
          );
        }
    );
  }
}