import 'package:flutter/material.dart';
import 'widget/home_page.dart';
import 'widget/login_page.dart';
import 'widget/list_view_page.dart';
import 'widget/exercise.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, //是否去掉右上角DEBUG标签
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "flutter_login": (_) => new LoginPage(),
        "flutter_listView": (_) => new ListViewPage(),
        "flutter_exercise": (_) => new Exercise(),
      },
    );
  }
}
