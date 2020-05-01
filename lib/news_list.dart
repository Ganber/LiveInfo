import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsList extends StatefulWidget {
  final news;

  const NewsList(this.news);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  var newsArticle;

  @override
  void initState() {
    super.initState();
    updateUI(widget.news);
  }

  void updateUI(dynamic newsData) {
    setState(() {
      newsArticle = newsData['articles'];
    });
  }

  Future<void> lunchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: newsArticle.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(2.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    onTap: () {
                      lunchURL(newsArticle[index]['url']);
                    },
                    leading: Image.network(
                        'https://img.icons8.com/cotton/128/000000/news.png'),
                    title: Text(newsArticle[index]['title'] != null
                        ? newsArticle[index]['title']
                        : 'No title'),
                    subtitle: Text(newsArticle[index]['description'] != null
                        ? newsArticle[index]['description']
                        : 'Tap for further reading'),
                    isThreeLine: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      newsArticle[index]['source']['name'],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
