import 'package:ghbasenews/models/author.dart';
import 'package:ghbasenews/models/category.dart';
import 'package:ghbasenews/models/post_comment.dart';
import 'package:ghbasenews/models/post_image.dart';
import 'package:ghbasenews/models/post_tag.dart';

class Post {
  String post_id, post_title, post_content, post_type;

  String updated_at;
  List<PostImage> images;
  List<PostTag> tags;
  List<PostComment> comments;
  Author author;
  Category category;

  Post(this.post_id, this.post_title, this.post_content, this.post_type,
      this.updated_at, this.author,this.images,this.tags,this.category);

  Post.fromJson(Map<String, dynamic> jsonObject) {

    this.post_id = jsonObject['post_id'].toString();
    this.post_title = jsonObject['post_title'];
    this.post_content = jsonObject['post_content'];
    this.post_type = jsonObject['post_type'];
    this.updated_at = jsonObject['updated_at'];
    this.images = [];
    for(var item in jsonObject['images']){
      this.images.add(PostImage.fromJSon(item));
    }
//    this.images = jsonObject['images'].map(( Map<String,dynamic> jsonImage){
//      return PostImage.fromJSon(jsonImage);
//    }).toList();
    this.author = Author.fromJson(jsonObject['author']);
    this.tags = [];
    for(var item in jsonObject['tags']){
      this.tags.add(PostTag.fromJson(item));
    }
//    this.tags = jsonObject['tags'].map((Map<String,dynamic> jsonTag){
//      return PostTag.fromJson(jsonTag);
//    }).toList();
    this.comments = [];
    for(var item in jsonObject['comments']){
      this.comments.add(PostComment.fromJson(item));
    }
//    this.comments = jsonObject['comments'].map((Map<String,dynamic> jsonComment){
//      return PostComment.fromJson(jsonComment);
//    }).toList();
    this.category = Category.fromJson(jsonObject['category']);
  }
}
