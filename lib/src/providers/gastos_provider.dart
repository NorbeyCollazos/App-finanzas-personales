import 'package:cloud_firestore/cloud_firestore.dart';

class GastosRepository {
  final String userId;

  GastosRepository(this.userId);

  Stream<QuerySnapshot> queryByCategory(int month, String categoryName) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Gastos')
        .where("month", isEqualTo: month)
        .where("category", isEqualTo: categoryName)
        .snapshots();
  }

  Stream<QuerySnapshot> queryByMonth(int month) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Gastos')
        .where("month", isEqualTo: month)
        .snapshots();
  }

  delete(String documentId) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Gastos')
        .doc(documentId)
        .delete();
  }

  add(String category, int value, String description, DateTime date) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Gastos')
        .doc()
        .set({
      "category": category,
      "value": value,
      "description": description,
      "year": date.year,
      "month": date.month,
      "day": date.day,
    });
  }
}
