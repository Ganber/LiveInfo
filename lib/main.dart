import 'package:flutter/material.dart';
import 'package:liveinfo/screens/loading_screen.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.dark,
      data: (brightness) => new ThemeData(
        primarySwatch: Colors.red,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          title: 'LiveInfo',
          home: LoadingScreen(),
        );
      },
    );
  }
}
