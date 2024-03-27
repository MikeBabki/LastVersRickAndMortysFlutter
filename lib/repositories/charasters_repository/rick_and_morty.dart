import 'package:dio/dio.dart';
import 'package:rickandmortys/repositories/charasters_repository/models/character_model.dart';
import 'package:dio/dio.dart';

export 'implement_repository.dart';
export 'charactars_repository.dart';
export 'models/character_model.dart';

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
  await dio.get('$_baseUrl/character?page=$_page');
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
    throw Exception('Data loading error!');
  }
}
}