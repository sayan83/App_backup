import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class load extends StatefulWidget {
  String _chatwith, _me,_name;
  load(String chatwith, String me,name){
    _chatwith = chatwith;
    _me = me;
    _name = name;
  }
  @override
  _loadState createState() => _loadState(_chatwith,_me,_name);
}

class _loadState extends State<load> {
    String _chatwith, _me,_name;
    _loadState(String chatwith,String me,String name){
      _chatwith = chatwith;
      _me = me;
      _name = name;
    }
    List<String> Litems = [];
  @override
  Widget build(BuildContext context) {
    String chatID = (_chatwith.compareTo(_me) == 1?'${_me} ${_chatwith}':'${_chatwith} ${_me}');
    for(int i =0;i<100;i++){
      Litems.add(i.toString());
    }
    return MaterialApp(
      home: new Scaffold(
      backgroundColor: Colors.white,
        appBar: new AppBar(
        title: new Text(_name),
        ),
        drawer: new Scaffold(
          backgroundColor: Colors.cyan,
          body: new Center(
             child: new Text("This is the chat screen. Browse through previous chats or start a new one :)",style: Theme.of(context).textTheme.headline,),
        ),
        ),
        body: new Column(
//          height: 550.0,
        children: <Widget>[
          new Container(
        height: 550.0,
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('messages').where('chatID',isEqualTo: chatID).limit(20).snapshots(),
            builder: (context, snapshot){
              return ListView.builder(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  itemCount: Litems.length,
                  itemBuilder: (BuildContext ctxt, int index){
                    return ListTile(

                      title: Text(Litems[index]),
                      trailing: new Text('Hey...',style: Theme.of(context).textTheme.headline,),
                    );
//                new Text(Litems[index]);
                  }
              );
            }
            )

          ),
          SizedBox(height: 15.0),
          new TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Message Here...'
            ),
          ),
        ]
        )
    )
    );
  }
}