import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghbasenews/screens/category_lists.dart';
import 'api/categories_api.dart';
import 'models/category.dart';
import 'screens/category_posts.dart';
import 'screens/HomeScreen.dart';

void main() {
  runApp(ghbaseNews());
}

class ghbaseNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (BuildContext context) => HomeScreen(),
        '/categories' : (BuildContext context) => CategoriesList()
      },
    );
  }
}
//
//class HomeScreen extends StatefulWidget {
//  @override
//  _HomeScreenState createState() => _HomeScreenState();
//}
//
//class _HomeScreenState extends State<HomeScreen> {
//  CategoriesApi categoriesapi;
//
//  @override
//  void initState() {
//    super.initState();
//    categoriesapi = CategoriesApi();
//    categoriesapi.fetchAllCategories();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('GhBaseNews'),
//          centerTitle: true,
//        ),
//        body: Container(
//          padding: EdgeInsets.all(24),
//          child: FutureBuilder(
//            future: categoriesapi.fetchAllCategories(),
//            builder:
//                (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
//              switch (snapshot.connectionState) {
//                case ConnectionState.none:
//                  return _error('No Connection was made, check your internet');
//                  break;
//                case ConnectionState.waiting:
//                  return _loading();
//                  break;
//                case ConnectionState.active:
//                  return _loading();
//                  break;
//                case ConnectionState.done:
//                  if (snapshot.hasError) {
//                    return _error(snapshot.error.toString());
//                  }
//                  if (snapshot.hasData) {
//                    return _drawCategories(snapshot.data, context);
//                  }
//                  break;
//              }
//              return Container();
//            },
//          ),
//        )
//    );
//  }
//}
//
//Widget _drawCategories(List<Category> categories, BuildContext context) {
//  return ListView.builder(
//      itemCount: categories.length,
//      itemBuilder: (BuildContext context, int position) {
//        return Padding(
//          padding: EdgeInsets.only(left: 16, right: 16),
//          child: InkWell(
//            child: Card(
//              child: Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Text(categories[position].title),
//              ),
//            ),
//            onTap: () {
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) =>
//                          CategoryPosts(categories[position].id)));
//            },
//          ),
//        );
//      });
//}
//
//Widget _error(String error) {
//  return Container(
//    child: Text(error,
//        style: TextStyle(color: Colors.redAccent, fontStyle: FontStyle.italic)),
//  );
//}
//
//Widget _loading() {
//  return Center(
//    child: Container(
//      child: CircularProgressIndicator(),
//    ),
//  );
//}
