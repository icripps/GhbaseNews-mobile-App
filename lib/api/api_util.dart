class ApiUtil{
  static const MAIN_API_ULR = 'https://phplaravel-325799-998060.cloudwaysapps.com/api';

  static const ALL_CATEGORIES = '/categories';

  static const  Recent_Posts = '/posts';

  static categoryPost(String categoryID){
        return MAIN_API_ULR + ALL_CATEGORIES+ '/' + categoryID + '/posts';
  }
}