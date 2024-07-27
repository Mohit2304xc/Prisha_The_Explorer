import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prishathe/Model/CategoryModel.dart';
import 'dart:convert';

import '../Model/ShopModel.dart';
import '../Widgets/API_Connection/API_connection.dart';

class ShopController extends GetxController {
  static ShopController get instance => Get.find();

  var products = <ShopModel>[].obs;
  var category = <CategoryModel>[].obs;
  var filteredProducts = <ShopModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    fetchCategory();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(API.fetch));
      print("Product API Response: ${response.body}"); // Debug print

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        print("Parsed Products: $jsonResponse"); // Debug print

        products.value =
            jsonResponse.map((data) => ShopModel.fromJson(data)).toList();
        filteredProducts.value = products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCategory() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(API.categories));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse['categories'];
        category.value = data.map((item) => CategoryModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isLoading(false);
    }
  }

  void filterProductsByCategory(String categoryName) {
    if (categoryName == 'All') {
      filteredProducts.value = products;
    } else {
      filteredProducts.value = products.where((product) {
        return product.category.any((category) => category.contains(categoryName));
      }).toList();
    }
  }
}
