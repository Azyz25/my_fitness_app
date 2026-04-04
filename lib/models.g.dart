// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBodyMetricsCollection on Isar {
  IsarCollection<BodyMetrics> get bodyMetrics => this.collection();
}

const BodyMetricsSchema = CollectionSchema(
  name: r'BodyMetrics',
  id: -4226585174512269064,
  properties: {
    r'bmi': PropertySchema(
      id: 0,
      name: r'bmi',
      type: IsarType.double,
    ),
    r'bmr': PropertySchema(
      id: 1,
      name: r'bmr',
      type: IsarType.double,
    ),
    r'bodyFat': PropertySchema(
      id: 2,
      name: r'bodyFat',
      type: IsarType.double,
    ),
    r'bodyWater': PropertySchema(
      id: 3,
      name: r'bodyWater',
      type: IsarType.double,
    ),
    r'boneMass': PropertySchema(
      id: 4,
      name: r'boneMass',
      type: IsarType.double,
    ),
    r'date': PropertySchema(
      id: 5,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'muscleMass': PropertySchema(
      id: 6,
      name: r'muscleMass',
      type: IsarType.double,
    ),
    r'protein': PropertySchema(
      id: 7,
      name: r'protein',
      type: IsarType.double,
    ),
    r'visceralFat': PropertySchema(
      id: 8,
      name: r'visceralFat',
      type: IsarType.long,
    ),
    r'weight': PropertySchema(
      id: 9,
      name: r'weight',
      type: IsarType.double,
    )
  },
  estimateSize: _bodyMetricsEstimateSize,
  serialize: _bodyMetricsSerialize,
  deserialize: _bodyMetricsDeserialize,
  deserializeProp: _bodyMetricsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _bodyMetricsGetId,
  getLinks: _bodyMetricsGetLinks,
  attach: _bodyMetricsAttach,
  version: '3.1.0+1',
);

int _bodyMetricsEstimateSize(
  BodyMetrics object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _bodyMetricsSerialize(
  BodyMetrics object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.bmi);
  writer.writeDouble(offsets[1], object.bmr);
  writer.writeDouble(offsets[2], object.bodyFat);
  writer.writeDouble(offsets[3], object.bodyWater);
  writer.writeDouble(offsets[4], object.boneMass);
  writer.writeDateTime(offsets[5], object.date);
  writer.writeDouble(offsets[6], object.muscleMass);
  writer.writeDouble(offsets[7], object.protein);
  writer.writeLong(offsets[8], object.visceralFat);
  writer.writeDouble(offsets[9], object.weight);
}

BodyMetrics _bodyMetricsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BodyMetrics();
  object.bmi = reader.readDouble(offsets[0]);
  object.bmr = reader.readDouble(offsets[1]);
  object.bodyFat = reader.readDouble(offsets[2]);
  object.bodyWater = reader.readDouble(offsets[3]);
  object.boneMass = reader.readDouble(offsets[4]);
  object.date = reader.readDateTime(offsets[5]);
  object.id = id;
  object.muscleMass = reader.readDouble(offsets[6]);
  object.protein = reader.readDouble(offsets[7]);
  object.visceralFat = reader.readLong(offsets[8]);
  object.weight = reader.readDouble(offsets[9]);
  return object;
}

P _bodyMetricsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bodyMetricsGetId(BodyMetrics object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bodyMetricsGetLinks(BodyMetrics object) {
  return [];
}

void _bodyMetricsAttach(
    IsarCollection<dynamic> col, Id id, BodyMetrics object) {
  object.id = id;
}

extension BodyMetricsQueryWhereSort
    on QueryBuilder<BodyMetrics, BodyMetrics, QWhere> {
  QueryBuilder<BodyMetrics, BodyMetrics, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BodyMetricsQueryWhere
    on QueryBuilder<BodyMetrics, BodyMetrics, QWhereClause> {
  QueryBuilder<BodyMetrics, BodyMetrics, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BodyMetricsQueryFilter
    on QueryBuilder<BodyMetrics, BodyMetrics, QFilterCondition> {
  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> bmiEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bmi',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> bmiGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bmi',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> bmiLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bmi',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> bmiBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bmi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> bmrEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bmr',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> bmrGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bmr',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> bmrLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bmr',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> bmrBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bmr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> bodyFatEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bodyFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      bodyFatGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bodyFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> bodyFatLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bodyFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> bodyFatBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bodyFat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      bodyWaterEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bodyWater',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      bodyWaterGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bodyWater',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      bodyWaterLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bodyWater',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      bodyWaterBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bodyWater',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> boneMassEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boneMass',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      boneMassGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boneMass',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      boneMassLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boneMass',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> boneMassBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boneMass',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      muscleMassEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'muscleMass',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      muscleMassGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'muscleMass',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      muscleMassLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'muscleMass',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      muscleMassBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'muscleMass',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> proteinEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'protein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      proteinGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'protein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> proteinLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'protein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> proteinBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'protein',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      visceralFatEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'visceralFat',
        value: value,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      visceralFatGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'visceralFat',
        value: value,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      visceralFatLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'visceralFat',
        value: value,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      visceralFatBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'visceralFat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> weightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition>
      weightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> weightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterFilterCondition> weightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension BodyMetricsQueryObject
    on QueryBuilder<BodyMetrics, BodyMetrics, QFilterCondition> {}

extension BodyMetricsQueryLinks
    on QueryBuilder<BodyMetrics, BodyMetrics, QFilterCondition> {}

extension BodyMetricsQuerySortBy
    on QueryBuilder<BodyMetrics, BodyMetrics, QSortBy> {
  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByBmi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmi', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByBmiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmi', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByBmr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmr', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByBmrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmr', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByBodyFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyFat', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByBodyFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyFat', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByBodyWater() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyWater', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByBodyWaterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyWater', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByBoneMass() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boneMass', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByBoneMassDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boneMass', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByMuscleMass() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleMass', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByMuscleMassDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleMass', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protein', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protein', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByVisceralFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visceralFat', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByVisceralFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visceralFat', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> sortByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension BodyMetricsQuerySortThenBy
    on QueryBuilder<BodyMetrics, BodyMetrics, QSortThenBy> {
  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByBmi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmi', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByBmiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmi', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByBmr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmr', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByBmrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmr', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByBodyFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyFat', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByBodyFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyFat', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByBodyWater() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyWater', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByBodyWaterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyWater', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByBoneMass() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boneMass', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByBoneMassDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boneMass', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByMuscleMass() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleMass', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByMuscleMassDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleMass', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protein', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protein', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByVisceralFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visceralFat', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByVisceralFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visceralFat', Sort.desc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QAfterSortBy> thenByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension BodyMetricsQueryWhereDistinct
    on QueryBuilder<BodyMetrics, BodyMetrics, QDistinct> {
  QueryBuilder<BodyMetrics, BodyMetrics, QDistinct> distinctByBmi() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bmi');
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QDistinct> distinctByBmr() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bmr');
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QDistinct> distinctByBodyFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bodyFat');
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QDistinct> distinctByBodyWater() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bodyWater');
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QDistinct> distinctByBoneMass() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boneMass');
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QDistinct> distinctByMuscleMass() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'muscleMass');
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QDistinct> distinctByProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'protein');
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QDistinct> distinctByVisceralFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'visceralFat');
    });
  }

  QueryBuilder<BodyMetrics, BodyMetrics, QDistinct> distinctByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weight');
    });
  }
}

extension BodyMetricsQueryProperty
    on QueryBuilder<BodyMetrics, BodyMetrics, QQueryProperty> {
  QueryBuilder<BodyMetrics, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BodyMetrics, double, QQueryOperations> bmiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bmi');
    });
  }

  QueryBuilder<BodyMetrics, double, QQueryOperations> bmrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bmr');
    });
  }

  QueryBuilder<BodyMetrics, double, QQueryOperations> bodyFatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bodyFat');
    });
  }

  QueryBuilder<BodyMetrics, double, QQueryOperations> bodyWaterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bodyWater');
    });
  }

  QueryBuilder<BodyMetrics, double, QQueryOperations> boneMassProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boneMass');
    });
  }

  QueryBuilder<BodyMetrics, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<BodyMetrics, double, QQueryOperations> muscleMassProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'muscleMass');
    });
  }

  QueryBuilder<BodyMetrics, double, QQueryOperations> proteinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'protein');
    });
  }

  QueryBuilder<BodyMetrics, int, QQueryOperations> visceralFatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'visceralFat');
    });
  }

  QueryBuilder<BodyMetrics, double, QQueryOperations> weightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weight');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFoodTemplateCollection on Isar {
  IsarCollection<FoodTemplate> get foodTemplates => this.collection();
}

const FoodTemplateSchema = CollectionSchema(
  name: r'FoodTemplate',
  id: 5905634258505246618,
  properties: {
    r'cal': PropertySchema(
      id: 0,
      name: r'cal',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _foodTemplateEstimateSize,
  serialize: _foodTemplateSerialize,
  deserialize: _foodTemplateDeserialize,
  deserializeProp: _foodTemplateDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _foodTemplateGetId,
  getLinks: _foodTemplateGetLinks,
  attach: _foodTemplateAttach,
  version: '3.1.0+1',
);

int _foodTemplateEstimateSize(
  FoodTemplate object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _foodTemplateSerialize(
  FoodTemplate object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cal);
  writer.writeString(offsets[1], object.name);
}

FoodTemplate _foodTemplateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FoodTemplate();
  object.cal = reader.readDoubleOrNull(offsets[0]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[1]);
  return object;
}

P _foodTemplateDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _foodTemplateGetId(FoodTemplate object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _foodTemplateGetLinks(FoodTemplate object) {
  return [];
}

void _foodTemplateAttach(
    IsarCollection<dynamic> col, Id id, FoodTemplate object) {
  object.id = id;
}

extension FoodTemplateQueryWhereSort
    on QueryBuilder<FoodTemplate, FoodTemplate, QWhere> {
  QueryBuilder<FoodTemplate, FoodTemplate, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FoodTemplateQueryWhere
    on QueryBuilder<FoodTemplate, FoodTemplate, QWhereClause> {
  QueryBuilder<FoodTemplate, FoodTemplate, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FoodTemplateQueryFilter
    on QueryBuilder<FoodTemplate, FoodTemplate, QFilterCondition> {
  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> calIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cal',
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition>
      calIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cal',
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> calEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition>
      calGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> calLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> calBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension FoodTemplateQueryObject
    on QueryBuilder<FoodTemplate, FoodTemplate, QFilterCondition> {}

extension FoodTemplateQueryLinks
    on QueryBuilder<FoodTemplate, FoodTemplate, QFilterCondition> {}

extension FoodTemplateQuerySortBy
    on QueryBuilder<FoodTemplate, FoodTemplate, QSortBy> {
  QueryBuilder<FoodTemplate, FoodTemplate, QAfterSortBy> sortByCal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cal', Sort.asc);
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterSortBy> sortByCalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cal', Sort.desc);
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension FoodTemplateQuerySortThenBy
    on QueryBuilder<FoodTemplate, FoodTemplate, QSortThenBy> {
  QueryBuilder<FoodTemplate, FoodTemplate, QAfterSortBy> thenByCal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cal', Sort.asc);
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterSortBy> thenByCalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cal', Sort.desc);
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension FoodTemplateQueryWhereDistinct
    on QueryBuilder<FoodTemplate, FoodTemplate, QDistinct> {
  QueryBuilder<FoodTemplate, FoodTemplate, QDistinct> distinctByCal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cal');
    });
  }

  QueryBuilder<FoodTemplate, FoodTemplate, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension FoodTemplateQueryProperty
    on QueryBuilder<FoodTemplate, FoodTemplate, QQueryProperty> {
  QueryBuilder<FoodTemplate, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FoodTemplate, double?, QQueryOperations> calProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cal');
    });
  }

  QueryBuilder<FoodTemplate, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailyMealLogCollection on Isar {
  IsarCollection<DailyMealLog> get dailyMealLogs => this.collection();
}

const DailyMealLogSchema = CollectionSchema(
  name: r'DailyMealLog',
  id: -1104250001336833861,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'targetCal': PropertySchema(
      id: 1,
      name: r'targetCal',
      type: IsarType.double,
    )
  },
  estimateSize: _dailyMealLogEstimateSize,
  serialize: _dailyMealLogSerialize,
  deserialize: _dailyMealLogDeserialize,
  deserializeProp: _dailyMealLogDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'meals': LinkSchema(
      id: -6148467521796089215,
      name: r'meals',
      target: r'FoodTemplate',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _dailyMealLogGetId,
  getLinks: _dailyMealLogGetLinks,
  attach: _dailyMealLogAttach,
  version: '3.1.0+1',
);

int _dailyMealLogEstimateSize(
  DailyMealLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _dailyMealLogSerialize(
  DailyMealLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeDouble(offsets[1], object.targetCal);
}

DailyMealLog _dailyMealLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyMealLog();
  object.date = reader.readDateTime(offsets[0]);
  object.id = id;
  object.targetCal = reader.readDouble(offsets[1]);
  return object;
}

P _dailyMealLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyMealLogGetId(DailyMealLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyMealLogGetLinks(DailyMealLog object) {
  return [object.meals];
}

void _dailyMealLogAttach(
    IsarCollection<dynamic> col, Id id, DailyMealLog object) {
  object.id = id;
  object.meals.attach(col, col.isar.collection<FoodTemplate>(), r'meals', id);
}

extension DailyMealLogQueryWhereSort
    on QueryBuilder<DailyMealLog, DailyMealLog, QWhere> {
  QueryBuilder<DailyMealLog, DailyMealLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DailyMealLogQueryWhere
    on QueryBuilder<DailyMealLog, DailyMealLog, QWhereClause> {
  QueryBuilder<DailyMealLog, DailyMealLog, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DailyMealLogQueryFilter
    on QueryBuilder<DailyMealLog, DailyMealLog, QFilterCondition> {
  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition>
      targetCalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetCal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition>
      targetCalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetCal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition>
      targetCalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetCal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition>
      targetCalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetCal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension DailyMealLogQueryObject
    on QueryBuilder<DailyMealLog, DailyMealLog, QFilterCondition> {}

extension DailyMealLogQueryLinks
    on QueryBuilder<DailyMealLog, DailyMealLog, QFilterCondition> {
  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition> meals(
      FilterQuery<FoodTemplate> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'meals');
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition>
      mealsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'meals', length, true, length, true);
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition>
      mealsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'meals', 0, true, 0, true);
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition>
      mealsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'meals', 0, false, 999999, true);
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition>
      mealsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'meals', 0, true, length, include);
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition>
      mealsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'meals', length, include, 999999, true);
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterFilterCondition>
      mealsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'meals', lower, includeLower, upper, includeUpper);
    });
  }
}

extension DailyMealLogQuerySortBy
    on QueryBuilder<DailyMealLog, DailyMealLog, QSortBy> {
  QueryBuilder<DailyMealLog, DailyMealLog, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterSortBy> sortByTargetCal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCal', Sort.asc);
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterSortBy> sortByTargetCalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCal', Sort.desc);
    });
  }
}

extension DailyMealLogQuerySortThenBy
    on QueryBuilder<DailyMealLog, DailyMealLog, QSortThenBy> {
  QueryBuilder<DailyMealLog, DailyMealLog, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterSortBy> thenByTargetCal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCal', Sort.asc);
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QAfterSortBy> thenByTargetCalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetCal', Sort.desc);
    });
  }
}

extension DailyMealLogQueryWhereDistinct
    on QueryBuilder<DailyMealLog, DailyMealLog, QDistinct> {
  QueryBuilder<DailyMealLog, DailyMealLog, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DailyMealLog, DailyMealLog, QDistinct> distinctByTargetCal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetCal');
    });
  }
}

extension DailyMealLogQueryProperty
    on QueryBuilder<DailyMealLog, DailyMealLog, QQueryProperty> {
  QueryBuilder<DailyMealLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyMealLog, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DailyMealLog, double, QQueryOperations> targetCalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetCal');
    });
  }
}
