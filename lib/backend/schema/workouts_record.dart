import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'workouts_record.g.dart';

abstract class WorkoutsRecord
    implements Built<WorkoutsRecord, WorkoutsRecordBuilder> {
  static Serializer<WorkoutsRecord> get serializer =>
      _$workoutsRecordSerializer;

  @nullable
  String get name;

  @nullable
  int get repGoal;

  @nullable
  DateTime get dueDate;

  @nullable
  DocumentReference get createdBy;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(WorkoutsRecordBuilder builder) => builder
    ..name = ''
    ..repGoal = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('workouts');

  static Stream<WorkoutsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<WorkoutsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  WorkoutsRecord._();
  factory WorkoutsRecord([void Function(WorkoutsRecordBuilder) updates]) =
      _$WorkoutsRecord;

  static WorkoutsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createWorkoutsRecordData({
  String name,
  int repGoal,
  DateTime dueDate,
  DocumentReference createdBy,
}) =>
    serializers.toFirestore(
        WorkoutsRecord.serializer,
        WorkoutsRecord((w) => w
          ..name = name
          ..repGoal = repGoal
          ..dueDate = dueDate
          ..createdBy = createdBy));
