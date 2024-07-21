import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_list/controllers/DBController.dart';
import 'package:infinite_list/models/FavoriteProduct.dart';

import '../models/Product.dart';

class ProductProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isScrollFetch = false;
  bool isError = false;
  List<Product> listProducts = [];
  List<Product> listProductsSearch = [];
  List<Product> listProductsFav = [];
  List<FavoriteProduct> listFavoriteProducts = [];

  Future<void> getProduct({int limit = 20, required int skip}) async {
    final url = "https://dummyjson.com/products?limit=$limit&skip=$skip";
    final uri = Uri.parse(url);
    isLoading = true;
    isError = false;
    notifyListeners();
    try {
      final response = await http.get(uri).timeout(
            const Duration(seconds: 5),
            onTimeout: () => http.Response('timeout', 408),
          );
      if (response.statusCode == 200) {
        List<Product> list = (jsonDecode(response.body)['products'] as List).map((item) {
          return Product.fromJson(item);
        }).toList();
        listProducts.addAll(list);
        isLoading = false;
        isError = false;
      } else {
        isLoading = false;
        isError = true;
      }
    } catch (e) {
      isLoading = false;
      isError = true;
    }
    notifyListeners();
  }

  Future<void> searchProduct({required String key}) async {
    if (key.isEmpty) {
      listProductsSearch.clear();
      notifyListeners();
      return;
    }
    final url = "https://dummyjson.com/products/search?q=$key";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      listProductsSearch = (jsonDecode(response.body)['products'] as List).map((item) {
        return Product.fromJson(item);
      }).toList();
    }
    notifyListeners();
  }

  Future<void> getFavoriteProducts() async {
    listFavoriteProducts = await DBController().getFavoriteList();
    notifyListeners();
  }

  Future<void> setFavoriteProducts({required bool isFavorite, required int idProduct, int? id}) async {
    if (isFavorite) {
      DBController().insertItemIntoFavorite(idProduct);
    } else if (!isFavorite && id != null) {
      DBController().deleteItemIntoFavorite(id);
    }
    listFavoriteProducts = await DBController().getFavoriteList();
    notifyListeners();
  }

  void getListProductFavorite() {
    listProductsFav.clear();
    for (var item in listProducts) {
      for (var fav in listFavoriteProducts) {
        if (item.id == fav.idProduct) {
          listProductsFav.add(item);
        }
      }
    }
    notifyListeners();
  }
}
