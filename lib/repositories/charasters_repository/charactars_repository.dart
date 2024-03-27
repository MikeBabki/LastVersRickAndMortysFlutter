import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rickandmortys/repositories/charasters_repository/implement_repository.dart';
import 'package:rickandmortys/repositories/charasters_repository/models/character_model.dart';


class CharactersRepository implements AbstractRickAndMortyRepository {

  Dio dio = Dio();
  final List<CharactersModel> _characters = [];
  final _baseUrl = 'https://rickandmortyapi.com/api';
  int _page = 1;

  @override
  Future<List<CharactersModel>?> getCharacterList(bool refresh) async {
    if (refresh) { 
      _page++;
    } else { 
      _page = 1;
    }
    Response response =
        await dio.get('$_baseUrl/character');
    final data = response.data as Map<String, dynamic>;
    _characters.addAll(data['results']
        .map<CharactersModel>((json) => CharactersModel.fromJson(json))
        .toList());
    return _characters;
  }

  @override
  Future<CharactersModel> getCharacterInfo(int id) async {
    Response response =
        await dio.get('$_baseUrl/character/$id');
    if (response.statusCode == 200) {
      final data = response.data;
      final character = CharactersModel.fromJson(data);
      return character;
    } else {
      throw Exception('Load Error');
    }
  }
}

