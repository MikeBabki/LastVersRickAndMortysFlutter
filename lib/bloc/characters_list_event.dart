part of 'characters_list_bloc.dart';

class CharacterListEvent{}

abstract class LoadCharactersList extends CharacterListEvent {
  final bool isRefresh;
  const LoadCharactersList({required this.isRefresh});
}

class DataLoadingEvent extends LoadCharactersList {
  DataLoadingEvent({required bool isRefresh}) : super(isRefresh: isRefresh)
}

