import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hackernewsapp/src/article.dart';
import 'package:hackernewsapp/src/hn_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  final hnBloc = HackerNewsBloc();
  runApp(MyApp(bloc: hnBloc));
}

class MyApp extends StatelessWidget {
  final HackerNewsBloc bloc;
  MyApp({this.bloc});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter HackerNews App', bloc: bloc),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.bloc}) : super(key: key);

  final String title;
  final HackerNewsBloc bloc;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<Article> _articles = []; //articles;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: LoadingInfo(widget.bloc.isLoading),
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
        stream: widget.bloc.articles,
        initialData: UnmodifiableListView<Article>([]),
        builder: (context, snapshot) => ListView(
          children: snapshot.data.map(_buildItem).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward_rounded),
            label: "Top Stories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            label: "New Stories",
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            widget.bloc.storiesType.add(StoriesType.topStories);
          } else {
            widget.bloc.storiesType.add(StoriesType.newStories);
          }
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      key: Key(article.title),
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: Text(
          article.title,
          style: TextStyle(fontSize: 20),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${article.type}"),
              IconButton(
                  onPressed: () async {
                    if (await canLaunch(article.url)) {
                      launch(article.url);
                    }
                  },
                  icon: Icon(Icons.launch))
            ],
          ),
        ],
      ),
    );
  }
}

class LoadingInfo extends StatelessWidget {
  LoadingInfo(this._isLoading);
  Stream<bool> _isLoading;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _isLoading,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return CircularProgressIndicator(
            backgroundColor: Colors.white,
          );
        }
        return Container();
      },
    );
  }
}
