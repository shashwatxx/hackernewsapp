import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';

part 'json_parsing.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  static Serializer<Article> get serializer => _$articleSerializer;

  int get id;
  bool get deleted;
  String get type;
  String get by;
  int get time;
  String get text;
  bool get dead;
  int get parent;
  int get poll;
  BuiltList<int> get kids;
  String get url;
  int get score;
  String get title;
  BuiltList<int> get parts;
  int get descendants;

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
  final parsed = jsonDecode(jsonStr);
  Article article = serializers.deserializeWith(Article.serializer, parsed);
  //  Article.fromJson(parsed);
  return article;
}
