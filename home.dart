import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/product.dart';
import 'model/product_repositories.dart';
import 'chatscreen.dart';


class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NEXT_SCREEN',
      home: new Scaffold(
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
        body: new HomePage(),
      ),

    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<GestureDetector> _buildGridCards(BuildContext context) {
      List<Product> products = ProductsRepository.loadProducts(Category.all);
      if (products == null || products.isEmpty) {
        return const <GestureDetector>[];
      }
      final ThemeData theme = Theme.of(context);
      final NumberFormat formatter = NumberFormat.simpleCurrency(
          locale: Localizations.localeOf(context).toString());
      return products.map((product) {
        return GestureDetector(
            onTap: tap,
            child: Card(
              color: Colors.lightGreen,
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(100.0),
//          ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 19 / 11,
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
//                        shape: BoxShape.circle,
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
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.name,
                            style: theme.textTheme.title,
                            maxLines: 1,
                          ),
                          SizedBox(height: 8.0,),
                          Text('Hey...'
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
      }).toList();
    }
    return MaterialApp(
        title: 'HOMEPAGE',
        home: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(16.0),
            childAspectRatio: 8.0 / 9.0,
            children: _buildGridCards(context)
        )
    );
  }

  void tap() {
    Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.cyan,
            appBar: new AppBar(
              title: new Text('VAGABOND'),

            ),
            body: new load(),
          );
        }
    ));
  }
}



