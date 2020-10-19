import 'package:flutter/material.dart';
import 'package:hackernewsapp/src/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<Article> _articles = []; //articles;
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

  Future<Article> _getArticle(int id) async {
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final storyRes = await http.get(storyUrl);
    if (storyRes.statusCode == 200) {
      return parseArticle(storyRes.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
          children: _ids
              .map((i) => FutureBuilder<Article>(
                  future: _getArticle(i),
                  builder:
                      (BuildContext context, AsyncSnapshot<Article> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return _buildItem(snapshot.data);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
              .toList()),
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
