import 'package:camera/camera.dart';
import 'package:mobx/mobx.dart';
part 'customcamera_store.g.dart';

class CustomCameraStore = _CustomCameraStore with _$CustomCameraStore;

abstract class _CustomCameraStore with Store{
  

  @observable
  List<CameraDescription> cameras;
  
  @action 
  setCameras(List<CameraDescription> paramcameras){
    cameras=paramcameras;
  }

  @computed
  Future<CameraController> get getController async {
    CameraController controller=CameraController(cameras[0],ResolutionPreset.medium);
    print(controller);
    // try{
    //   await controller.initialize();
    // }catch(err) {
    //   print("err:$err");
    //   return null;
    // }
    return controller;
  }

}