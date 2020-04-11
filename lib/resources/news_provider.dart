//System Packages
import "package:newsapi/newsapi.dart";

class NewsProvider{
  Future<ArticleResponse> topHeadBusiness() async => await NewsAPI.newsApi.topHeadlines(
    country: 'in',
    category: "business",
    language: 'en',
    );
  Future<ArticleResponse> topHeadEntertainment() async => await NewsAPI.newsApi.topHeadlines(
    country: 'in',
    category: "entertainment",
    language: 'en',
    );
  Future<ArticleResponse> topHeadGeneral() async => await NewsAPI.newsApi.topHeadlines(
    country: 'in',
    category: "general",
    language: 'en',
    );
  Future<ArticleResponse> topHeadHealth() async => await NewsAPI.newsApi.topHeadlines(
    country: 'in',
    category: "health",
    language: 'en',
    );
  Future<ArticleResponse> topHeadScience() async => await NewsAPI.newsApi.topHeadlines(
    country: 'in',
    category: "science",
    language: 'en',
    );
  Future<ArticleResponse> topHeadSports() async => await NewsAPI.newsApi.topHeadlines(
    country: 'in',
    category: "sports",
    language: 'en',
    );
  Future<ArticleResponse> topHeadTechnology() async => await NewsAPI.newsApi.topHeadlines(
    country: 'in',
    category: "technology",
    language: 'en',
    );
}

final NewsProvider newsProvider = NewsProvider();

class NewsAPI{
  static final NewsAPI _instance = NewsAPI._internal();

  static NewsApi get newsApi {
    NewsApi _newsapi;
    if(_newsapi == null){
      _newsapi = NewsApi();
      _newsapi.init(debugLog:false, apiKey:"1d66fcff2d2b4ed3838e6ab131700c8d");
    }
    return _newsapi;
  }

  factory NewsAPI(){
    return _instance;
  }

  NewsAPI._internal();
}