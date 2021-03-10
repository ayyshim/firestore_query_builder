
# firestore_query_builder

[![Starware](https://img.shields.io/badge/Starware-⭐-black?labelColor=f9b00d)](https://github.com/zepfietje/starware)

A handy utility package to build firestore complex queries on firestore collection.

## Install

Add package into your `pubspec.yaml` file.
```yaml
	...
	dependencies:
		...
		cloud_firestore: ^0.16.0+1
		firestore_query_builder: ^1.0.0+1
		...
```
## Usage
In this package you get a class **[FirestoreQueryStructure]** where you structure your part of query. And you will get a `buildQuery` method which will return a well-built firestore query that you can use to `get`, `delete` or `update` your firestore collection.

### FirestoreQueryStructure
This class takes 4 arguments out of which 3 are optional.
```dart
FirestoreQueryStructure({
	@required ConditionType conditionType,
	String field,
	dynamic value,
	bool isAscending  =  true,
});
```
 - **conditionType** [ConditionType] : It is an enum type where you mention what type of query you want to produce. It could be any out of 22 given types.
	  ```dart
   enum  ConditionType {
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
   ```
- **field** [String]: You pass the field name that will be used to perform query on specific documents from collection.
- **Value** [dynamic]: Pass the value which will correspond to the `field` while performing query.
- **isAscending** [bool]: By default it is set to `true`. You can set it to `false` if you want your documents to be ordered in descending order. This argument will not be used until your condition type is `ConditionType.order`.

### `buildQuery`
This method will ultimately build you a compound query. It take 2 arguments and returns `Query` (cloud_firestore class) that you can use to perform any type of query.
```dart
	Query buildQuery(
		CollectionReference collectionRef,
		{
			List<FirestoreQueryStructure> structures,
		},
	);
```

## Example

Let's write a query to get all the documents from *users* collection where `isAdmin` is true and order them from new to old joined admin by using `created_at` field from user document.

```dart
	void main() async {
		FirebaseFirestore _firestore = FirebaseFirestore.instance;
		
		CollectionReference _collectionRef = _firestore.collection("users");
		List<FirestoreQueryStructure> _structures = [
			FirestoreQueryStructure(
				conditionType: ConditionType.isEqualTo,
				field: "isAdmin",
				value: true,
			),
			FirestoreQueryStructure(
				conditionType: ConditionType.order,
				field: "created_at",
				isAscending: false,
			)
		];
		
		Query _query = buildQuery(_collectionReference, structures: _structures);
		
		final _querySnapshot = await _query.get();
		_querySnapshot.docs.forEach((DocumentSnapshot document) {
			print(document.data());
		}); 
		
	}
```

## 👨‍🦱 Author

**[Ashim Upadhaya](https://www.github.com/ayyshim)**

## 🌟 Starware

firestore_query_builder is a Starware.  
This means you're free to use the package, as long as you star its GitHub repository (although it is not compulsory).

