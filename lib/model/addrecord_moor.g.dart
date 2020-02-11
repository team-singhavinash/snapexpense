// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addrecord_moor.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Addrecord extends DataClass implements Insertable<Addrecord> {
  final int id;
  final int amount;
  final String desc;
  final String imgPath;
  final String expenseTag;
  final DateTime timestamp;
  Addrecord(
      {this.id,
      @required this.amount,
      this.desc,
      this.imgPath,
      this.expenseTag,
      @required this.timestamp});
  factory Addrecord.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Addrecord(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      amount: intType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
      desc: stringType.mapFromDatabaseResponse(data['${effectivePrefix}desc']),
      imgPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}img_path']),
      expenseTag: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}expense_tag']),
      timestamp: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}timestamp']),
    );
  }
  factory Addrecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Addrecord(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
      desc: serializer.fromJson<String>(json['desc']),
      imgPath: serializer.fromJson<String>(json['imgPath']),
      expenseTag: serializer.fromJson<String>(json['expenseTag']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<int>(amount),
      'desc': serializer.toJson<String>(desc),
      'imgPath': serializer.toJson<String>(imgPath),
      'expenseTag': serializer.toJson<String>(expenseTag),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  @override
  AddrecordsCompanion createCompanion(bool nullToAbsent) {
    return AddrecordsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      desc: desc == null && nullToAbsent ? const Value.absent() : Value(desc),
      imgPath: imgPath == null && nullToAbsent
          ? const Value.absent()
          : Value(imgPath),
      expenseTag: expenseTag == null && nullToAbsent
          ? const Value.absent()
          : Value(expenseTag),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
    );
  }

  Addrecord copyWith(
          {int id,
          int amount,
          String desc,
          String imgPath,
          String expenseTag,
          DateTime timestamp}) =>
      Addrecord(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        desc: desc ?? this.desc,
        imgPath: imgPath ?? this.imgPath,
        expenseTag: expenseTag ?? this.expenseTag,
        timestamp: timestamp ?? this.timestamp,
      );
  @override
  String toString() {
    return (StringBuffer('Addrecord(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('desc: $desc, ')
          ..write('imgPath: $imgPath, ')
          ..write('expenseTag: $expenseTag, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          amount.hashCode,
          $mrjc(
              desc.hashCode,
              $mrjc(imgPath.hashCode,
                  $mrjc(expenseTag.hashCode, timestamp.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Addrecord &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.desc == this.desc &&
          other.imgPath == this.imgPath &&
          other.expenseTag == this.expenseTag &&
          other.timestamp == this.timestamp);
}

class AddrecordsCompanion extends UpdateCompanion<Addrecord> {
  final Value<int> id;
  final Value<int> amount;
  final Value<String> desc;
  final Value<String> imgPath;
  final Value<String> expenseTag;
  final Value<DateTime> timestamp;
  const AddrecordsCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.desc = const Value.absent(),
    this.imgPath = const Value.absent(),
    this.expenseTag = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  AddrecordsCompanion.insert({
    this.id = const Value.absent(),
    @required int amount,
    this.desc = const Value.absent(),
    this.imgPath = const Value.absent(),
    this.expenseTag = const Value.absent(),
    @required DateTime timestamp,
  })  : amount = Value(amount),
        timestamp = Value(timestamp);
  AddrecordsCompanion copyWith(
      {Value<int> id,
      Value<int> amount,
      Value<String> desc,
      Value<String> imgPath,
      Value<String> expenseTag,
      Value<DateTime> timestamp}) {
    return AddrecordsCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      desc: desc ?? this.desc,
      imgPath: imgPath ?? this.imgPath,
      expenseTag: expenseTag ?? this.expenseTag,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class $AddrecordsTable extends Addrecords
    with TableInfo<$AddrecordsTable, Addrecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $AddrecordsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  GeneratedIntColumn _amount;
  @override
  GeneratedIntColumn get amount => _amount ??= _constructAmount();
  GeneratedIntColumn _constructAmount() {
    return GeneratedIntColumn(
      'amount',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descMeta = const VerificationMeta('desc');
  GeneratedTextColumn _desc;
  @override
  GeneratedTextColumn get desc => _desc ??= _constructDesc();
  GeneratedTextColumn _constructDesc() {
    return GeneratedTextColumn(
      'desc',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imgPathMeta = const VerificationMeta('imgPath');
  GeneratedTextColumn _imgPath;
  @override
  GeneratedTextColumn get imgPath => _imgPath ??= _constructImgPath();
  GeneratedTextColumn _constructImgPath() {
    return GeneratedTextColumn(
      'img_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _expenseTagMeta = const VerificationMeta('expenseTag');
  GeneratedTextColumn _expenseTag;
  @override
  GeneratedTextColumn get expenseTag => _expenseTag ??= _constructExpenseTag();
  GeneratedTextColumn _constructExpenseTag() {
    return GeneratedTextColumn(
      'expense_tag',
      $tableName,
      true,
    );
  }

  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  GeneratedDateTimeColumn _timestamp;
  @override
  GeneratedDateTimeColumn get timestamp => _timestamp ??= _constructTimestamp();
  GeneratedDateTimeColumn _constructTimestamp() {
    return GeneratedDateTimeColumn(
      'timestamp',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, amount, desc, imgPath, expenseTag, timestamp];
  @override
  $AddrecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'addrecords';
  @override
  final String actualTableName = 'addrecords';
  @override
  VerificationContext validateIntegrity(AddrecordsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.amount.present) {
      context.handle(
          _amountMeta, amount.isAcceptableValue(d.amount.value, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (d.desc.present) {
      context.handle(
          _descMeta, desc.isAcceptableValue(d.desc.value, _descMeta));
    }
    if (d.imgPath.present) {
      context.handle(_imgPathMeta,
          imgPath.isAcceptableValue(d.imgPath.value, _imgPathMeta));
    }
    if (d.expenseTag.present) {
      context.handle(_expenseTagMeta,
          expenseTag.isAcceptableValue(d.expenseTag.value, _expenseTagMeta));
    }
    if (d.timestamp.present) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableValue(d.timestamp.value, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Addrecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Addrecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AddrecordsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.amount.present) {
      map['amount'] = Variable<int, IntType>(d.amount.value);
    }
    if (d.desc.present) {
      map['desc'] = Variable<String, StringType>(d.desc.value);
    }
    if (d.imgPath.present) {
      map['img_path'] = Variable<String, StringType>(d.imgPath.value);
    }
    if (d.expenseTag.present) {
      map['expense_tag'] = Variable<String, StringType>(d.expenseTag.value);
    }
    if (d.timestamp.present) {
      map['timestamp'] = Variable<DateTime, DateTimeType>(d.timestamp.value);
    }
    return map;
  }

  @override
  $AddrecordsTable createAlias(String alias) {
    return $AddrecordsTable(_db, alias);
  }
}

abstract class _$SnapExpenseDatabase extends GeneratedDatabase {
  _$SnapExpenseDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  $AddrecordsTable _addrecords;
  $AddrecordsTable get addrecords => _addrecords ??= $AddrecordsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [addrecords];
}
