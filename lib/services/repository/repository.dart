
import 'package:pingolearn/model/product_model.dart';
import 'package:pingolearn/services/provider/api_helper.dart';

class ProductRepository {

  Future<ProductDtl> getproduct() async{
    String url ="https://dummyjson.com/products";
    var data = await ApiHelper().getApi(url:url);
    return ProductDtl.fromJson(data);
  }
}