import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

const String baseUrl = 'https://orji-book-api.glitch.me/books';

class BaseClient {
  static var client = http.Client();

  //GET
  Future<dynamic> get() async {
    var url = Uri.parse(baseUrl);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return userFromJson(json);
    } else {
      return const Center(
        child: Text('An error occured'),
      );
    }
  }

  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl);
    var _payload = json.encode(object);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'Content-Type': 'application/json',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.post(url, body: _payload, headers: _headers);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  ///PUT Request
  Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(baseUrl);
    var _payload = json.encode(object);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'Content-Type': 'application/json',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.put(url, body: _payload, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  Future<dynamic> delete(String api) async {
    var url = Uri.parse(baseUrl);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.delete(url, headers: _headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return userFromJson(json);
    } else {
      return const Center(
        child: Text('An error occured - Could not delete'),
      );
    }
  }
}

Future<http.Response> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://orji-book-api.glitch.me/books/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
}
