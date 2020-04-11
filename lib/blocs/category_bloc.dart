//System Packages
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
//Blocs
import 'package:telecast/blocs/headlines_bloc.dart';
//Resources
import 'package:telecast/resources/repository.dart';
//Utilties
import 'package:telecast/utilities/validators.dart';

class CategoryBloc extends Validators{
  final Repository _repository = Repository();
  final BehaviorSubject _categories = BehaviorSubject<List<dynamic>>();
  final BehaviorSubject _countryList = BehaviorSubject<List<DropdownMenuItem<String>>>();
  final BehaviorSubject _languageList = BehaviorSubject<List<DropdownMenuItem<String>>>();
  final BehaviorSubject _countrySelected = BehaviorSubject<String>();
  final BehaviorSubject _languageSelected = BehaviorSubject<String>();

  void dispose(){
    _categories.close();
    _countryList.close();
    _languageList.close();
    _countrySelected.close();
    _languageSelected.close();
  }

  Stream<List<dynamic>> get categories => _categories.transform(validateCategoryList);
  void setCategories() => _categories.sink.add(_repository.getCategories());
  void setHeadlineCategory(String value) => headlinesBloc.setCategory(value);
}

final CategoryBloc categoryBloc = CategoryBloc();