import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  });

  void setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.https(
      'flutter-udemy-e43de-default-rtdb.firebaseio.com',
      '/userFavorites/$userId/${id}.json',
      {'auth': '$authToken'},
    );
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode > 400) {
        setFavValue(oldStatus);
      }
    } catch (error) {
      setFavValue(oldStatus);
    }
  }
}
