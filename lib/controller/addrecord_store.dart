import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapexpenses/model/addrecord_moor.dart';
part 'addrecord_store.g.dart';

class AddRecordController = _AddRecordController with _$AddRecordController;

abstract class _AddRecordController with Store {
  SnapExpenseDatabase db ;
 
  StreamController<List<Addrecord>> _streamController,_streamController1;
  
  @observable
  ObservableFuture<List<Addrecord>> recordList;

  @observable
  ObservableStream<List<Addrecord>> recordStream,recordStream1;

  @observable
  int id=4;

    _AddRecordController(){
      db=SnapExpenseDatabase();
       

       _streamController = StreamController<List<Addrecord>>();
        _streamController1 = StreamController<List<Addrecord>>();
          _streamController.addStream(
         db.watchAllRecords(id: id)
         );
        recordStream= ObservableStream(_streamController.stream);
        allRecord;
    }
  @computed
  get allRecord{
    db.watchAllRecords().listen(
      (d){
        print(id);
        d.where((test)=>test.id==id);
        _streamController1.add(d.toList());
        print("d value");
        print(d.toList());
        
      }
       
    );
    recordStream1= ObservableStream(_streamController1.stream);
   // _streamController.sink( db.watchAllRecords());
    //  _streamController.addStream(
    //      db.watchAllRecords().map(
    //        (convert)=>convert.where(
    //          (test)=>test.id==id).toList()
    //          )
    //      );
        //recordStream= ObservableStream(recordStream);
  }
  @action
    filterFakeId() async {
      db.watchAllRecords().listen(
      (d){
        print(id);
        
        _streamController1.add(d.where((test)=>test.id==id).toList());
        print("d value");
        print(d.toList());
        
      }
       
    );
     // print(await db.getRecords);
      id=8;
      //print(recordStream);
      // recordStream=recordStream.map((e){
      //   print(e.toList().toString());
      //   e.where((test)=>test.id==9);
      // });
     // print(await recordStream);
      // _streamController.close();
      //db.watchAllRecords().listen((d){
        //recordStream=ObservableStream(d.where((condition)=>condition.id==9).toList().stream);
       // print(d.where((condition)=>condition.id==9).toList());
     // });
      // _streamController1 = StreamController<List<Addrecord>>();
      //  _streamController1.addStream(db.watchAllRecords());
      // recordStream =  ObservableStream(_streamController1.stream);
     //recordList=ObservableFuture(db.getRecords);
     //recordList= ObservableList(db.getRecords.then((v)=>v.where((c)=>c.id==9).toList()));
    // await _streamController.close();
    // print("fake action");
    // print(await recordList);
     //list = await ObservableFuture(recordList.then((v)=>v.where((c)=>c.id==9).toList()));  ///this is way to filter deep array of object
     //print(await recordList);
  }
  // @computed
  // bool get state{
  //   print(recordStream.status);
  //   if(recordStream==null){
  //     return false;
  //   }else if(recordStream.status==StreamStatus.waiting)
  //   {
  //     print("hello stream status");
  //     return true;
  //     }else{
  //       return false;
  //     }
  // }


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
    //await _streamController.close();
  }
}
