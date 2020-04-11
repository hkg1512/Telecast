//System Packages
import 'package:flutter/material.dart';
import 'package:newsapi/newsapi.dart';
//Blocs
import 'package:telecast/blocs/headlines_bloc.dart';
//Utilities
import 'package:telecast/utilities/screen_handler.dart';

import 'full_read_screen.dart';

class HeadlinesScreen extends StatefulWidget {
  @override
  _HeadlinesScreenState createState() => new _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text("Top Headlines"),
        actions: <Widget>[
          IconButton(
              onPressed: () {}, icon: Icon(Icons.refresh, color: Colors.white))
        ],
      ),
      body: getBody(),
    );
  }

  getBody() => StreamBuilder(
      stream: headlinesBloc.category,
      initialData: "",
      builder: (context, snapshot) {
        print(snapshot.data);
        return snapshot.hasData && snapshot.data != null && snapshot.data != ""
            ? getHeadlines()
            : getLoadingIndicator();
      });

  getHeadlines() => StreamBuilder(
      stream: headlinesBloc.newsList,
      initialData: null,
      builder: (context, snapshot) {
        headlinesBloc.fetchHeadlines();
        return snapshot.hasData && snapshot.data != null
            ? getHeadlineList(snapshot.data)
            : getLoadingIndicator();
      });

  getHeadlineList(ArticleResponse newsList) => ListView.builder(
      itemCount: newsList.articles.length,
      itemBuilder: (context, index) =>
          getHeadlineCard(newsList.articles[index]));

  getHeadlineCard(Article data) => Container(
      color: Colors.white,
      width: SizeConfig.screenWidth,
      child: Card(
          elevation: 2.5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          clipBehavior: Clip.hardEdge,
          child: GestureDetector(
              onTap: () => data.url != null && data.url != ""
                  ? readFullNews(data.url)
                  : getErrorPopup(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    data.urlToImage != null && data.urlToImage != ""
                        ? ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            child: Image.network(
                              data.urlToImage,
                              height: 160.0,
                              fit: BoxFit.fill,
                            ))
                        : getImageLoadingIndicator(),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: getNewsText(data)),
                  ]))));

  getNewsText(Article data) => Column(children: <Widget>[
        getDateAuthor(data),
        SizedBox(
          height: 10.0,
        ),
        Container(height: 0.5, width: 150.0, color: Colors.black),
        SizedBox(
          height: 10.0,
        ),
        Text(data.title,
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0)),
        SizedBox(
          height: 5.0,
        ),
        data.description != null && data.description != ""
            ? Text(data.description + "  (more)",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontSize: 15.0))
            : SizedBox(),
      ]
      );

  getDateAuthor(Article data) => Row(children: <Widget>[
        Row(children: <Widget>[
          Icon(
            Icons.date_range,
            color: Colors.black,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            data.publishedAt.toString().substring(0, 10),
            style: TextStyle(
                color: Colors.blue,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
        ]),
        Expanded(child: SizedBox()),
        data.author != null
            ? Row(children: <Widget>[
                Icon(
                  Icons.perm_identity,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  data.author,
                  style: TextStyle(
                      color: Colors.green,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ])
            : SizedBox(),
      ]
  );

  getErrorPopup() => showDialog(
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
            heightFactor: 0.09,
            alignment: Alignment.topCenter,
            child: popupContent()),
  );

  popupTitle() => Column(children: <Widget>[
        Text(
          "ERROR",
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
        Text("Content not found!",
            style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic)),
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

  void readFullNews(String newURL) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FullReadScreen(newURL)),
  );
  
  getImageLoadingIndicator() => Container(
      height: 160.0,
      child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red))));

  getLoadingIndicator() => Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red)));
}
