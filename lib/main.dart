import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:NYT/response.dart';
import 'package:NYT/secret.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NYT',
      theme: ThemeData(
        primaryColor: Colors.white,
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
  Future<ArticlesResponse> post;
  String apiKeyForPost;
  @override
  void initState() {
    post = fetchPost();
    super.initState();
  }

  Future<Secret> getSecret() async {
    var key = await SecretLoader(secretPath: "assets/secrets.json").load();
    return key;
  }

  Future<ArticlesResponse> fetchPost() async {
    var secret = await getSecret();
    final response = await get('https://api.nytimes.com/svc/archive/v1/2019/1.json?api-key=${secret.apiKey}');

    return ArticlesResponse.fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Image.asset('images/nyt.png', fit: BoxFit.cover),
      ),
      body: FutureBuilder<ArticlesResponse>(
              future: post,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, position) {
                      return Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      snapshot.data.response.articles[position].snippet,
                                      style: TextStyle(
                                          fontSize: 22.0, fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      DateTime.parse(snapshot.data.response.articles[position].pubDate).toLocal().toString().substring(0, snapshot.data.response.articles[position].pubDate.length-5),
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                ],
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "5m",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.star_border,
                                        size: 35.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 2.0,
                            color: Colors.grey,
                          )
                        ],
                      );
                    },
                    itemCount: snapshot.data.response.articles.length,
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return Center(child: CircularProgressIndicator(),);
              },
            )
    );
  }
}
class ArticlesResponse {
  final String copyright;
  final NYTResponse response;

  ArticlesResponse({this.copyright, this.response});

  factory ArticlesResponse.fromJson(Map<String, dynamic> json) {
    var res = NYTResponse.fromJson(json['response']);
    return ArticlesResponse(
      copyright: json['copyright'],
      response: res
    );
  }
}

