// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addrecord_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddRecordController on _AddRecordController, Store {
  Computed<dynamic> _$customStreamComputed;

  @override
  dynamic get customStream =>
      (_$customStreamComputed ??= Computed<dynamic>(() => super.customStream))
          .value;
  Computed<Future<String>> _$getFilePathComputed;

  @override
  Future<String> get getFilePath => (_$getFilePathComputed ??=
          Computed<Future<String>>(() => super.getFilePath))
      .value;

  final _$uploadFileAsyncAction = AsyncAction('uploadFile');

  @override
  Future<bool> uploadFile(File f) {
    return _$uploadFileAsyncAction.run(() => super.uploadFile(f));
  }

  final _$insertRecordAsyncAction = AsyncAction('insertRecord');

  @override
  Future<dynamic> insertRecord(dynamic newrecord) {
    return _$insertRecordAsyncAction.run(() => super.insertRecord(newrecord));
  }

  final _$deleteRecordAsyncAction = AsyncAction('deleteRecord');

  @override
  Future<bool> deleteRecord(dynamic oldrecord) {
    return _$deleteRecordAsyncAction.run(() => super.deleteRecord(oldrecord));
  }
}
