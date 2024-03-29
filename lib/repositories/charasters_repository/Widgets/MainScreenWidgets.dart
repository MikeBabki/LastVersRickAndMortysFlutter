import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/characters_list_bloc.dart';
import '../../../main.dart';

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
@override
Widget build(BuildContext context) {
  var _charactersListBloc;
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

Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text(characterName ?? '...')),
  );
}