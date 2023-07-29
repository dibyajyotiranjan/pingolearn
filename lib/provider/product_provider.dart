
import 'package:flutter/material.dart';
import 'package:pingolearn/model/product_model.dart';
import 'package:pingolearn/services/repository/repository.dart';

class ProductProvider extends ChangeNotifier{
final _repository = ProductRepository();
bool isloading = false;
List product =[];
Future<void> getAllProduct()async {
  isloading = true;
  notifyListeners();
final response = await _repository.getproduct();
product = [...response.products!];
isloading = false;
notifyListeners();
}
}