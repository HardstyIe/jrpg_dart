import 'package:flutter/material.dart';
import 'package:jrpg_dart/models/character.dart';

class CharacterStatusWidget extends StatelessWidget {
  final Character character;

  CharacterStatusWidget({required this.character});

  @override
  Widget build(BuildContext context) {
    return Text(
        '${character.name}: ${character.health} HP, ${character.magic} MP');
  }
}
