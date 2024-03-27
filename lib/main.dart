import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rickandmortys/bloc/characters_list_bloc.dart';

import 'package:rickandmortys/repositories/charasters_repository/charactars_repository.dart';
import 'package:rickandmortys/repositories/charasters_repository/models/character_model.dart';

void main() {
  runApp(const RickAndMortys());
}

class RickAndMortys extends StatelessWidget {
  const RickAndMortys({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RickAndMortysCharacters',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 49, 13, 255),
        dividerColor: Color.fromARGB(255, 255, 0, 0),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.yellow,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            )),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
          bodySmall: TextStyle(
              color: Colors.red, fontWeight: FontWeight.w400, fontSize: 12),
        ),
      ),
      routes: {
        '/': (context) =>
            MainPageScreen(
              title: 'Rick and Mortys Characters',
            ),
        '/detail': (context) => DetailInfoScreen(),
      },
    );
  }
}

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key, required this.title});

  final String title;

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  final _charactersListBloc = CharactersListBloc();

  @override
  void initState() {
    _charactersListBloc.add(LoadCharactersList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text('Rick And Mortys Characters',
            style: TextStyle(color: Colors.black)),
      ),
      body: BlocBuilder<CharactersListBloc, CharacterListState>(
        bloc: _charactersListBloc,
        builder: (context, state) {
          if (state is CharactersListLoaded) {
            debugPrint('list loaded ${state}');
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight, // Ограничение высоты
                    child: ListView.separated(
                      itemCount: state.charactersList!.length,
                      separatorBuilder: (context, index) => const Divider(color: Colors.black, height: 1),
                      itemBuilder: (context, i) {
                        final charName = state.charactersList![i];
                        return ListTile(
                          leading: Image.network(charName.image),
                          title: Text(charName.name, style: Theme.of(context).textTheme.bodyText1),
                          subtitle: Text(charName.status, style: Theme.of(context).textTheme.bodyText2),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
                }

                return const Center(child: CircularProgressIndicator());
          },
      ),
    );
  }
}

class DetailInfoScreen extends StatefulWidget {
  const DetailInfoScreen({super.key});

  @override
  State<DetailInfoScreen> createState() => _DetailInfoScreenState();
}

class _DetailInfoScreenState extends State<DetailInfoScreen> {
  String? characterName;

  @override
  void didChangeDependencies() {
    final args = ModalRoute
        .of(context)
        ?.settings
        .arguments;
    if (args == null) {
      log('You must provide args' as num);
      return;
    }

    if (args is! String) {
      log('You must provide String args' as num);
      return;
    }
    characterName = args;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(characterName ?? '...')),
    );
  }
}
