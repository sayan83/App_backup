import 'package:flutter/material.dart';

class load extends StatefulWidget {
  @override
  _loadState createState() => _loadState();
}

class _loadState extends State<load> {
    List<String> Litems = [];
  @override
  Widget build(BuildContext context) {
    for(int i =0;i<100;i++){
      Litems.add(i.toString());
    }
    return MaterialApp(
      home: new Scaffold(
      backgroundColor: Colors.white,

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
        child: ListView.builder(
            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
            itemCount: Litems.length,
            itemBuilder: (BuildContext ctxt, int index){
              return ListTile(

                title: Text(Litems[index]),
                trailing: new Text('Hey...',style: Theme.of(context).textTheme.headline,),
              );
//                new Text(Litems[index]);
            }
        ),
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