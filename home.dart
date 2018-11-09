import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/product.dart';
import 'model/product_repositories.dart';
import 'chatscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class NextPage extends StatelessWidget {
  String _username;
  @override
  NextPage(String username){
    _username = username;
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NEXT_SCREEN',
      home:
      new HomePage(_username),
    );
  }
}

class HomePage extends StatefulWidget {
  String _username;
  HomePage(final username){
    _username = username;
  }
  @override
  _HomePageState createState() => _HomePageState(_username);
}

class _HomePageState extends State<HomePage> {
  String _username;
  _HomePageState(String username){
    _username = username;
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> _buildGridCards(BuildContext context, List<DocumentSnapshot> snapshot) {
      final ThemeData theme = Theme.of(context);
      return snapshot.map((data) => _buildCards(context,data,theme,_username)).toList();
    }
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: new AppBar(
        title: const Text('CHATS'),
        backgroundColor: new Color(0xFFF84934),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu Button');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search Button');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              print('Filter button');
            },
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          child: new Icon(
            Icons.add,
          ),
          shape: new CircleBorder(),
//            elevation: 100.0,
          onPressed: null

      ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('users').snapshots(),
          builder: (context, snapshot){
            return GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16.0),
                childAspectRatio: 8.0 / 9.0,
             children: _buildGridCards(context,snapshot.data.documents)
        );
          },
        ),
    );
  }
  Widget _buildCards(BuildContext context, DocumentSnapshot data,ThemeData theme,String username){
//    final record = Record.fromSnapshot(data);
    if(data.data['username'] != username) {
      return InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  backgroundColor: Colors.cyan,
                  body: new load(data.data['username'],username,data.data['name']),
                );
              }
          )),
//          tap(),
//          tap(data.data['username'],username,data.data['name']),
          child: Card(
            color: Colors.lightGreen,
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(100.0),
//          ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://preview.ibb.co/e07xAp/img.png'),
                        )
                    ),
                  ),
//                  child: Image.network(
//                    'https://preview.ibb.co/e07xAp/img.png',
//                    fit: BoxFit.cover,
//                  ),
//                child: Image.asset(
//                  product.assetName,
//                  package: product.assetPackage,
//                ),
                SizedBox(height: 5.0,),
                Container(
                  height: 67.0,
                  width: 140.0,
                  color: Colors.indigo,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.data['name'],
                          style: theme.textTheme.title,
                          maxLines: 1,
                        ),
                        SizedBox(height: 8.0,),
                        Text('Hey',
//                        formatter.format(product.price),
//                        style: theme.textTheme.body2,
                        )
                      ],
                    ),),
                )
              ],
            ),
          )
      );
    }
    else
      return Container();
  }

  tap() {
    print('abcde');
  }
//  void tap(String test){
//    print(test + '___');
//    print('abcd');
//  }
//   tap(String chat_with,String me,String name) {
//    Navigator.push(context, MaterialPageRoute<void>(
//        builder: (BuildContext context) {
//          return Scaffold(
//            backgroundColor: Colors.cyan,
//            appBar: new AppBar(
//              title: new Text(name),
//
//            ),
//            body: new load(chat_with,me),
//          );
//        }
//    ));
//  }
}



