library firestore_query_builder;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// It is an enum type where you mention what type of query you want to produce.
/// It could be any out of 22 given types:
///
///	-> isEqualTo
///	-> isNotEqualTo
///	-> isLessThan
///	-> isLessThanOrEqualTo
///	-> isGreaterThan
///	-> isGreaterThanOrEqualTo
///	-> arrayContains
///	-> arrayContainsAny
///	-> whereIn
///	-> whereNotIn
///	-> isNull
///	-> isNotNull
///	-> limit
///	-> order
///	-> startAt
///	-> startAfter
///	-> endAt
///	-> endBefore
///	-> startAfterDocument
///	-> startAtDocument
///	-> endAtDocument
///	-> endBeforeDocument
///
enum ConditionType {
  isEqualTo,
  isNotEqualTo,
  isLessThan,
  isLessThanOrEqualTo,
  isGreaterThan,
  isGreaterThanOrEqualTo,
  arrayContains,
  arrayContainsAny,
  whereIn,
  whereNotIn,
  isNull,
  isNotNull,
  limit,
  order,
  startAt,
  startAfter,
  endAt,
  endBefore,
  startAfterDocument,
  startAtDocument,
  endAtDocument,
  endBeforeDocument,
}

/// This class takes 4 arguments out of which 3 are optional.
///
/// ```dart
/// FirestoreQueryStructure({
/// 	@required ConditionType conditionType,
/// 	String field,
/// 	dynamic value,
/// 	bool isAscending = true,
/// });
/// ```
class FirestoreQueryStructure {
  final ConditionType conditionType;

  /// You pass the field name that will be used to perform query on specific documents from collection.
  final String field;

  /// Pass the value which will correspond to the `field` while performing query.
  final dynamic value;

  /// By default it is set to `true`. You can set it to `false` if you want your documents to be ordered in descending order. This argument will not be used until your condition type is `ConditionType.order`.
  final bool isAscending;

  FirestoreQueryStructure({
    @required this.conditionType,
    this.field,
    this.value,
    this.isAscending = true,
  });
}

/// This method will ultimately build you a compound query. It take 2 arguments and returns `Query` that you can use to perform any type of query.
///
/// ```dart
/// 	Query buildQuery(
/// 		CollectionReference collectionRef,
/// 		{
/// 			List<FirestoreQueryStructure> structures,
/// 		},
/// 	);
/// ```
Query buildQuery(CollectionReference collectionRef,
    {List<FirestoreQueryStructure> structures}) {
  Query _query = collectionRef;

  if (structures != null) {
    structures.forEach((structure) {
      switch (structure.conditionType) {
        case ConditionType.isEqualTo:
          _query = _query.where(structure.field, isEqualTo: structure.value);
          break;
        case ConditionType.isNotEqualTo:
          _query = _query.where(structure.field, isNotEqualTo: structure.value);
          break;
        case ConditionType.isGreaterThan:
          _query =
              _query.where(structure.field, isGreaterThan: structure.value);
          break;
        case ConditionType.isGreaterThanOrEqualTo:
          _query = _query.where(structure.field,
              isGreaterThanOrEqualTo: structure.value);
          break;
        case ConditionType.isLessThan:
          _query = _query.where(structure.field, isLessThan: structure.value);
          break;
        case ConditionType.isLessThanOrEqualTo:
          _query = _query.where(structure.field,
              isLessThanOrEqualTo: structure.value);
          break;
        case ConditionType.isNull:
          _query = _query.where(structure.field, isNull: true);
          break;
        case ConditionType.isNotNull:
          _query = _query.where(structure.field, isNull: false);
          break;
        case ConditionType.arrayContains:
          _query =
              _query.where(structure.field, arrayContains: structure.value);
          break;
        case ConditionType.arrayContainsAny:
          _query =
              _query.where(structure.field, arrayContainsAny: structure.value);
          break;
        case ConditionType.whereIn:
          _query = _query.where(structure.field,
              whereIn: List<dynamic>.from(structure.value));
          break;
        case ConditionType.whereNotIn:
          _query = _query.where(structure.field,
              whereNotIn: List<dynamic>.from(structure.value));
          break;
        case ConditionType.limit:
          _query = _query.limit(int.parse(structure.value));
          break;
        case ConditionType.order:
          _query = _query.orderBy(structure.field,
              descending: structure.isAscending);
          break;
        case ConditionType.startAfter:
          _query = _query.startAfter(List<dynamic>.from(structure.value));
          break;
        case ConditionType.endBefore:
          _query = _query.endBefore(List<dynamic>.from(structure.value));
          break;
        case ConditionType.startAt:
          _query = _query.startAt(List<dynamic>.from(structure.value));
          break;
        case ConditionType.endAt:
          _query = _query.endAt(List<dynamic>.from(structure.value));
          break;
        case ConditionType.startAtDocument:
          _query = _query.startAtDocument(structure.value);
          break;
        case ConditionType.startAfterDocument:
          _query = _query.startAfterDocument(structure.value);
          break;
        case ConditionType.endBeforeDocument:
          _query = _query.endBeforeDocument(structure.value);
          break;
        default:
          throw new FlutterError("Invalid \"conditionType\" passed.");
          break;
      }
    });
  }

  return _query;
}
