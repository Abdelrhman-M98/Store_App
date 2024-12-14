import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store/helper/api.dart';

class GetAllCategorisService {
  Future<List<dynamic>> getAllCategories() async {
    String baseUrl = 'https://fakestoreapi.com/products/categories';

    http.Response response = await Api().get(url: baseUrl, token: null);

    List<dynamic> data = jsonDecode(response.body);
    return data;
  }
}
