import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghbasenews/api/post_api.dart';
import 'package:ghbasenews/models/post.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PostApi postApi = PostApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text('Header'),
            ),
            ListTile(
              title: Text('Categories'),
              onTap: () {
//                Navigator.of(context).pop();
//                Navigator.pushNamed(context, '/categories');
                Navigator.popAndPushNamed(context, '/categories');
              },
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: postApi.fetchRecentPost(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return __error('No connection could bemade');
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return __loading();
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return __error(snapshot.error.toString());
              }
              if (!snapshot.hasData) {
                return __error('No Data was recived');
              }
              return _drawHomScreen(snapshot.data);
              break;
          }
          return Container();
        },
      ),
    );
  }

  Widget _drawHomScreen(List<Post> posts) {
    List<Post> postwithImages = [];
    for (var post in posts) {
      if (post.images.length > 0) {
        postwithImages.add(post);
      }
    }
    return Column(
      children: <Widget>[
        _slider(postwithImages),
        _postList(posts),
      ],
    );
  }

  Widget _slider(List<Post> posts) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: PageView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int position) {
            return InkWell(
              onTap: () => debugPrint(posts[position].post_title),
              //Todo: goto single post screen,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(posts[position].images[0].image_url),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.grey.withAlpha(100),
                      child: Text(
                        posts[position].post_title,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget __loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget __error(String error) {
    return Container(
      child: Center(
        child: Text(
          error,
          style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }

  Widget _postList(List<Post> posts) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                child: InkWell(
                  onTap: () => debugPrint(posts[position].post_title),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(posts[position].post_title, style: TextStyle(
                          fontSize: 24.4,
                          color: Colors.teal
                        ),),
                        SizedBox(height: 18,),
                        Text('By: ${posts[position].author.first_name} ${posts[position].author.last_name}'
                        , style: TextStyle(fontStyle: FontStyle.italic),)
//                      ListTile(
////                leading: posts[position].images[0].image_url != null
////                    ? CircleAvatar(
////                        backgroundImage:
////                            NetworkImage(posts[position].images[0].image_url),
////                      )
////                    : CircleAvatar(
////                        child: Text(posts[position].post_title[0]),
////                      ),
////                title: Text(posts[position].post_title),
//                      ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
