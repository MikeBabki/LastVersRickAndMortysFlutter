import 'models/character_model.dart';

abstract class AbstractRickAndMortyRepository { 
  Future<List<CharactersModel>?> getCharacterList(bool refresh);
  Future<CharactersModel> getCharacterInfo(int id);
}