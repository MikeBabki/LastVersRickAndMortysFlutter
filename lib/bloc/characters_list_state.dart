part of 'characters_list_bloc.dart';

class CharacterListState{}

class CharactersListInitial extends CharacterListState {}

class CharactersListLoading extends CharacterListState {}

class CharactersListLoaded extends CharacterListState {
  final List<CharactersModel>? charactersList;
  CharactersListLoaded(this.charactersList);
}

