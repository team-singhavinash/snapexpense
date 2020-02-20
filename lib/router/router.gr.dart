// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:snapexpenses/template/home.dart';
import 'package:snapexpenses/template/addrecords.dart';
import 'package:snapexpenses/controller/addrecord_store.dart';
import 'package:snapexpenses/template/imageView.dart';
import 'package:snapexpenses/template/cameraScreen.dart';

class Router {
  static const home = '/';
  static const addRecord = '/add-record';
  static const imageViewer = '/image-viewer';
  static const cameraScreen = '/camera-screen';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.home:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return MaterialPageRoute(
          builder: (_) => Home(key: typedArgs),
          settings: settings,
        );
      case Router.addRecord:
        if (hasInvalidArgs<AddRecordArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<AddRecordArguments>(args);
        }
        final typedArgs = args as AddRecordArguments;
        return MaterialPageRoute(
          builder: (_) => AddRecord(
              imageSelectionOption: typedArgs.imageSelectionOption,
              controller: typedArgs.controller),
          settings: settings,
        );
      case Router.imageViewer:
        if (hasInvalidArgs<String>(args, isRequired: true)) {
          return misTypedArgsRoute<String>(args);
        }
        final typedArgs = args as String;
        return MaterialPageRoute(
          builder: (_) => ImageViewer(img: typedArgs),
          settings: settings,
        );
      case Router.cameraScreen:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return MaterialPageRoute(
          builder: (_) => CameraScreen(key: typedArgs),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//AddRecord arguments holder class
class AddRecordArguments {
  final int imageSelectionOption;
  final AddRecordController controller;
  AddRecordArguments(
      {@required this.imageSelectionOption, @required this.controller});
}
