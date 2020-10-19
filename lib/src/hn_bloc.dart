import 'dart:collection';

import 'package:hackernewsapp/src/article.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class HackerNewsBloc {
  // ignore: close_sinks
  final _articlesSubject = BehaviorSubject<List<Article>>();

  var _articles = <Article>[]; //for caching

  List<int> _ids = [
    24799660,
    24789865,
    24817304,
    24798302,
    24791357,
    24790055,
    24800037,
    24795375,
    24797423,
    24808071,
    24793170,
    24813795,
    24814687,
  ];

  HackerNewsBloc() {
    _updateArticles().then((value) {
      _articlesSubject.add(UnmodifiableListView(_articles));
    });
  }

  Stream<UnmodifiableListView<Article>> get articles => _articlesSubject.stream;

  Future<Article> _getArticle(int id) async {
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final storyRes = await http.get(storyUrl);
    if (storyRes.statusCode == 200) {
      return parseArticle(storyRes.body);
    }
  }

  Future<Null> _updateArticles() async {
    final futureArticles = _ids.map((id) => _getArticle(id));
    final articles = await Future.wait(futureArticles);
    _articles = articles;
  }
}
