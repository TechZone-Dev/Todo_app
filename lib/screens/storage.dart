


import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'items.dart';

class Storage {
  static Future<void> saveItems(List<Item> items) async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = jsonEncode(items.map((item) => item.toJson()).toList());
    await prefs.setString('items', itemsJson);
  }

  static Future<List<Item>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getString('items');
    if (itemsJson != null) {
      final itemsList = jsonDecode(itemsJson) as List<dynamic>;
      return itemsList.map((item) => Item.fromJson(item)).toList();
    } else {
      return [];
    }

  }
}