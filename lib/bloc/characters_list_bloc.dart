import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortys/repositories/charasters_repository/implement_repository.dart';
import 'package:rickandmortys/repositories/charasters_repository/models/character_model.dart';

import '../repositories/charasters_repository/charactars_repository.dart';
part 'characters_list_state.dart';
part 'characters_list_event.dart';

class CharactersListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharactersListBloc() : super(CharactersListInitial())  {
    on<LoadCharactersList>((event, emit) async {
    final result = await CharactersRepository().getCharacterList(true);
    debugPrint('result is ${result}');
        emit(CharactersListLoaded(result));
    });
    }
  }

class HeroesBloc extends Bloc<CharacterListEvent, CharacterListState> {
  HeroesBloc({required this.repository}) : super(CharacterListState()) {
    on<CharactersListLoading>(_dataLoading);
    //on<OnShowDetails>(_onShowDetails);
  }

  final AbstractRickAndMortyRepository repository;

  _dataLoading(DataLoadingEvent event, Emitter<CharacterListState> emit) async {
    final heroes = await repository.getCharacterList(event.isRefresh);
    // emit(state.copyWith(heroes: heroes));
    emit(CharactersListLoaded());
  }
  // _onShowDetails(OnShowDetails event, Emitter<CharacterListState> emit) {
  //   Navigator.of(event.context).pushNamed(
  //     '/info',
  //     arguments: DetailsArguments(event.title, event.id),
  //   );
  // }
}