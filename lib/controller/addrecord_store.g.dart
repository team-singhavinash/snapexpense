// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addrecord_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddRecordController on _AddRecordController, Store {
  Computed<void> _$filterAllRecordComputed;

  @override
  void get filterAllRecord => (_$filterAllRecordComputed ??=
          Computed<void>(() => super.filterAllRecord))
      .value;
  Computed<bool> _$stateComputed;

  @override
  bool get state =>
      (_$stateComputed ??= Computed<bool>(() => super.state)).value;
  Computed<Future<String>> _$getFilePathComputed;

  @override
  Future<String> get getFilePath => (_$getFilePathComputed ??=
          Computed<Future<String>>(() => super.getFilePath))
      .value;

  final _$recordStreamAtom = Atom(name: '_AddRecordController.recordStream');

  @override
  ObservableStream<List<Addrecord>> get recordStream {
    _$recordStreamAtom.context.enforceReadPolicy(_$recordStreamAtom);
    _$recordStreamAtom.reportObserved();
    return super.recordStream;
  }

  @override
  set recordStream(ObservableStream<List<Addrecord>> value) {
    _$recordStreamAtom.context.conditionallyRunInAction(() {
      super.recordStream = value;
      _$recordStreamAtom.reportChanged();
    }, _$recordStreamAtom, name: '${_$recordStreamAtom.name}_set');
  }

  final _$datesetAtom = Atom(name: '_AddRecordController.dateset');

  @override
  DateTime get dateset {
    _$datesetAtom.context.enforceReadPolicy(_$datesetAtom);
    _$datesetAtom.reportObserved();
    return super.dateset;
  }

  @override
  set dateset(DateTime value) {
    _$datesetAtom.context.conditionallyRunInAction(() {
      super.dateset = value;
      _$datesetAtom.reportChanged();
    }, _$datesetAtom, name: '${_$datesetAtom.name}_set');
  }

  final _$uploadImageAtom = Atom(name: '_AddRecordController.uploadImage');

  @override
  File get uploadImage {
    _$uploadImageAtom.context.enforceReadPolicy(_$uploadImageAtom);
    _$uploadImageAtom.reportObserved();
    return super.uploadImage;
  }

  @override
  set uploadImage(File value) {
    _$uploadImageAtom.context.conditionallyRunInAction(() {
      super.uploadImage = value;
      _$uploadImageAtom.reportChanged();
    }, _$uploadImageAtom, name: '${_$uploadImageAtom.name}_set');
  }

  final _$filterLoaderAtom = Atom(name: '_AddRecordController.filterLoader');

  @override
  bool get filterLoader {
    _$filterLoaderAtom.context.enforceReadPolicy(_$filterLoaderAtom);
    _$filterLoaderAtom.reportObserved();
    return super.filterLoader;
  }

  @override
  set filterLoader(bool value) {
    _$filterLoaderAtom.context.conditionallyRunInAction(() {
      super.filterLoader = value;
      _$filterLoaderAtom.reportChanged();
    }, _$filterLoaderAtom, name: '${_$filterLoaderAtom.name}_set');
  }

  final _$selectedAtom = Atom(name: '_AddRecordController.selected');

  @override
  String get selected {
    _$selectedAtom.context.enforceReadPolicy(_$selectedAtom);
    _$selectedAtom.reportObserved();
    return super.selected;
  }

  @override
  set selected(String value) {
    _$selectedAtom.context.conditionallyRunInAction(() {
      super.selected = value;
      _$selectedAtom.reportChanged();
    }, _$selectedAtom, name: '${_$selectedAtom.name}_set');
  }

  final _$setImageSelectionAsyncAction = AsyncAction('setImageSelection');

  @override
  Future<void> setImageSelection(int option) {
    return _$setImageSelectionAsyncAction
        .run(() => super.setImageSelection(option));
  }

  final _$uploadFileAsyncAction = AsyncAction('uploadFile');

  @override
  Future<File> uploadFile() {
    return _$uploadFileAsyncAction.run(() => super.uploadFile());
  }

  final _$insertRecordAsyncAction = AsyncAction('insertRecord');

  @override
  Future insertRecord(Addrecord newrecord) {
    return _$insertRecordAsyncAction.run(() => super.insertRecord(newrecord));
  }

  final _$deleteRecordAsyncAction = AsyncAction('deleteRecord');

  @override
  Future<bool> deleteRecord(Addrecord oldrecord) {
    return _$deleteRecordAsyncAction.run(() => super.deleteRecord(oldrecord));
  }

  final _$updateRecordAsyncAction = AsyncAction('updateRecord');

  @override
  Future<bool> updateRecord(Addrecord updaterecord) {
    return _$updateRecordAsyncAction
        .run(() => super.updateRecord(updaterecord));
  }

  final _$_AddRecordControllerActionController =
      ActionController(name: '_AddRecordController');

  @override
  void setTags(dynamic select) {
    final _$actionInfo = _$_AddRecordControllerActionController.startAction();
    try {
      return super.setTags(select);
    } finally {
      _$_AddRecordControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFiterLoader(bool state) {
    final _$actionInfo = _$_AddRecordControllerActionController.startAction();
    try {
      return super.setFiterLoader(state);
    } finally {
      _$_AddRecordControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterDate(DateTime mydate) {
    final _$actionInfo = _$_AddRecordControllerActionController.startAction();
    try {
      return super.filterDate(mydate);
    } finally {
      _$_AddRecordControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setImageSelectionForCamera(String option) {
    final _$actionInfo = _$_AddRecordControllerActionController.startAction();
    try {
      return super.setImageSelectionForCamera(option);
    } finally {
      _$_AddRecordControllerActionController.endAction(_$actionInfo);
    }
  }
}
