import 'package:firebase_database/firebase_database.dart';

class ShoppingService {
  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('shopping_list');

  //TODO 1: Bikin method untuk get shopping list
  Stream<Map<String, String>> getShoppingList() {
    return _database.onValue.map((event) {
      final Map<String, String> items = {};
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          items[key] = value['name'] as String;
        });
      }
      return items;
    });
  }

  //TODO 2: Bikin method untuk add shopping item
  void addShoppingItem(String itemName) {
    _database.push().set({'name': itemName});
  }

  //TODO 3: Bikin method untuk remove shopping item
  Future<void> removeShoppingItem(String key) async {
    await _database.child(key).remove();
  }
}
