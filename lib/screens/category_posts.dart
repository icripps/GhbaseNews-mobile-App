import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghbasenews/api/categories_api.dart';
import 'package:ghbasenews/models/post.dart';

class CategoryPosts extends StatefulWidget {
  final String categoryID;
  CategoryPosts(this.categoryID);

  @override
  _CategoryPostsState createState() => _CategoryPostsState();
}

class _CategoryPostsState extends State<CategoryPosts> {
  CategoriesApi categoriesApi = CategoriesApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: categoriesApi.fetchPostsForCategory(widget.categoryID),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
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
                  return _drawPostLists(snapshot.data);
                }
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _error(String error) {
    return Container(
      child: Center(
        child: Text(
          error,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _drawPostLists(List<Post> posts) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int position) {
            return InkWell(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(posts[position].post_title),
                ),
              ),
              onTap: () {
                //go to a simple news page
              },
            );
          }),
    );
  }
}
