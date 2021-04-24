import 'package:cloud_firestore/cloud_firestore.dart';

class IngresosRepository {
  final String userId;

  IngresosRepository(this.userId);

  Stream<QuerySnapshot> queryByCategory(int month, String categoryName) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Ingresos')
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: DateTime.now().year)
        .where("category", isEqualTo: categoryName)
        .snapshots();
  }

  Stream<QuerySnapshot> queryByMonth(int month) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Ingresos')
        .where("month", isEqualTo: month)
        .where("year", isEqualTo: DateTime.now().year)
        .snapshots();
  }

  delete(String documentId) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Ingresos')
        .doc(documentId)
        .delete();
  }

  add(String category, int value, String description, DateTime date) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Ingresos')
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
