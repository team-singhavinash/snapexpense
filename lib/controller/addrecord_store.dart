import 'dart:io';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapexpenses/model/addrecord_moor.dart';
part 'addrecord_store.g.dart';

class AddRecordController = _AddRecordController with _$AddRecordController;

abstract class _AddRecordController with Store {
  SnapExpenseDatabase db = SnapExpenseDatabase();
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
}
