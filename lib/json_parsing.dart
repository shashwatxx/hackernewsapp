import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'json_parsing.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  int get id;

deleted
type
by
time
text
dead
parent
poll
kids  
url
score
title
parts
descendants
  Article._();
  factory Article([void Function(ArticleBuilder) updates]) = _$Article;
}




List<int> parseTopStories(String jsonStr) {
//  return List<int>();
  return [];
//  final parsed = jsonDecode(jsonStr);
//  final listOFIds = List<int>.from(parsed);
//  return listOFIds;
}

Article parseArticle(String jsonStr) {
  return null;
//  final parsed = jsonDecode(jsonStr);
//  Article article = Article.fromJson(parsed);
//  return article;
}
