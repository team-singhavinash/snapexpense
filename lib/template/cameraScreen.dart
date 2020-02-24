import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:snapexpenses/controller/addrecord_store.dart';
import 'package:snapexpenses/router/router.gr.dart';

class CameraScreen extends StatefulWidget {
  final AddRecordController controller;
  CameraScreen(this.controller);
  @override
  _CameraScreenState createState() => _CameraScreenState(controller);
}

CameraController _controller;

class _CameraScreenState extends State<CameraScreen> {
  int cameraIndex = 1;
  var c;
  var defalutResolution=ResolutionPreset.high;
  final AddRecordController controller;
  _CameraScreenState(this.controller);
  //Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      c = cameras;
      _controller = CameraController(
        // Get a specific camera from the list of available cameras.
        c[cameraIndex],
        // Define the resolution to use.
        defalutResolution,
      );

      // Next, initialize the controller. This returns a Future.
      _controller.initialize().then((_) {
        setState(() {});
      });
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
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            _controller != null
                ? Container(
                    child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: CameraPreview(_controller)))
                : Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                    child: Align(
                        child: CircularProgressIndicator(),
                        alignment: Alignment.center)),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          height: 160,
          color: Colors.transparent,
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    FlatButton(onPressed:(){
                       defalutResolution=ResolutionPreset.low;
                        _controller = CameraController(
                          // Get a specific camera from the list of available cameras.
                          c[cameraIndex],
                          // Define the resolution to use.
                          defalutResolution,
                        );
                        _controller.initialize().then((_) {
                          setState(() {});
                        });
                    }, child: Text("Low")),
                    FlatButton(onPressed:(){
                       defalutResolution=ResolutionPreset.medium;
                        _controller = CameraController(
                          // Get a specific camera from the list of available cameras.
                          c[cameraIndex],
                          // Define the resolution to use.
                          defalutResolution,
                        );
                        _controller.initialize().then((_) {
                          setState(() {});
                        });
                    }, child: Text("Medium")),
                    FlatButton(onPressed:(){
                       defalutResolution=ResolutionPreset.high;
                        _controller = CameraController(
                          // Get a specific camera from the list of available cameras.
                          c[cameraIndex],
                          // Define the resolution to use.
                          defalutResolution,
                        );
                        _controller.initialize().then((_) {
                          setState(() {});
                        });
                    }, child: Text("High")),
                    FlatButton(onPressed:(){
                       defalutResolution=ResolutionPreset.veryHigh;
                        _controller = CameraController(
                          // Get a specific camera from the list of available cameras.
                          c[cameraIndex],
                          // Define the resolution to use.
                          defalutResolution,
                        );
                        _controller.initialize().then((_) {
                          setState(() {});
                        });
                    }, child: Text("Very High")),
                    FlatButton(onPressed:(){
                       defalutResolution=ResolutionPreset.ultraHigh;
                        _controller = CameraController(
                          // Get a specific camera from the list of available cameras.
                          c[cameraIndex],
                          // Define the resolution to use.
                          defalutResolution,
                        );
                        _controller.initialize().then((_) {
                          setState(() {});
                        });
                    }, child: Text("Ultra High")),
                    FlatButton(onPressed:(){
                       defalutResolution=ResolutionPreset.max;
                        _controller = CameraController(
                          // Get a specific camera from the list of available cameras.
                          c[cameraIndex],
                          // Define the resolution to use.
                          defalutResolution,
                        );
                        _controller.initialize().then((_) {
                          setState(() {});
                        });
                    }, child: Text("Max")),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                      shadows: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(1.0, 2.0),
                          blurRadius: 5.0,
                        )
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.insert_photo),
                      color: Colors.red,
                      onPressed: () {
                        Router.navigator.popAndPushNamed(Router.addRecord,
                            arguments: AddRecordArguments(
                                imageSelectionOption: 0,
                                controller: controller));
                      },
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    child: FittedBox(
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () async {
                          final path = join(
                            // Store the picture in the temp directory.
                            // Find the temp directory using the `path_provider` plugin.
                            (await getTemporaryDirectory()).path,
                            '${DateTime.now()}.png',
                          );
                          await _controller.takePicture(path);
                          controller.setImageSelectionForCamera(path);
                          Router.navigator.popAndPushNamed(Router.addRecord,
                              arguments: AddRecordArguments(
                                  imageSelectionOption: null,
                                  controller: controller));
                        },
                        child: Icon(Icons.camera, size: 40, color: Colors.red),
                      ),
                    ),
                  ),
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                      shadows: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(1.0, 2.0),
                          blurRadius: 5.0,
                        )
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.flip),
                      color: Colors.red,
                      onPressed: () {
                        if (cameraIndex == 0) {
                          cameraIndex = 1;
                        } else
                          cameraIndex = 0;
                        _controller = CameraController(
                          // Get a specific camera from the list of available cameras.
                          c[cameraIndex],
                          // Define the resolution to use.
                          defalutResolution,
                        );
                        _controller.initialize().then((_) {
                          setState(() {});
                        });
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
