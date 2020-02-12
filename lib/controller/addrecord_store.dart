import 'dart:async';
import 'dart:io';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapexpenses/model/addrecord_moor.dart';
part 'addrecord_store.g.dart';

class AddRecordController = _AddRecordController with _$AddRecordController;

abstract class _AddRecordController with Store {
  SnapExpenseDatabase db ;
  StreamController<List<Addrecord>> _streamController;

  ObservableStream<List<Addrecord>> recordStream;
    _AddRecordController(){
      db=SnapExpenseDatabase();
      db.getRecords;
      _streamController = StreamController<List<Addrecord>>();
      
    }
  @computed
  get customStream {
    _streamController.addStream(db.watchAllRecords());
      recordStream =  ObservableStream(_streamController.stream);
      print(recordStream.status);
  }

  @computed
  Future<String> get getFilePath async {  //the path where file is created
    Directory dir = await getExternalStorageDirectory();
    print(dir.path);
    String appPath = '${dir.path}/Pictures/';
    await Directory(appPath).create(recursive: true);
    return appPath;
  }

  @action
  Future<bool> uploadFile(File f) async {
    final file = File(await getFilePath + basename(f.path));
    print(file.path);
    var img = f.readAsBytesSync();
    file.writeAsBytesSync(img);
    print("file upload");
    return true;
  }

  @action
  Future insertRecord(Addrecord newrecord) async {
    return await db.insertRecords(newrecord);
  }

  @action
  Future<bool> deleteRecord(Addrecord oldrecord)async{
    int status=await db.deleteRecords(oldrecord);
    if(status>0){
      return true;
    }else
    return false;
  }

  @action
  Future<bool> updateRecord(Addrecord updaterecord)async{
    bool status= await db.updateRecords(updaterecord);
    if(status){
      return true;
    }else
    return false;
  } 

  void dispose() async {
    await _streamController.close();
  }
}
