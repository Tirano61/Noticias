import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_provider_app/models/category_model.dart';
import 'package:news_provider_app/models/news_models.dart';

import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  List<Article> headLines = [];

  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  final _URL_News = 'https://newsapi.org/v2';
  final _API_KEY = '5898ac0a7cfe47c3b3d6828b1b4e347b';

  NewsService() {
    this.getTopHeadLines();
    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });
  }

  get getSelectedCategory => this._selectedCategory;

  set setSelectedCategory(String categ) {
    this._selectedCategory = categ;

    this.getArticlesByCategory(categ);

    notifyListeners();
  }

  getTopHeadLines() async {
    final url = '$_URL_News/top-headlines?apiKey=$_API_KEY&country=ar';

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.headLines.addAll(newsResponse.articles);

    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSelecionada => this.categoryArticles[this.getSelectedCategory];


  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category].length > 0) {
      return this.categoryArticles[category];
    }

    final url =
        '$_URL_News/top-headlines?apiKey=$_API_KEY&country=ar&category=$category';

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category].addAll(newsResponse.articles);

    notifyListeners();
  }
}
