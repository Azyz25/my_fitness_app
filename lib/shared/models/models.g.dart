// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

part of 'models.dart';

// BodyMetricsDB Schema
extension GetBodyMetricsDBCollection on Isar {
  IsarCollection<BodyMetricsDB> get bodyMetricsDBs => this.collection();
}

const BodyMetricsDBSchema = CollectionSchema(
  name: r'BodyMetricsDB',
  id: 1001,
  properties: {
    r'bmi':         PropertySchema(id: 0, name: r'bmi',         type: IsarType.double),
    r'bmr':         PropertySchema(id: 1, name: r'bmr',         type: IsarType.double),
    r'bodyFat':     PropertySchema(id: 2, name: r'bodyFat',     type: IsarType.double),
    r'bodyWater':   PropertySchema(id: 3, name: r'bodyWater',   type: IsarType.double),
    r'chestCm':     PropertySchema(id: 4, name: r'chestCm',     type: IsarType.double),
    r'date':        PropertySchema(id: 5, name: r'date',        type: IsarType.dateTime),
    r'muscleMass':  PropertySchema(id: 6, name: r'muscleMass',  type: IsarType.double),
    r'visceralFat': PropertySchema(id: 7, name: r'visceralFat', type: IsarType.long),
    r'waistCm':     PropertySchema(id: 8, name: r'waistCm',     type: IsarType.double),
    r'weight':      PropertySchema(id: 9, name: r'weight',      type: IsarType.double),
  },
  estimateSize: _bodyMetricsDBEstimateSize,
  serialize: _bodyMetricsDBSerialize,
  deserialize: _bodyMetricsDBDeserialize,
  deserializeProp: _bodyMetricsDBDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _bodyMetricsDBGetId,
  getLinks: _bodyMetricsDBGetLinks,
  attach: _bodyMetricsDBAttach,
  version: '3.1.0+1',
);

int _bodyMetricsDBEstimateSize(BodyMetricsDB object, List<int> offsets, Map<Type, List<int>> allOffsets) {
  return offsets.last;
}

void _bodyMetricsDBSerialize(BodyMetricsDB object, IsarWriter writer, List<int> offsets, Map<Type, List<int>> allOffsets) {
  writer.writeDouble(offsets[0], object.bmi);
  writer.writeDouble(offsets[1], object.bmr);
  writer.writeDouble(offsets[2], object.bodyFat);
  writer.writeDouble(offsets[3], object.bodyWater);
  writer.writeDouble(offsets[4], object.chestCm);
  writer.writeDateTime(offsets[5], object.date);
  writer.writeDouble(offsets[6], object.muscleMass);
  writer.writeLong(offsets[7], object.visceralFat);
  writer.writeDouble(offsets[8], object.waistCm);
  writer.writeDouble(offsets[9], object.weight);
}

BodyMetricsDB _bodyMetricsDBDeserialize(Id id, IsarReader reader, List<int> offsets, Map<Type, List<int>> allOffsets) {
  final object = BodyMetricsDB()
    ..bmi = reader.readDouble(offsets[0])
    ..bmr = reader.readDouble(offsets[1])
    ..bodyFat = reader.readDouble(offsets[2])
    ..bodyWater = reader.readDouble(offsets[3])
    ..chestCm = reader.readDoubleOrNull(offsets[4])
    ..date = reader.readDateTime(offsets[5])
    ..id = id
    ..muscleMass = reader.readDouble(offsets[6])
    ..visceralFat = reader.readLong(offsets[7])
    ..waistCm = reader.readDoubleOrNull(offsets[8])
    ..weight = reader.readDouble(offsets[9]);
  return object;
}

P _bodyMetricsDBDeserializeProp<P>(IsarReader reader, int propertyId, int offset, Map<Type, List<int>> allOffsets) {
  switch (propertyId) {
    case 0: return (reader.readDouble(offset)) as P;
    case 1: return (reader.readDouble(offset)) as P;
    case 2: return (reader.readDouble(offset)) as P;
    case 3: return (reader.readDouble(offset)) as P;
    case 4: return (reader.readDoubleOrNull(offset)) as P;
    case 5: return (reader.readDateTime(offset)) as P;
    case 6: return (reader.readDouble(offset)) as P;
    case 7: return (reader.readLong(offset)) as P;
    case 8: return (reader.readDoubleOrNull(offset)) as P;
    case 9: return (reader.readDouble(offset)) as P;
    default: throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bodyMetricsDBGetId(BodyMetricsDB object) => object.id;
List<IsarLinkBase<dynamic>> _bodyMetricsDBGetLinks(BodyMetricsDB object) => [];
void _bodyMetricsDBAttach(IsarCollection<dynamic> col, Id id, BodyMetricsDB object) { object.id = id; }

// FoodTemplateDB Schema
extension GetFoodTemplateDBCollection on Isar {
  IsarCollection<FoodTemplateDB> get foodTemplateDBs => this.collection();
}

const FoodTemplateDBSchema = CollectionSchema(
  name: r'FoodTemplateDB',
  id: 1002,
  properties: {
    r'cal':     PropertySchema(id: 0, name: r'cal',     type: IsarType.double),
    r'carbs':   PropertySchema(id: 1, name: r'carbs',   type: IsarType.double),
    r'fat':     PropertySchema(id: 2, name: r'fat',     type: IsarType.double),
    r'grams':   PropertySchema(id: 3, name: r'grams',   type: IsarType.double),
    r'name':    PropertySchema(id: 4, name: r'name',    type: IsarType.string),
    r'protein': PropertySchema(id: 5, name: r'protein', type: IsarType.double),
  },
  estimateSize: _foodTemplateDBEstimateSize,
  serialize: _foodTemplateDBSerialize,
  deserialize: _foodTemplateDBDeserialize,
  deserializeProp: _foodTemplateDBDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _foodTemplateDBGetId,
  getLinks: _foodTemplateDBGetLinks,
  attach: _foodTemplateDBAttach,
  version: '3.1.0+1',
);

int _foodTemplateDBEstimateSize(FoodTemplateDB object, List<int> offsets, Map<Type, List<int>> allOffsets) {
  var bytesCount = offsets.last;
  if (object.name != null) bytesCount += 3 + object.name!.length * 3;
  return bytesCount;
}

void _foodTemplateDBSerialize(FoodTemplateDB object, IsarWriter writer, List<int> offsets, Map<Type, List<int>> allOffsets) {
  writer.writeDouble(offsets[0], object.cal);
  writer.writeDouble(offsets[1], object.carbs);
  writer.writeDouble(offsets[2], object.fat);
  writer.writeDouble(offsets[3], object.grams);
  writer.writeString(offsets[4], object.name);
  writer.writeDouble(offsets[5], object.protein);
}

FoodTemplateDB _foodTemplateDBDeserialize(Id id, IsarReader reader, List<int> offsets, Map<Type, List<int>> allOffsets) {
  final object = FoodTemplateDB(
    cal: reader.readDoubleOrNull(offsets[0]),
    carbs: reader.readDoubleOrNull(offsets[1]),
    fat: reader.readDoubleOrNull(offsets[2]),
    grams: reader.readDoubleOrNull(offsets[3]),
    name: reader.readStringOrNull(offsets[4]),
    protein: reader.readDoubleOrNull(offsets[5]),
  )..id = id;
  return object;
}

P _foodTemplateDBDeserializeProp<P>(IsarReader reader, int propertyId, int offset, Map<Type, List<int>> allOffsets) {
  switch (propertyId) {
    case 0: return (reader.readDoubleOrNull(offset)) as P;
    case 1: return (reader.readDoubleOrNull(offset)) as P;
    case 2: return (reader.readDoubleOrNull(offset)) as P;
    case 3: return (reader.readDoubleOrNull(offset)) as P;
    case 4: return (reader.readStringOrNull(offset)) as P;
    case 5: return (reader.readDoubleOrNull(offset)) as P;
    default: throw IsarError('Unknown property with id $propertyId');
  }
}

Id _foodTemplateDBGetId(FoodTemplateDB object) => object.id;
List<IsarLinkBase<dynamic>> _foodTemplateDBGetLinks(FoodTemplateDB object) => [];
void _foodTemplateDBAttach(IsarCollection<dynamic> col, Id id, FoodTemplateDB object) { object.id = id; }

// DailyMealLogDB Schema
extension GetDailyMealLogDBCollection on Isar {
  IsarCollection<DailyMealLogDB> get dailyMealLogDBs => this.collection();
}

const DailyMealLogDBSchema = CollectionSchema(
  name: r'DailyMealLogDB',
  id: 1003,
  properties: {
    r'date':      PropertySchema(id: 0, name: r'date',      type: IsarType.dateTime),
    r'targetCal': PropertySchema(id: 1, name: r'targetCal', type: IsarType.double),
  },
  estimateSize: _dailyMealLogDBEstimateSize,
  serialize: _dailyMealLogDBSerialize,
  deserialize: _dailyMealLogDBDeserialize,
  deserializeProp: _dailyMealLogDBDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'meals': LinkSchema(id: -6148467521796089215, name: r'meals', target: r'FoodTemplateDB', single: false),
  },
  embeddedSchemas: {},
  getId: _dailyMealLogDBGetId,
  getLinks: _dailyMealLogDBGetLinks,
  attach: _dailyMealLogDBAttach,
  version: '3.1.0+1',
);

int _dailyMealLogDBEstimateSize(DailyMealLogDB object, List<int> offsets, Map<Type, List<int>> allOffsets) => offsets.last;

void _dailyMealLogDBSerialize(DailyMealLogDB object, IsarWriter writer, List<int> offsets, Map<Type, List<int>> allOffsets) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeDouble(offsets[1], object.targetCal);
}

DailyMealLogDB _dailyMealLogDBDeserialize(Id id, IsarReader reader, List<int> offsets, Map<Type, List<int>> allOffsets) {
  final object = DailyMealLogDB()
    ..date = reader.readDateTime(offsets[0])
    ..id = id
    ..targetCal = reader.readDouble(offsets[1]);
  return object;
}

P _dailyMealLogDBDeserializeProp<P>(IsarReader reader, int propertyId, int offset, Map<Type, List<int>> allOffsets) {
  switch (propertyId) {
    case 0: return (reader.readDateTime(offset)) as P;
    case 1: return (reader.readDouble(offset)) as P;
    default: throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyMealLogDBGetId(DailyMealLogDB object) => object.id;
List<IsarLinkBase<dynamic>> _dailyMealLogDBGetLinks(DailyMealLogDB object) => [object.meals];
void _dailyMealLogDBAttach(IsarCollection<dynamic> col, Id id, DailyMealLogDB object) {
  object.id = id;
  object.meals.attach(col, col.isar.collection<FoodTemplateDB>(), r'meals', id);
}

// WorkoutSessionDB Schema
extension GetWorkoutSessionDBCollection on Isar {
  IsarCollection<WorkoutSessionDB> get workoutSessionDBs => this.collection();
}

const WorkoutSessionDBSchema = CollectionSchema(
  name: r'WorkoutSessionDB',
  id: 1004,
  properties: {
    r'completedSets': PropertySchema(id: 0, name: r'completedSets', type: IsarType.long),
    r'date':          PropertySchema(id: 1, name: r'date',          type: IsarType.dateTime),
    r'exerciseName':  PropertySchema(id: 2, name: r'exerciseName',  type: IsarType.string),
    r'muscleGroup':   PropertySchema(id: 3, name: r'muscleGroup',   type: IsarType.string),
    r'reps':          PropertySchema(id: 4, name: r'reps',          type: IsarType.long),
    r'sets':          PropertySchema(id: 5, name: r'sets',          type: IsarType.long),
    r'weightKg':      PropertySchema(id: 6, name: r'weightKg',      type: IsarType.double),
  },
  estimateSize: _workoutSessionDBEstimateSize,
  serialize: _workoutSessionDBSerialize,
  deserialize: _workoutSessionDBDeserialize,
  deserializeProp: _workoutSessionDBDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _workoutSessionDBGetId,
  getLinks: _workoutSessionDBGetLinks,
  attach: _workoutSessionDBAttach,
  version: '3.1.0+1',
);

int _workoutSessionDBEstimateSize(WorkoutSessionDB object, List<int> offsets, Map<Type, List<int>> allOffsets) {
  var bytesCount = offsets.last;
  if (object.exerciseName != null) bytesCount += 3 + object.exerciseName!.length * 3;
  if (object.muscleGroup != null) bytesCount += 3 + object.muscleGroup!.length * 3;
  return bytesCount;
}

void _workoutSessionDBSerialize(WorkoutSessionDB object, IsarWriter writer, List<int> offsets, Map<Type, List<int>> allOffsets) {
  writer.writeLong(offsets[0], object.completedSets);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.exerciseName);
  writer.writeString(offsets[3], object.muscleGroup);
  writer.writeLong(offsets[4], object.reps);
  writer.writeLong(offsets[5], object.sets);
  writer.writeDouble(offsets[6], object.weightKg);
}

WorkoutSessionDB _workoutSessionDBDeserialize(Id id, IsarReader reader, List<int> offsets, Map<Type, List<int>> allOffsets) {
  final object = WorkoutSessionDB()
    ..completedSets = reader.readLong(offsets[0])
    ..date = reader.readDateTime(offsets[1])
    ..exerciseName = reader.readStringOrNull(offsets[2])
    ..id = id
    ..muscleGroup = reader.readStringOrNull(offsets[3])
    ..reps = reader.readLong(offsets[4])
    ..sets = reader.readLong(offsets[5])
    ..weightKg = reader.readDouble(offsets[6]);
  return object;
}

P _workoutSessionDBDeserializeProp<P>(IsarReader reader, int propertyId, int offset, Map<Type, List<int>> allOffsets) {
  switch (propertyId) {
    case 0: return (reader.readLong(offset)) as P;
    case 1: return (reader.readDateTime(offset)) as P;
    case 2: return (reader.readStringOrNull(offset)) as P;
    case 3: return (reader.readStringOrNull(offset)) as P;
    case 4: return (reader.readLong(offset)) as P;
    case 5: return (reader.readLong(offset)) as P;
    case 6: return (reader.readDouble(offset)) as P;
    default: throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workoutSessionDBGetId(WorkoutSessionDB object) => object.id;
List<IsarLinkBase<dynamic>> _workoutSessionDBGetLinks(WorkoutSessionDB object) => [];
void _workoutSessionDBAttach(IsarCollection<dynamic> col, Id id, WorkoutSessionDB object) { object.id = id; }

// HabitDB Schema
extension GetHabitDBCollection on Isar {
  IsarCollection<HabitDB> get habitDBs => this.collection();
}

const HabitDBSchema = CollectionSchema(
  name: r'HabitDB',
  id: 1005,
  properties: {
    r'date':        PropertySchema(id: 0, name: r'date',        type: IsarType.dateTime),
    r'emoji':       PropertySchema(id: 1, name: r'emoji',       type: IsarType.string),
    r'isCompleted': PropertySchema(id: 2, name: r'isCompleted', type: IsarType.bool),
    r'name':        PropertySchema(id: 3, name: r'name',        type: IsarType.string),
  },
  estimateSize: _habitDBEstimateSize,
  serialize: _habitDBSerialize,
  deserialize: _habitDBDeserialize,
  deserializeProp: _habitDBDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _habitDBGetId,
  getLinks: _habitDBGetLinks,
  attach: _habitDBAttach,
  version: '3.1.0+1',
);

int _habitDBEstimateSize(HabitDB object, List<int> offsets, Map<Type, List<int>> allOffsets) {
  var bytesCount = offsets.last;
  if (object.emoji != null) bytesCount += 3 + object.emoji!.length * 3;
  if (object.name != null) bytesCount += 3 + object.name!.length * 3;
  return bytesCount;
}

void _habitDBSerialize(HabitDB object, IsarWriter writer, List<int> offsets, Map<Type, List<int>> allOffsets) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeString(offsets[1], object.emoji);
  writer.writeBool(offsets[2], object.isCompleted);
  writer.writeString(offsets[3], object.name);
}

HabitDB _habitDBDeserialize(Id id, IsarReader reader, List<int> offsets, Map<Type, List<int>> allOffsets) {
  final object = HabitDB()
    ..date = reader.readDateTime(offsets[0])
    ..emoji = reader.readStringOrNull(offsets[1])
    ..id = id
    ..isCompleted = reader.readBool(offsets[2])
    ..name = reader.readStringOrNull(offsets[3]);
  return object;
}

P _habitDBDeserializeProp<P>(IsarReader reader, int propertyId, int offset, Map<Type, List<int>> allOffsets) {
  switch (propertyId) {
    case 0: return (reader.readDateTime(offset)) as P;
    case 1: return (reader.readStringOrNull(offset)) as P;
    case 2: return (reader.readBool(offset)) as P;
    case 3: return (reader.readStringOrNull(offset)) as P;
    default: throw IsarError('Unknown property with id $propertyId');
  }
}

Id _habitDBGetId(HabitDB object) => object.id;
List<IsarLinkBase<dynamic>> _habitDBGetLinks(HabitDB object) => [];
void _habitDBAttach(IsarCollection<dynamic> col, Id id, HabitDB object) { object.id = id; }
