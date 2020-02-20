import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


class CameraScreen extends StatefulWidget {
  CameraScreen({Key key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  var c;
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras){
      c=cameras;
         _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      c[1],
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
  // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
    });

 
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: FutureBuilder<void>(
         future: _initializeControllerFuture,
         builder: (context, snapshot) {
           // if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          //} else {
            // Otherwise, display a loading indicator.
       //     return Center(child: CircularProgressIndicator());
//}
         },
       ),
       
    );
  }
}