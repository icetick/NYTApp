import 'dart:convert';

import 'package:NYT/networking/pojo/getArticlesPojo/articlesResponse.dart';
import 'package:http/http.dart';

import '../secret.dart';

class NetworkManager {
  Secret secret;
  setSecret(Secret value) { this.secret = value; }

  NetworkManager(){
    _getSecret().then((value) => setSecret(value));
  }

  Future<Secret> _getSecret() async {
    var key = await SecretLoader(secretPath: "assets/secrets.json").load();
    return key;
  }

  Future<ArticlesResponse> fetchArticles(String year, String month) async {
    if(secret==null) secret = await _getSecret();
    final response = await get(
        'https://api.nytimes.com/svc/archive/v1/$year/$month.json?api-key=${secret.apiKey}');

    return ArticlesResponse.fromJson(json.decode(response.body));
  }
}