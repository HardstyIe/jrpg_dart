import 'package:flutter/material.dart';
import 'package:jrpg_dart/models/race.dart';

import './game_screen.dart';
import '../models/character.dart';

class CharacterCreationScreen extends StatefulWidget {
  @override
  _CharacterCreationScreenState createState() =>
      _CharacterCreationScreenState();
}

class _CharacterCreationScreenState extends State<CharacterCreationScreen> {
  String name = '';
  String selectedRace = 'Humain';
  int attackBonus = 0;
  int magicBonus = 0;
  int healthBonus = 0;

  void updateRaceBonuses(String race) {
    // Mettez à jour les bonus en fonction de la race sélectionnée
    // Par exemple :
    if (race == 'Orc') {
      attackBonus = 5;
      magicBonus = 0;
      healthBonus = 10;
    } else if (race == 'Elfe') {
      attackBonus = 5;
      magicBonus = 10;
      healthBonus = 0;
    }
    // etc...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Création de personnage')),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Nom'),
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          DropdownButton<String>(
            value: selectedRace,
            items: ['Humain', 'Orc', 'Elfe'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedRace = newValue!;
                updateRaceBonuses(newValue);
              });
            },
          ),
          Text('Bonus d\'attaque: $attackBonus'),
          Text('Bonus de magie: $magicBonus'),
          Text('Bonus de santé: $healthBonus'),
          ElevatedButton(
            onPressed: () {
              // Obtenez l'objet Race correspondant au nom de la race sélectionnée
              Race selectedRaceObject = getRaceByName(selectedRace);

              // Créez le personnage avec les valeurs sélectionnées
              Character newCharacter = Character(
                name,
                100 + healthBonus, // santé de base + bonus de race
                10 + magicBonus, // magie de base + bonus de race
                selectedRaceObject, // race sélectionnée
                5 + attackBonus, // attaque de base + bonus de race
              );

              // Naviguez vers l'écran de jeu et passez le nouveau personnage en argument
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GameScreen(character: newCharacter)));
            },
            child: Text('Créer personnage'),
          ),
        ],
      ),
    );
  }
}
