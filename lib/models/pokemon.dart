import 'package:flutter/material.dart';

class Pokemon {
  final int id;
  final String name;
  final String primaryType;
  final String? secondaryType;
  final int hp;
  final int attack;
  final int defense;
  final int speed;
  final double height; // in meters
  final double weight; // in kg
  final String description;
  final String imageUrl;
  final Color typeColor;
  final List<String> abilities;

  const Pokemon({
    required this.id,
    required this.name,
    required this.primaryType,
    this.secondaryType,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.height,
    required this.weight,
    required this.description,
    required this.imageUrl,
    required this.typeColor,
    required this.abilities,
  });

  int get totalStats => hp + attack + defense + speed;
}

// 5 Sample Pokemons as requested
final List<Pokemon> samplePokemons = [
  const Pokemon(
    id: 25,
    name: 'Pikachu',
    primaryType: 'Electric',
    secondaryType: null,
    hp: 35,
    attack: 55,
    defense: 40,
    speed: 90,
    height: 0.4,
    weight: 6.0,
    description:
        'Pikachu stores electricity in its cheeks. When it releases pent-up energy, it creates powerful lightning bolts!',
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
    typeColor: Colors.amber,
    abilities: ['Static', 'Lightning Rod'],
  ),
  const Pokemon(
    id: 6,
    name: 'Charizard',
    primaryType: 'Fire',
    secondaryType: 'Flying',
    hp: 78,
    attack: 84,
    defense: 78,
    speed: 100,
    height: 1.7,
    weight: 90.5,
    description:
        'It flies around the sky in search of powerful opponents. It breathes fire of such great heat that it melts anything.',
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png',
    typeColor: Colors.deepOrange,
    abilities: ['Blaze', 'Solar Power'],
  ),
  const Pokemon(
    id: 1,
    name: 'Bulbasaur',
    primaryType: 'Grass',
    secondaryType: 'Poison',
    hp: 45,
    attack: 49,
    defense: 49,
    speed: 45,
    height: 0.7,
    weight: 6.9,
    description:
        'There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.',
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
    typeColor: Colors.green,
    abilities: ['Overgrow', 'Chlorophyll'],
  ),
  const Pokemon(
    id: 7,
    name: 'Squirtle',
    primaryType: 'Water',
    secondaryType: null,
    hp: 44,
    attack: 48,
    defense: 65,
    speed: 43,
    height: 0.5,
    weight: 9.0,
    description:
        'Shoots water at prey while in the water. Withdraws into its shell when in danger.',
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png',
    typeColor: Colors.lightBlue,
    abilities: ['Torrent', 'Rain Dish'],
  ),
  const Pokemon(
    id: 94,
    name: 'Gengar',
    primaryType: 'Ghost',
    secondaryType: 'Poison',
    hp: 60,
    attack: 65,
    defense: 60,
    speed: 110,
    height: 1.5,
    weight: 40.5,
    description:
        'To steal the life of its target, it slips into the prey\'s shadow and silently waits for an opportunity.',
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/94.png',
    typeColor: Colors.purple,
    abilities: ['Cursed Body'],
  ),
];
