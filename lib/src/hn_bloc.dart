import 'dart:async';
import 'dart:collection';

import 'package:hackernewsapp/src/article.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

enum StoriesType { topStories, newStories }

class HackerNewsBloc {
  // ignore: close_sinks
  final _articlesSubject = BehaviorSubject<UnmodifiableListView<Article>>();

  var _articles = <Article>[]; //for caching

  Sink<StoriesType> get storiesType => _storiesTypeController.sink;

  final _storiesTypeController = StreamController<StoriesType>();

  static List<int> _newIds = [
    24799660,
    24789865,
    24817304,
    24798302,
    24791357,
    24790055,
  ];

  static List<int> _topIds = [
    24800037,
    24795375,
    24797423,
    24808071,
    24793170,
    24813795,
    24814687,
  ];

  HackerNewsBloc() {
    _getArticleAndUpdate(_topIds);
    _storiesTypeController.stream.listen((storiesType) {
      List<int> ids;
      if (storiesType == StoriesType.newStories) {
        _getArticleAndUpdate(_newIds);
      } else {
        _getArticleAndUpdate(_topIds);
      }
    });
  }

  _getArticleAndUpdate(List<int> ids) {
    _updateArticles(ids).then((value) {
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

  Future<Null> _updateArticles(List<int> articleIds) async {
    final futureArticles = articleIds.map((id) => _getArticle(id));
    final articles = await Future.wait(futureArticles);
    _articles = articles;
  }
}
