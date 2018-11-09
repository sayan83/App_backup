import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';

class signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new signuppage(),
    );
  }
}

class signuppage extends StatefulWidget {
  @override
  _signuppageState createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
      body: new ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(height: 100.0,),
          TextField(
            controller: _name,
            decoration: InputDecoration(
                hintText: 'MyName',
                border: OutlineInputBorder(),
                labelText: 'ENTER YOUR NAME'
            ),
            focusNode: FocusNode(),
          ),
          SizedBox(height: 20.0,),
          TextField(
            controller: _username,
            decoration: InputDecoration(
                hintText: 'mYuSERNAME',
                labelText: 'ENTER USERNAME',
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 20.0,),
          TextField(
            controller: _password,
            decoration: InputDecoration(
              labelText: 'CHOOSE YOUR PASSWORD',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          SizedBox(height: 5.0,),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                  onPressed: (){
                    _name.clear();
                    _password.clear();
                    _username.clear();
                  },
                  child: new Text('CANCEL')
              ),
              RaisedButton(
                child: new Text('CREATE ACCOUNT'),
                elevation: 5.0,
                color: new Color(0xFFFBB8AC),
                onPressed: (){
                  String name = _name.text;
                  String password = _password.text;
                  String username = _username.text;
//                  createAccount(_name.text ,_password.text,_username.text,context);
                  if(name != '' && password != '' && username != ''){
                    print('dbentry...............................................');
                    debugPrint('dbentry.............................................');
                    bool exist;
                      void check() async {
                        final result = await Firestore.instance
                            .collection('users')
                            .document(username).get();
                        print(result.exists);
                        print('-------------');
                        exist = result.exists;
//                      return result;
//                      final List<DocumentSnapshot> documents = result.data['username'];
                        print('!!!!' + exist.toString());
                        if (!exist) {
                          print('writingdata.............');
                          Firestore.instance.collection('users').document(
                              username).setData(
                              {
                                'name': name,
                                'username': username,
                                'password': password
                              }
                          );
                          Scaffold.of(context).showSnackBar(
                            new SnackBar(
                              content: const Text('Account creation Successful'),
                              action: SnackBarAction(
                                  label: 'SIGN IN', onPressed: () {
                                Navigator.pop(context);
                                _name.clear();
                                _username.clear();
                                _password.clear();
                                Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context){
                                  return RandomWords();
                                }));
                              }),
                            )
                          );
                        }
                        else {
                          print('towards alert dialog............');
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: new Text("Username Already taken"),
                                  actions: <Widget>[
                                    RaisedButton(
                                        child: new Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }
                                    )
                                  ],
                                );
                              }
                          );
                        }
                      }
                      check();
                  }
                  else {
                    print('invalid entry.........................................................');
                    debugPrint('invalid entry..........................................................');
//                    Navigator.push(context, MaterialPageRoute<void>(
                  showDialog(context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                        title: new Text('Please enter valid data'),
                        actions: <Widget>[
                          RaisedButton(
                            child: new Text('OK'),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                        }
                  );
//                    )
//                    );
                  }
                },
              )
            ],
          )
        ],
      ),
    )
    );
  }
}

//void createAccount(String name, String password, String username,BuildContext context) {
//  if(name != null && password != null && username != null){
//    final result = Firestore.instance.collection('users').document(username).documentID;
//    if(result == null){
//      Firestore.instance.collection('users').document(username).setData(
//        {'name': name, 'username' : username, 'password': password}
//      );
//      SnackBar(
//          content: const Text('Account creation Successful'),
//        action: SnackBarAction(label: 'SIGN IN', onPressed: (){Navigator.pop(context);}),
//      );
//    }
//    else{
//         AlertDialog(
//          title: new Text("Username Already taken"),
//          actions: <Widget>[
//            RaisedButton(
//                child: new Text('OK'),
//                onPressed: (){
//                  Navigator.pop(context);
//                }
//            )
//          ],
//        );
//    }
//
//  }
//  else {
//     AlertDialog(
//      title: new Text('Please enter valid data'),
//      actions: <Widget>[
//        RaisedButton(
//          child: new Text('OK'),
//          onPressed: (){
//            Navigator.pop(context);
//          },
//        )
//      ],
//    );
//  }
//}
