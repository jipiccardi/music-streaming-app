import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {
  static final FirestoreDatabase _instance = FirestoreDatabase._internal();
  final FirebaseFirestore _firestore;

  factory FirestoreDatabase() {
    return _instance;
  }

  FirestoreDatabase._internal() : _firestore = FirebaseFirestore.instance {
    log('FirestoreDatabase instance created');
  }

  FirebaseFirestore get firestore => _firestore;
}
