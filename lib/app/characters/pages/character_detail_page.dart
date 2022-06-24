import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmorty/app/characters/pages/characters_list_page_theme.dart';
import 'package:rickmorty/app/episodes/bloc/episodes_bloc.dart';
import 'package:rickmorty/core/constants.dart';
import 'package:rickmorty/core/themes/text_theme.dart';
import 'package:rickmorty/core/widgets/info_container.dart';
import 'package:rickmorty/core/widgets/text.dart';
import 'package:rickmorty/domain/models/character.dart';
import 'package:rickmorty/domain/models/episode.dart';

class CharacterDetailPage extends StatefulWidget {
  const CharacterDetailPage({Key? key, required this.character})
      : super(key: key);

  static const routeName = '/CharacterDetailPage';

  final Character character;

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  late EpisodesBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<EpisodesBloc>(context);
    bloc.add(GetEpisodesEvent(episodes: widget.character.episodes));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EpisodesBloc, EpisodesState>(
        builder: (context, state) {
          if (state is SuccessfulState) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  _CharacterHeader(character: widget.character),
                  listSeparator,
                  const RMText(
                    text: 'Información',
                    type: RMTextTypes.infoMain,
                  ),
                  _CharacterInfo(character: widget.character),
                  listSeparator,
                  const RMText(
                    text: 'Episodios',
                    type: RMTextTypes.infoMain,
                  ),
                  _CharacterEpisodes(episodes: state.episodes),
                  listSeparator,
                ],
              ),
            );
          } else if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _CharacterEpisodes extends StatelessWidget {
  const _CharacterEpisodes({Key? key, required this.episodes})
      : super(key: key);

  final List<Episode> episodes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          episodes.length,
          (index) => SizedBox(
                width: double.infinity,
                child: RMInfoContainer(
                  title: episodes[index].name ?? '',
                  text: episodes[index].episode ?? '',
                  date: episodes[index].airDate ?? '',
                ),
              )),
    );
  }
}

class _CharacterInfo extends StatelessWidget {
  const _CharacterInfo({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: RMInfoContainer(
            title: 'Gerder:',
            text: genderValues.entries
                .firstWhere((e) => e.value == character.gender)
                .key,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: RMInfoContainer(
            title: 'Origin:',
            text: character.origin ?? '',
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: RMInfoContainer(
            title: 'Type:',
            text: character.type ?? '',
          ),
        ),
      ],
    );
  }
}

class _CharacterHeader extends StatelessWidget {
  const _CharacterHeader({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(character.image ?? ''),
          radius: 90,
        ),
        const SizedBox(
          height: 8,
        ),
        RMText(text: character.status ?? '', type: RMTextTypes.headerSub),
        const SizedBox(
          height: 8,
        ),
        RMText(
          text: character.name ?? '',
          type: RMTextTypes.header,
        ),
        const SizedBox(
          height: 8,
        ),
        RMText(text: character.specie ?? '', type: RMTextTypes.headerSub),
      ],
    );
  }
}
