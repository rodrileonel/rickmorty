import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmorty/app/characters/bloc/characters_bloc.dart';
import 'package:rickmorty/app/characters/pages/characters_list_page.dart';
import 'package:rickmorty/app/episodes/bloc/episodes_bloc.dart';

import 'core/di.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CharactersBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<EpisodesBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RickMorty App',
        initialRoute: CharactersListPage.routeName,
        routes: {
          CharactersListPage.routeName: (_) => const CharactersListPage(),
        },
      ),
    );
  }
}
