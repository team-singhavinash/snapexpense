import 'dart:io';
import 'package:moor/moor.dart';
// These imports are only needed to open the database
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'addrecord_moor.g.dart';

class Addrecords extends Table{
  IntColumn get id => integer().autoIncrement().nullable()();
  IntColumn get amount => integer()();
  TextColumn get desc => text().nullable()();
  TextColumn get imgPath => text().nullable()();
  TextColumn get expenseTag => text().nullable()();
  DateTimeColumn get timestamp => dateTime()();
}


LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    //TODO : remove logstatement in production mode
    return VmDatabase(file,logStatements: true);  
  });
}

// this annotation tells moor to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@UseMoor(tables: [Addrecords])
class SnapExpenseDatabase extends _$SnapExpenseDatabase  {
  // we tell the database where to store the data with this constructor
  SnapExpenseDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

   // Moor supports Streams which emit elements when the watched data changes
  Stream<List<Addrecord>> watchAllRecords() => select(addrecords).watch();

  Future insertRecords(Addrecord newrecord) => into(addrecords).insert(newrecord);

  // Updates a Addrecords with a matching primary key
  Future updateRecords(Addrecord newrecord) => update(addrecords).replace(newrecord);

  Future deleteRecords(Addrecord newrecord) => delete(addrecords).delete(newrecord);

}