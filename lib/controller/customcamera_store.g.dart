// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customcamera_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CustomCameraStore on _CustomCameraStore, Store {
  Computed<Future<CameraController>> _$getControllerComputed;

  @override
  Future<CameraController> get getController => (_$getControllerComputed ??=
          Computed<Future<CameraController>>(() => super.getController))
      .value;

  final _$camerasAtom = Atom(name: '_CustomCameraStore.cameras');

  @override
  List<CameraDescription> get cameras {
    _$camerasAtom.context.enforceReadPolicy(_$camerasAtom);
    _$camerasAtom.reportObserved();
    return super.cameras;
  }

  @override
  set cameras(List<CameraDescription> value) {
    _$camerasAtom.context.conditionallyRunInAction(() {
      super.cameras = value;
      _$camerasAtom.reportChanged();
    }, _$camerasAtom, name: '${_$camerasAtom.name}_set');
  }

  final _$_CustomCameraStoreActionController =
      ActionController(name: '_CustomCameraStore');

  @override
  dynamic setCameras(List<CameraDescription> paramcameras) {
    final _$actionInfo = _$_CustomCameraStoreActionController.startAction();
    try {
      return super.setCameras(paramcameras);
    } finally {
      _$_CustomCameraStoreActionController.endAction(_$actionInfo);
    }
  }
}
