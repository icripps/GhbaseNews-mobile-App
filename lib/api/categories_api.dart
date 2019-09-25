import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghbasenews/models/category.dart';
import 'package:ghbasenews/models/post.dart';
import 'package:http/http.dart' as http;
import 'api_util.dart';
class CategoriesApi{

  Future<List<Category>> fetchAllCategories() async {

    String allCategories = ApiUtil.MAIN_API_ULR + ApiUtil.ALL_CATEGORIES;
    Map<String,String> headers = {
      'Accept' : 'Application/json',
    };
    var response = await http.get(allCategories, headers: headers);
    
    List<Category> categories = [];
    if( response.statusCode ==200){
      Map<String,dynamic> body = jsonDecode(response.body);
      for(var item in body['data']){
        Category category = Category.fromJson(item);
        categories.add(category);
      }
    }

    return categories;
  }

  Future<List<Post>> fetchPostsForCategory( String categoryID) async{
      String categoryPost = ApiUtil.categoryPost(categoryID);
      Map<String,String> headers = {
        'Accept' : 'Application/json',
      };
      var response = await http.get(categoryPost, headers: headers);
      List<Post> posts = [];
      if(response.statusCode == 200){
        //print('we found the resourrrrrceee');
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