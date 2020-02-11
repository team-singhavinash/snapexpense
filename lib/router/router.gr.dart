// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:snapexpenses/template/addrecords.dart';

class Router {
  static const addRecord = '/addRecord';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.addRecord:
        return MaterialPageRoute(
          builder: (_) => AddRecord(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
