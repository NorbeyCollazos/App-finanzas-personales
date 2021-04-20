import 'dart:ffi';

import 'package:app_finanzas_personales/src/models/person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider {
  CollectionReference _ref;

  UserProvider() {
    _ref = FirebaseFirestore.instance.collection('Users');
  }

  Future<void> create(Person person) {
    String errorMessage;

    try {
      return _ref.doc(person.id).set(person.toJson());
    } catch (error) {
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Stream<DocumentSnapshot> getByIdStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }
}
