import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/helper/api.dart';
import 'package:store/models/product_model.dart';

class GetCategoryOfProductService {
  Future<List<ProductModel>> getAllProducts(
      {required String categoryName}) async {
    String baseUrl = 'https://fakestoreapi.com/products/category/$categoryName';

    http.Response response = await Api().get(url: baseUrl, token: null);

    List<dynamic> data = jsonDecode(response.body);
    List<ProductModel> productList = [];
    for (var i = 0; i < data.length; i++) {
      productList.add(
        ProductModel.fromJson(data[i]),
      );
    }
    return productList;
  }
}
