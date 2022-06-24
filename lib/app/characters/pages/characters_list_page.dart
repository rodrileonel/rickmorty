import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmorty/app/characters/bloc/characters_bloc.dart';
import 'package:rickmorty/app/characters/pages/character_detail_page.dart';
import 'package:rickmorty/core/constants.dart';
import 'package:rickmorty/core/widgets/button.dart';
import 'package:rickmorty/core/widgets/selectable_dialog.dart';
import 'package:rickmorty/core/widgets/text.dart';
import 'package:rickmorty/core/themes/text_theme.dart';
import 'package:rickmorty/domain/models/character.dart';

class CharactersListPage extends StatefulWidget {
  const CharactersListPage({Key? key}) : super(key: key);

  static const routeName = '/CharactersListPage';

  @override
  State<CharactersListPage> createState() => _CharactersListPageState();
}

class _CharactersListPageState extends State<CharactersListPage> {
  late Gender? gender;
  late Status? status;
  late CharactersBloc bloc;
  late TextEditingController controller;
  late ScrollController _scrollController;
  late List<Character> _listCharacters;

  @override
  void initState() {
    bloc = BlocProvider.of<CharactersBloc>(context);
    controller = TextEditingController(text: '');
    gender = null;
    status = null;
    _listCharacters = [];
    bloc.add(GetCharactersEvent(
        gender: gender, status: status, name: controller.text));
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              key: const Key('character-list-filter'),
              textInputAction: TextInputAction.search,
              controller: controller,
              onSubmitted: (value) {
                bloc.add(GetCharactersEvent(
                    gender: gender, status: status, name: controller.text));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: RMButton(
                    key: const Key('character-list-status-button'),
                    text: 'Status',
                    onTap: () async {
                      var selectedItem = await RMSelectableDialog.show(context,
                          title: 'Select Gender',
                          items:
                              statusValues.entries.map((e) => e.key).toList());
                      if (selectedItem != null) {
                        status = statusValues[selectedItem];
                        bloc.add(GetCharactersEvent(
                            gender: gender,
                            status: status,
                            name: controller.text));
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RMButton(
                    key: const Key('character-list-gender-button'),
                    text: 'Gender',
                    onTap: () async {
                      var selectedItem = await RMSelectableDialog.show(context,
                          title: 'Select Gender',
                          items:
                              genderValues.entries.map((e) => e.key).toList());
                      if (selectedItem != null) {
                        gender = genderValues[selectedItem];
                        bloc.add(GetCharactersEvent(
                            gender: gender,
                            status: status,
                            name: controller.text));
                      }
                    },
                  ),
                )
              ],
            ),
            BlocBuilder<CharactersBloc, CharactersState>(
              builder: (context, state) {
                if (state is SuccessfulState) {
                  _scrollController.addListener(() {
                    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
                      bloc.add(GetCharactersEvent(
                      gender: gender, status: status, name: controller.text, page: state.characters.first.page));
                    }
                  });
                  _listCharacters.addAll(state.characters);
                  return _CharacterList(scrollController: _scrollController, listCharacters: _listCharacters);
                } else if (state is LoadingState) {
                  return _CharacterList(scrollController: _scrollController, listCharacters: _listCharacters);
                } else if (state is ErrorState) {
                  return Expanded(
                      key: const Key('character-list-empty'),
                      child: Center(child: Text(state.message)));
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class _CharacterList extends StatelessWidget {
  const _CharacterList({
    Key? key,
    required ScrollController scrollController,
    required List<Character> listCharacters,
  }) : _scrollController = scrollController, _listCharacters = listCharacters, super(key: key);

  final ScrollController _scrollController;
  final List<Character> _listCharacters;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        key: const Key('character-list'),
        itemCount: _listCharacters.length,
        itemBuilder: (BuildContext context, int index) {
          return CharacterContainer(
            user: _listCharacters[index],
            onTap: (character) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CharacterDetailPage(character: character),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CharacterContainer extends StatelessWidget {
  final Character user;
  final Function(Character) onTap;

  const CharacterContainer(
      {super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () => onTap(user),
          child: Row(
            children: [
              Image.network(
                user.image ?? '',
                height: 100,
                width: 100,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RMText(
                    text: '${user.status} - ${user.specie}',
                    type: RMTextTypes.card1,
                  ),
                  RMText(
                    text: user.name ?? '',
                    type: RMTextTypes.cardTitle,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const RMText(
                    text: 'Last known location:',
                    type: RMTextTypes.cardLabel,
                  ),
                  RMText(
                    text: user.location ?? '',
                    type: RMTextTypes.cardSub,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
