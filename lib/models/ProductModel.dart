import 'package:alarm_app/Screen/home_screen.dart';
import 'package:alarm_app/db_helper/ProductSer.dart';

List<Product> recentProducts = [];
List<Product> ProductsListFound = [];

class Product {
  int? id;
  String? name;
  String? Expier;

  ProductMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['Expier'] = Expier!;
    return mapping;
  }
}
