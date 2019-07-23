import 'package:NYT/networking/pojo/getArticlesPojo/articlesResponse.dart';
import 'package:NYT/widgets/searchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:NYT/networking/pojo/getArticlesPojo/articleNYT.dart';
import 'package:url_launcher/url_launcher.dart';
import 'networking/networkManager.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.manager}) : super(key: key);
  final NetworkManager manager;

  @override
  _MainPageState createState() => _MainPageState(manager);
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  Future<ArticlesResponse> post;
  String apiKeyForPost;
  final NetworkManager manager;
  Animation<double> searchExpandAnimation;
  AnimationController controller;
  TextEditingController _filter;
  String _searchText = "";
  List<ArticleNYT> filteredList;
  bool expanded = false;
  _MainPageState(this.manager);

  @override
  void initState() {
    post = manager.fetchArticles('2019', '1');
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    searchExpandAnimation = Tween<double>(begin: 0, end: 150).animate(controller);

    _filter = TextEditingController();
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: new Image.asset('images/nyt.png', fit: BoxFit.cover)),
          actions: <Widget>[
            SearchWidget(
              expandAnimation: searchExpandAnimation,
              controller: controller,
              filter: _filter,
            )
          ],
        ),
        body: FutureBuilder<ArticlesResponse>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (!(_searchText.isEmpty)) {
                List tempList = new List<ArticleNYT>();
                filteredList = snapshot.data.response.articles;
                for (int i = 0; i < filteredList.length; i++) {
                  if (filteredList[i]
                      .snippet
                      .toLowerCase()
                      .contains(_searchText.toLowerCase().trim())) {
                    tempList.add(filteredList[i]);
                  }
                }
                filteredList = tempList;
              }

              return ListView.builder(
                itemBuilder: (context, position) {
                  return Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[Expanded(
                              child: new GestureDetector(
                                  onTap: () {
                                    _launchURL(snapshot.data.response.articles[position].webUrl);
                                  }, child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 12.0, 12.0, 6.0),
                                child: Text(
                                  (filteredList == null || filteredList[position]==null || filteredList[position].snippet==null)
                                      ? snapshot.data.response
                                          .articles[position].snippet
                                      : filteredList[position].snippet,
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
                                  (filteredList == null || filteredList[position]==null || filteredList[position].pubDate==null)
                                      ? DateTime.parse(snapshot.data.response
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
                                                  5)
                                      : DateTime.parse(
                                              filteredList[position].pubDate)
                                          .toLocal()
                                          .toString()
                                          .substring(
                                              0,
                                              filteredList[position]
                                                      .pubDate
                                                      .length -
                                                  5),
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          ))
                        ),],
                      ),
                      Divider(
                        height: 2.0,
                        color: Colors.grey,
                      )
                    ],
                  );
                },
                itemCount: (filteredList==null||filteredList.isEmpty)?snapshot.data.response.articles.length:filteredList.length,
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
