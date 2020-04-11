// System Packages
import 'dart:async';
import 'package:newsapi/newsapi.dart';

class Validators {
  final validateCategoryList =
      StreamTransformer<List<dynamic>, List<dynamic>>.fromHandlers(
          handleData: (categories, sink) {
    if (categories.length != 0) {
      sink.add(categories);
    }
  });

  final validateCategory = StreamTransformer<String, String>.fromHandlers(
      handleData: (category, sink) {
    if (category.length != 0) {
      sink.add(category);
    }
  });

  final validateNewsList =
      StreamTransformer<ArticleResponse, ArticleResponse>.fromHandlers(
          handleData: (newsList, sink) {
    if (newsList.articles.length != 0) {
      sink.add(newsList);
    }
  });

  final validateCountryList = StreamTransformer<String, String>.fromHandlers(
      handleData: (countryList, sink) {
    if (countryList.length != 0) {
      sink.add(countryList);
    }
  });

 final validateLanguageList = StreamTransformer<String, String>.fromHandlers(
      handleData: (countryList, sink) {
    if (countryList.length != 0) {
      sink.add(countryList);
    }
  });

}
