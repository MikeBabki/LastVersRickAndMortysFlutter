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
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
