import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sharedpreference {
  Future<List<String>> getindexList() async {
    final prefs = await SharedPreferences.getInstance();
    final Listindex = prefs.getStringList('index') ?? [];
    return Listindex;
  }

  Future<List<String>> getindexnameList() async {
    final prefs = await SharedPreferences.getInstance();
    final surahindex = prefs.getStringList('surahIndex') ?? [];
    return surahindex;
  }
}
