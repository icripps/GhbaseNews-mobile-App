import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghbasenews/api/categories_api.dart';
import 'package:ghbasenews/models/category.dart';
import "package:hex/hex.dart";
import 'category_posts.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  CategoriesApi categoriesapi;

  @override
  void initState() {
    super.initState();
    categoriesapi = CategoriesApi();
    categoriesapi.fetchAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(24),
          child: FutureBuilder(
            future: categoriesapi.fetchAllCategories(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return _error('No Connection was made, check your internet');
                  break;
                case ConnectionState.waiting:
                  return _loading();
                  break;
                case ConnectionState.active:
                  return _loading();
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return _error(snapshot.error.toString());
                  }
                  if (snapshot.hasData) {
                    return _drawCategories(snapshot.data, context);
                  }
                  break;
              }
              return Container();
            },
          ),
        ));
  }
}

Widget _drawCategories(List<Category> categories, BuildContext context) {
  return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int position) {
        String hexColor = categories[position].color.replaceAll('#', '0xFF');
        return Card(
            child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 2,
                child: Container(
                  color: Color(int.parse(hexColor)),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CategoryPosts(categories[position].id)));
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  categories[position].title,
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ],
        ));
      });
}

Widget _error(String error) {
  return Container(
    child: Text(error,
        style: TextStyle(color: Colors.redAccent, fontStyle: FontStyle.italic)),
  );
}

Widget _loading() {
  return Center(
    child: Container(
      child: CircularProgressIndicator(),
    ),
  );
}
