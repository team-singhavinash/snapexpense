// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addrecord_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddRecordController on _AddRecordController, Store {
  Computed<dynamic> _$allRecordComputed;

  @override
  dynamic get allRecord =>
      (_$allRecordComputed ??= Computed<dynamic>(() => super.allRecord)).value;
  Computed<Future<String>> _$getFilePathComputed;

  @override
  Future<String> get getFilePath => (_$getFilePathComputed ??=
          Computed<Future<String>>(() => super.getFilePath))
      .value;

  final _$recordListAtom = Atom(name: '_AddRecordController.recordList');

  @override
  ObservableFuture<List<Addrecord>> get recordList {
    _$recordListAtom.context.enforceReadPolicy(_$recordListAtom);
    _$recordListAtom.reportObserved();
    return super.recordList;
  }

  @override
  set recordList(ObservableFuture<List<Addrecord>> value) {
    _$recordListAtom.context.conditionallyRunInAction(() {
      super.recordList = value;
      _$recordListAtom.reportChanged();
    }, _$recordListAtom, name: '${_$recordListAtom.name}_set');
  }

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

  final _$recordStream1Atom = Atom(name: '_AddRecordController.recordStream1');

  @override
  ObservableStream<List<Addrecord>> get recordStream1 {
    _$recordStream1Atom.context.enforceReadPolicy(_$recordStream1Atom);
    _$recordStream1Atom.reportObserved();
    return super.recordStream1;
  }

  @override
  set recordStream1(ObservableStream<List<Addrecord>> value) {
    _$recordStream1Atom.context.conditionallyRunInAction(() {
      super.recordStream1 = value;
      _$recordStream1Atom.reportChanged();
    }, _$recordStream1Atom, name: '${_$recordStream1Atom.name}_set');
  }

  final _$idAtom = Atom(name: '_AddRecordController.id');

  @override
  int get id {
    _$idAtom.context.enforceReadPolicy(_$idAtom);
    _$idAtom.reportObserved();
    return super.id;
  }

  @override
  set id(int value) {
    _$idAtom.context.conditionallyRunInAction(() {
      super.id = value;
      _$idAtom.reportChanged();
    }, _$idAtom, name: '${_$idAtom.name}_set');
  }

  final _$filterFakeIdAsyncAction = AsyncAction('filterFakeId');

  @override
  Future filterFakeId() {
    return _$filterFakeIdAsyncAction.run(() => super.filterFakeId());
  }

  final _$uploadFileAsyncAction = AsyncAction('uploadFile');

  @override
  Future<bool> uploadFile(File f) {
    return _$uploadFileAsyncAction.run(() => super.uploadFile(f));
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
}
