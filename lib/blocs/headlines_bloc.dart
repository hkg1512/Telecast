//System Packages
import 'package:newsapi/newsapi.dart';
import 'package:rxdart/rxdart.dart';
//Resources
import 'package:telecast/resources/repository.dart';
//Utilties
import 'package:telecast/utilities/validators.dart';

class HeadlinesBloc extends Validators{
  final Repository _repository = Repository();
  final BehaviorSubject _category = BehaviorSubject<String>();
  final BehaviorSubject _newsList = BehaviorSubject<ArticleResponse>();

  void dispose(){
    _category.close();
    _newsList.close();
  }

  Stream<String> get category => _category.transform(validateCategory);
  Stream<ArticleResponse> get newsList => _newsList.transform(validateNewsList);
  void setCategory(String value) => _category.sink.add(value);
  void setNews(ArticleResponse value) => _newsList.sink.add(value);

  void fetchHeadlines() async {
    final String category = _category.value;
    ArticleResponse newsList;
    category!=null && category!=""?
    newsList = await _repository.getFetchHeadlines(category):
    print("HeadlinesBloc(fetchHeadlines): category is null or ''");
    this.setNews(newsList);
  }
}

final HeadlinesBloc headlinesBloc = HeadlinesBloc();
