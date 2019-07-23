import 'dart:convert';

import 'package:NYT/pojo/getArticlesPojo/articlesResponse.dart';
import 'package:NYT/secret.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
    final response = await get(
        'https://api.nytimes.com/svc/archive/v1/2019/1.json?api-key=${secret.apiKey}');

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
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      snapshot
                                          .data.response.articles[position].snippet,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      DateTime.parse(snapshot.data.response
                                          .articles[position].pubDate)
                                          .toLocal()
                                          .toString()
                                          .substring(
                                          0,
                                          snapshot
                                              .data
                                              .response
                                              .articles[position]
                                              .pubDate
                                              .length -
                                              5),
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
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}