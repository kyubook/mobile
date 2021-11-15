import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // required this widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyHomPage();
  }
}

class MyHomPage extends StatefulWidget {
  const MyHomPage({Key? key}) : super(key: key);

  @override
  _MyHomPageState createState() => _MyHomPageState();
}

class _MyHomPageState extends State<MyHomPage> {
  late final ValueNotifier<GraphQLClient> Client;

  @override
  void initState() {
    Client = ValueNotifier(
      GraphQLClient(
        link: HttpLink(''),
        cache: GraphQLCache(
          store: InMemoryStore(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Client,
      child: MaterialApp(
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Rick n Morty'),
            backgroundColor: Colors.black,
          ),
          body: const RickAndMortyChacactersListWidget(),
        ),
      ),
    );
  }
}

class RickAndMortyChacactersListWidget extends StatefulWidget {
  const RickAndMortyChacactersListWidget({
    Key? key,
  }) : super(key: key);

  @override
  _RickAndMortyChacactersListWidgetState createState() =>
      _RickAndMortyChacactersListWidgetState();
}

class _RickAndMortyChacactersListWidgetState
    extends State<RickAndMortyChacactersListWidget> {
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<bool> _isError = ValueNotifier(false);

  final List<RickNMortyCharacterModel> _characterLists = [
    RickNMortyCharacterModel(
      name: 'Rick Sanchez',
      dimension: '131',
      gender: 'Male',
      image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      species: 'Human',
      location: 'Citadel of Ricks',
      status: 'Alive',
    ),
    RickNMortyCharacterModel(
      name: 'Morty Smith',
      dimension: '131',
      gender: 'Male',
      image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
      species: 'Human',
      location: 'Citadel of Ricks',
      status: 'Alive',
    ),
    RickNMortyCharacterModel(
      name: 'Summer Smith',
      dimension: 'Earth (Replacement Dimension)',
      gender: 'Female',
      image: 'https://rickandmortyapi.com/api/character/avatar/3.jpeg',
      species: 'Human',
      location: 'Replacement Dimension',
      status: 'Alive',
    ),
    RickNMortyCharacterModel(
      name: 'Beth Smith',
      dimension: 'Earth (Replacement Dimension)',
      gender: 'Female',
      image: 'https://rickandmortyapi.com/api/character/avatar/4.jpeg',
      species: 'Human',
      location: 'Replacement Dimension',
      status: 'Alive',
    ),
    RickNMortyCharacterModel(
      name: 'Jerry Smith',
      dimension: 'Earth (Replacement Dimension)',
      gender: 'Male',
      image: 'https://rickandmortyapi.com/api/character/avatar/5.jpeg',
      species: 'Human',
      location: 'Replacement Dimension',
      status: 'Alive',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoading,
      builder: (context, isLoading, child) => isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : child!,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isError,
        builder: (context, hasError, child) => hasError
            ? const Center(
                child: Text(
                  'Something went Wrong..!!',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailsWidget(
                          RickNMortyCharacter: _characterLists[index],
                        ),
                      )),
                  child: Row(
                    children: [
                      Image.network(
                        _characterLists[index].image,
                        height: 50,
                        width: 50,
                      ),
                      Column(
                        children: [
                          Text(_characterLists[index].name),
                          Row(
                            children: [
                              const Text(
                                'Location ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _characterLists[index].location,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Text(
                                'Species ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _characterLists[index].species,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                itemCount: _characterLists.length,
              ),
      ),
    );
  }
}

class CharacterDetailsWidget extends StatelessWidget {
  final RickNMortyCharacterModel RickNMortyCharacter;
  const CharacterDetailsWidget({
    Key? key,
    required this.RickNMortyCharacter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RickNMortyCharacter.name),
      ),
      body: Column(
        children: [
          Image.network(RickNMortyCharacter.image),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'Status ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                RickNMortyCharacter.status,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text(
                'Gender ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                RickNMortyCharacter.gender,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text(
                'Species ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                RickNMortyCharacter.species,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text(
                'location ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                RickNMortyCharacter.location,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text(
                'Dimension ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                RickNMortyCharacter.dimension,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RickNMortyCharacterModel {
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final String location;
  final String dimension;

  RickNMortyCharacterModel({
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.location,
    required this.dimension,
  });
}
