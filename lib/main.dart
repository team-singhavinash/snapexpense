import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:snapexpenses/controller/customcamera_store.dart';
import 'package:snapexpenses/router/router.gr.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //this need to add for working
  CustomCameraStore().setCameras(await availableCameras());
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snapexpenses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Router.cameraScreen,
      onGenerateRoute: Router.onGenerateRoute,
      navigatorKey: Router.navigatorKey,
    );
  }
}
