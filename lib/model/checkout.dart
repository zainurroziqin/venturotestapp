import 'package:venturotestapp/model/items.dart';

class Checkout {
  int id;
  Items item;
  String? catatan;
  int count;

  Checkout({required this.id, required this.item,  this.catatan, required this.count});

}
