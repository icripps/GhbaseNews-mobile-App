import 'dart:convert';

import 'api_util.dart';
import 'package:ghbasenews/models/post.dart';
import 'package:http/http.dart' as http;
class PostApi{

//  Future<List<Post>> fetchRecentPost()async{
//    String post_url = ApiUtil.MAIN_API_ULR + ApiUtil.Recent_Posts;
//
//    Map<String,dynamic> headers = {
//      'Accept' : 'application/json'
//    };
//    var response = await http.get(post_url, headers: headers);
//    List<Post> posts = [];
//    if(response.statusCode == 200){
//      var data = jsonDecode(response.body);
//      for(var item in data['body']){
//        Post post =  Post.fromJson(item);
//        posts.add(post);
//      }
//    }
//    return posts;
//  }

  Future<List<Post>> fetchRecentPost()async{
    String post_url = ApiUtil.MAIN_API_ULR + ApiUtil.Recent_Posts;
    Map<String,String> headers = {
      'Accept' : 'Application/json',
    };
    var response = await http.get(post_url, headers: headers);
    List<Post> posts = [];
    if(response.statusCode == 200){
      print('we found the resourrrrrceee');
      Map<String,dynamic> body = jsonDecode(response.body);
      //print(body['data']);
      for (var item in body['data']){
        Post post = Post.fromJson(item);
        posts.add(post);
      }
    }else {
      //print('no resources found ---------');
      //print(categoryPost);
    }
    return posts;
  }

}