import 'package:built_value/built_value.dart';

part 'json_parsing.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  int get id;

  Article._();
  factory Article([void Function(ArticleBuilder) updates]) = _$Article;
}

//class Article {
//  final String text;
//  final String url;
//  final String by;
//  final int time;
//  final int score;
//
//  const Article({this.text, this.url, this.by, this.time, this.score, s});
//
//  factory Article.fromJson(Map<String, dynamic> json) {
//    if (json == null) return null;
//    return Article(
//      text: json['text'] ?? '[null]',
//      url: json['url'],
//      time: json['age'] ?? 0,
//      by: json['by'],
//      score: json['score'],
//    );
//  }
//}

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
