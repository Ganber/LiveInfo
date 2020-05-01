import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:liveinfo/news_list.dart';
import 'package:liveinfo/stocks_list.dart';
import 'package:liveinfo/weather_card.dart';

class InfoScreen extends StatefulWidget {
  final weatherData;
  final newsData;
  final stocksData;

  InfoScreen(this.weatherData, this.newsData, this.stocksData);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool isDarkModeOn = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset('lib/assets/avatar_icon.png'),
                    ),
                    Text('Settings'),
                  ],
                )),
              ),
              ListTile(
                title: Text('Dark Theme'),
                trailing: Switch(
                  activeColor: Colors.red,
                  onChanged: (bool value) {
                    setState(() {
                      isDarkModeOn = value;

                      DynamicTheme.of(context).setBrightness(
                          isDarkModeOn ? Brightness.dark : Brightness.light);
                    });
                  },
                  value: isDarkModeOn,
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Image.asset(
                'lib/assets/app_icon.png',
                scale: 3,
              ),
              Text(' LiveInfo')
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StocksList(widget.stocksData),
                WeatherCard(widget.weatherData),
                NewsList(widget.newsData),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
