import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remoteokio/models/remoteok.dart';
import 'package:http/http.dart' as http;

class RemoteokState with ChangeNotifier {
  List<Remoteok>? _remoteok;
  String _search = "";

  Future<List<Remoteok>> fetchRemoteok() async {
    try {
      Uri url = Uri.https("remoteok.io", "/api");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var responseJson =
            jsonDecode(response.body).cast<Map<String, dynamic>>();
        _remoteok = responseJson
            .map<Remoteok>((json) => Remoteok.fromJson(json))
            .toList();
        _remoteok!.removeAt(0);
        return responseJson
            .map<Remoteok>((json) => Remoteok.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } on SocketException {
      return [];
    }
  }

  List<Remoteok>? get remoteoks => _search.isEmpty
      ? _remoteok
      : _remoteok!
          .where((element) =>
              element.position!.toLowerCase().contains(_search.toLowerCase()) ||
              element.company!.toLowerCase().contains(_search.toLowerCase()))
          .toList();

  void updateData(List<Remoteok> data) {
    _remoteok = data;
    notifyListeners();
  }

  void searchData(String search) {
    _search = search;
    notifyListeners();
  }
}
