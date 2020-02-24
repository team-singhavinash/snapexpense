import 'package:flutter/material.dart';
import 'package:snapexpenses/router/router.gr.dart';

void main(){
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snap Expense',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: Router.home,
      onGenerateRoute: Router.onGenerateRoute,
      navigatorKey: Router.navigatorKey,
    );
  }
}
