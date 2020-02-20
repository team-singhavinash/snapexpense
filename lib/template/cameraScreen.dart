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
        ResolutionPreset.high,
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
                  child: Align(child: CircularProgressIndicator(),alignment: Alignment.center)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          _controller.initialize().then((_) async {
            setState(() {});
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            await _controller.takePicture(path);
            controller.setImageSelectionForCamera(path);
            Router.navigator.popAndPushNamed(
              Router.addRecord,
              arguments: AddRecordArguments(imageSelectionOption: null, controller: controller)
            );
          });
        },
        child: Icon(
          Icons.camera,
          color: Colors.red,
          size: 45,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          height: 140,
          color: Colors.transparent,
          padding: EdgeInsets.all(12),
          child: Row(
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
                  icon: Icon(Icons.close),
                  color: Colors.red,
                  onPressed: () {
                    Router.navigator.pop();
                  },
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
                      ResolutionPreset.high,
                    );
                    _controller.initialize().then((_) {
                      setState(() {});
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
