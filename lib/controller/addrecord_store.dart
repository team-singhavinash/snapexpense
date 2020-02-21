import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapexpenses/model/addrecord_moor.dart';
part 'addrecord_store.g.dart';

class AddRecordController = _AddRecordController with _$AddRecordController;

abstract class _AddRecordController with Store {
  SnapExpenseDatabase db;

  StreamController<List<Addrecord>> _streamController;

  @observable
  ObservableStream<List<Addrecord>> recordStream;

  @observable
  DateTime dateset;

  @observable
  File uploadImage;

  @observable
  bool filterLoader = true;

  @observable
  String selected = 'Splash Out';

  _AddRecordController() {
    db = SnapExpenseDatabase();
    _streamController = StreamController<List<Addrecord>>();
    filterAllRecord;
    recordStream = ObservableStream(_streamController.stream);
  }

  @action
  void setTags(select) {
    selected = select;
  }

  //time filter
  bool _timestampFilter(DateTime timestamp, DateTime newtimestamp,
      {int filterType = 0}) {
    //special condtion if new date is null return all data so always return true
    if (newtimestamp == null) return true;
    //fitertype 0-days, 1 - month, 2 -year
    if (filterType == 0) if (timestamp.day == newtimestamp.day &&
        timestamp.year == newtimestamp.year &&
        timestamp.month == newtimestamp.month)
      return true;
    else
      return false;
    else if (filterType == 1) if (timestamp.year == newtimestamp.year &&
        timestamp.month == newtimestamp.month)
      return true;
    else
      return false;
    else if (timestamp.year == newtimestamp.year)
      return true;
    else
      return false;
  }

  @computed
  void get filterAllRecord {
    //setFiterLoader(true);
    print(dateset);
    db.watchAllRecords().listen((d) {
      final newRecord = d.where((test) {
        return _timestampFilter(test.timestamp, dateset);
      }).toList();
      print(newRecord);
      Future.delayed(Duration(milliseconds: 500), () {
        _streamController.add(newRecord);
        filterLoader=false;
      });
    });
  }

  @action
  setFiterLoader(bool state){
    filterLoader=state;
    print("state is $state");
  }

  @action
  void filterDate(DateTime mydate) {
    dateset = mydate;
  }

  @action
  Future<void> setImageSelection(int option) async {
    if (option == 1)
      uploadImage = await ImagePicker.pickImage(source: ImageSource.camera);
    else if (option == 0) {
      uploadImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    } else
      uploadImage = null;
  }

  @action
  void setImageSelectionForCamera(String option) {
    uploadImage = File(option);
  }

  @computed
  bool get state {
    // print(recordStream.status);
    //return true;
    // if(recordStream==null){
    //   return true;
    // }else
    if (recordStream.status == StreamStatus.waiting) {
      return true;
    } else {
      return false;
    } 
  }

  @computed
  Future<String> get getFilePath async {
    //the path where file is created
    Directory dir = await getExternalStorageDirectory();
    print(dir.path);
    String appPath = '${dir.path}/Pictures/';
    await Directory(appPath).create(recursive: true);
    return appPath;
  }

  @action
  Future<bool> uploadFile() async {
    // TODO - File Handling
    File f = uploadImage;
    if (f != null) {
      final file = File(await getFilePath + basename(f.path));
      print(file.path);
      var img = f.readAsBytesSync();
      file.writeAsBytesSync(img);
      print("file upload");
      return true;
    } else
      return false;
  }

  Future<void> deleteImg(String filename) async {
    await File(filename).delete(recursive: true);
  }

  @action
  Future insertRecord(Addrecord newrecord) async {
    return await db.insertRecords(newrecord);
  }

  @action
  Future<bool> deleteRecord(Addrecord oldrecord) async {
    await deleteImg(oldrecord.imgPath);
    int status = await db.deleteRecords(oldrecord);
    if (status > 0) {
      return true;
    } else
      return false;
  }

  @action
  Future<bool> updateRecord(Addrecord updaterecord) async {
    bool status = await db.updateRecords(updaterecord);
    if (status) {
      return true;
    } else
      return false;
  }

  void dispose() async {
    //await _streamController.close();
  }
}
