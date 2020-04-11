//Resources
import 'package:newsapi/newsapi.dart';
import 'package:telecast/resources/news_provider.dart';


class Repository{
  final NewsProvider _newsProvider = NewsProvider();
  final List<dynamic> _categoryList = 
  [
    {"name": "Business", "image":"assets/business.png"},
    {"name": "Entertainment", "image":"assets/entertainment.png"},
    {"name": "General", "image":"assets/general.png"},
    {"name": "Health", "image":"assets/health.png"},
    {"name": "Science", "image":"assets/science.png"},
    {"name": "Sports", "image":"assets/sports.png"},
    {"name": "Technology", "image":"assets/technology.png"}
  ];

  List<dynamic> getCategories(){
    return _categoryList;
  }

  Future<ArticleResponse> getFetchHeadlines(String category) async {
    ArticleResponse response;
    
    if(category == "Business"){
      response = await _newsProvider.topHeadBusiness();
    }else if(category == "Entertainment"){
       response = await _newsProvider.topHeadEntertainment();
    }else if(category == "General"){
       response = await _newsProvider.topHeadGeneral();
    }else if(category == "Health"){
       response = await _newsProvider.topHeadHealth();
    }else if(category == "Science"){
       response = await _newsProvider.topHeadScience();
    }else if(category == "Sports"){
       response = await _newsProvider.topHeadSports();
    }else if(category == "Technology"){
       response = await _newsProvider.topHeadTechnology();
    }

    return response;
  }
}