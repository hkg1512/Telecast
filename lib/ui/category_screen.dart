//System Packages
import 'dart:ui';
import 'package:flutter/material.dart';
//Blocs
import 'package:telecast/blocs/category_bloc.dart';
//UI
import 'package:telecast/ui/headlines_screen.dart';
//Utilities
import 'package:telecast/utilities/screen_handler.dart';

class CategoryScreen extends StatefulWidget{

  @override
  _CategoryScreenState createState() => new _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>{
  String _countryItem = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),),
      body:Container(
      width: SizeConfig.screenWidth,
      height: double.infinity,
      color: Colors.black12,
      child: StreamBuilder(
        stream: categoryBloc.categories,
        initialData: [],
        builder: (context,snapshot){
          categoryBloc.setCategories();
          return snapshot.hasData && snapshot.data!=null && snapshot.data.length!=0?
          getBody(snapshot.data):getLoadingIndicator();
        }
      )
    ),
    bottomNavigationBar: getBottomNavbar(),
    );
  }

  getBody(List<dynamic> categories) => SafeArea(child:ListView.builder(
    itemCount: categories.length,
    itemBuilder: (context, index) =>getCard(categories[index])
  ));
  
  getBottomNavbar() => BottomNavigationBar(
    backgroundColor: Colors.black,
    items: 
    [
      BottomNavigationBarItem(
        title:Text(""),
        icon: IconButton(
          icon:Icon(Icons.menu, color: Colors.white),
          onPressed: () => getSelectionPopup(),)),
      BottomNavigationBarItem(
        title: Text(""),
        icon: IconButton(
          icon:Icon(Icons.keyboard_arrow_left, color: Colors.white),
          onPressed: (){},)),
    ]
  );

  getLoadingIndicator() => Center(
    child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.red))
  );

  getCard(dynamic category) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: 10.0,
    ),
    width: SizeConfig.screenWidth,
    child:Card(
    elevation: 2.5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0)),
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical:10.0),
    clipBehavior: Clip.hardEdge,
    child: GestureDetector(
      onTap: () => cardTapFunction(category["name"]),
      child:Column(
      children: <Widget>
      [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child:ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0)),
          child:Image.asset(
            category["image"],
            width: 160.0,
            height: 160.0,
            fit: BoxFit.scaleDown,))),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child:Text(category["name"], 
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold, 
            fontSize: 20.0)
            )
            ),
      ]
      )
  )
  )
  );

  void cardTapFunction(String category){
    categoryBloc.setHeadlineCategory(category);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HeadlinesScreen()),
  );
  }

  getSelectionPopup() => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => getPopup()
  );

  getPopup() => AlertDialog(
        title: Align(alignment: Alignment.topCenter, child: popupTitle()),
        titlePadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(width: 1.0, color: Colors.black12)),
        content: Align(
            heightFactor: 0.15,
            alignment: Alignment.topCenter,
            child: popupContent()),
  );

  popupTitle() => Column(children: <Widget>[
        Text(
          "Country and Language",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          height: 0.5,
          width: 200.0,
          color: Colors.black,
        )
      ]
  );

  popupContent() => Column(children: <Widget>[
        DropdownButton(
          hint:Text("Country"),
          elevation: 1,
          underline: Container(height:1, color: Colors.black38),
          items: getItems(),
          onChanged: (item) => _countryItem = item,
          ),
        SizedBox(height: 5.0),
        FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.amberAccent,
            child: Text("OK"),
            onPressed: () => Navigator.pop(context))
      ]
  );

  List<DropdownMenuItem<String>> getItems(){
    final List<DropdownMenuItem<String>> list = 
    [ 
      DropdownMenuItem(
        value:"India",
        child: Text("India")),
      DropdownMenuItem(
        value:"Argentina",
        child: Text("Argentina")),
    ];

    return list;
  }

}