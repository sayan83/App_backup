import 'package:flutter/material.dart';
import 'home.dart';
import 'signupscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to flutter...',
      home: new Scaffold(
        backgroundColor: Colors.amberAccent,
//        appBar: new AppBar(
//          title: const Text('LETsCHAT APP'),
//          backgroundColor: new Color(0xFFF83748),
//          centerTitle: true,
//          elevation: 16.7,
//          bottomOpacity: 117.0,
//
//        ),
        body: new Center(
          child: new RandomWords(),
        ),
      ),
    );
  }
}
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);
//    final List<WordPair> _suggestions = <WordPair>[];
//    final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
      return Scaffold(
        backgroundColor: Colors.cyan,
        body: SafeArea(
            child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 10.0),
                Column(
                  children: <Widget>[
                    Image.asset('assets/diamond.png'),
                    SizedBox(height: 10.0),
                    Text('LETsCHAT', textScaleFactor: 3.0),
                    SizedBox(height: 40.0),

                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
//                        filled: true,
                        border: OutlineInputBorder(),
                        fillColor: new Color(0xFFF83748434),
                        hintText: 'Do not enter password here',
                        labelText: 'USERNAME',
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
//                        filled: true,
                          border: OutlineInputBorder(),
                        labelText: 'PASSWORD',
                        hintText: 'DO NOT ENTER USERNAME HERE',
                        fillColor: new Color(0xFFF843759),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text('CANCEL'),
                      onPressed: (){
                      _usernameController.clear();
                      _passwordController.clear();
                },
                ),
                RaisedButton(
                  child: Text('NEXT'),
                  color: new Color(0xFFFBB8AC),
                  elevation: 5.0,
                  onPressed: () async{
//                    Navigator.pop(context);
                  final result = await Firestore.instance.collection('users').document(_usernameController.text).get();
                    if(result.exists && _usernameController.text == result.data['username'] && _passwordController.text == result.data['password']) {
                      Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return Scaffold(
                              body: new NextPage(_usernameController.text),
                            );
                          }
                      ));
                    }
                    else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: new Text("ENTER CORRECT DATA"),
                            content: new Text("Please enter valid username and password"),
                            actions: <Widget>[
                              new RaisedButton(
                                   child : new Text("OK"),
                                  onPressed: () {
                                    _passwordController.clear();
                                    _usernameController.clear();
                                    Navigator.pop(context);
                                  }
                              )
                            ],
                          );
                        }
                      );
                    }
                },
                ),
              ],
        ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                  child: Text('CREATE NEW ACCOUNT'),
                  color: Colors.greenAccent,
                  elevation: 5.0,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context){
                      return new Scaffold(
                        appBar: new AppBar(
                          title: new Text('CREATE NEW ACCOUNT'),
                          backgroundColor: Colors.deepOrange,
                        ),
                        body: new signup(),
                      );
                    }
                        ),
                    );
                  },

                ),
                  ],
                )
    ]
        ),
      )
        );
  }
}
