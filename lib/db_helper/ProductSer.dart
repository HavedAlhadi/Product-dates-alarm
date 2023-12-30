import 'dart:async';
import 'package:alarm_app/db_helper/repository.dart';
import 'package:alarm_app/models/ProductModel.dart';

class ProductService {
  late Repository _repository;
  ProductService() {
    _repository = Repository();
  }
  //Save Product
  SaveProduct(Product Product) async {
    return await _repository.insertData('products', Product.ProductMap());
  }

  //Read All Products
  readAllProducts() async {
    return await _repository.readData('products');
  }

  //Edit Product
  UpdateProduct(Product Product) async {
    return await _repository.updateData('products', Product.ProductMap());
  }

  deleteProduct(ProductId) async {
    return await _repository.deleteDataById('products', ProductId);
  }
}
