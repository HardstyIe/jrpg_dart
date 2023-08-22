import 'package:flutter/material.dart';
import 'package:jrpg_dart/models/character_class.dart'; // Import CharacterClass
import 'package:jrpg_dart/models/equipment.dart'; // Import Equipment class
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
  Race selectedRace = availableRaces.first;
  EquipmentSet selectedEquipmentSet = availableEquipmentSets.first;
  Equipement selectedEquipement = availableWeapons.first;
  CharacterClass selectedClass = availableClasses.first;

  // Statistiques de base
  int baseHealth = 100;
  int baseMagic = 10;
  int baseAttack = 5;

  @override
  Widget build(BuildContext context) {
    // Calculer les bonus
    int totalHealthBonus =
        selectedRace.healthBonus + selectedEquipement.healthBonus;
    int totalMagicBonus =
        selectedRace.magicBonus + selectedEquipement.magicBonus;
    int totalAttackBonus =
        selectedRace.attackBonus + selectedEquipement.attackBonus;

    // Calculer les statistiques finales
    int finalHealth = baseHealth + totalHealthBonus;
    int finalMagic = baseMagic + totalMagicBonus;
    int finalAttack = baseAttack + totalAttackBonus;

    List<EquipmentSet> allowedEquipmentSets = availableEquipmentSets
        .where(
          (set) => selectedClass.allowedEquipmentSets.contains(set),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Création de personnage')),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Nom'),
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          DropdownButton<Race>(
            value: selectedRace,
            items: availableRaces.map((Race race) {
              return DropdownMenuItem<Race>(
                value: race,
                child: Text(race.name),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedRace = newValue!;
                // Réinitialisez la sélection d'équipement lorsque la race change
                selectedEquipmentSet = availableEquipmentSets.first;
                selectedEquipement = selectedEquipmentSet.weapons.first;
                selectedClass =
                    availableClasses.first; // Réinitialiser la classe
              });
            },
          ),
          DropdownButton<EquipmentSet>(
            value: selectedEquipmentSet,
            items: allowedEquipmentSets.map((EquipmentSet set) {
              return DropdownMenuItem<EquipmentSet>(
                value: set,
                child: Text(set.name),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedEquipmentSet = newValue!;
                selectedEquipement = selectedEquipmentSet.weapons.first;
              });
            },
          ),
          DropdownButton<CharacterClass>(
            value: selectedClass,
            items: availableClasses.map((CharacterClass characterClass) {
              return DropdownMenuItem<CharacterClass>(
                value: characterClass,
                child: Text(characterClass.name),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedClass = newValue!;

                // Filtrer les ensembles d'équipement en fonction de la classe sélectionnée
                List<EquipmentSet> allowedEquipmentSets = availableEquipmentSets
                    .where(
                      (set) => selectedClass.allowedEquipmentSets.contains(set),
                    )
                    .toList();

                // Mettre à jour l'ensemble d'équipement sélectionné pour correspondre au premier ensemble d'équipement autorisé
                selectedEquipmentSet = allowedEquipmentSets.first;

                // Mettre à jour l'équipement sélectionné pour correspondre au premier équipement de l'ensemble d'équipement sélectionné
                selectedEquipement = selectedEquipmentSet.weapons.first;
              });
            },
          ),
          Text(
              'Santé de base: $baseHealth + Bonus: $totalHealthBonus = Total: $finalHealth'),
          Text(
              'Magie de base: $baseMagic + Bonus: $totalMagicBonus = Total: $finalMagic'),
          Text(
              'Attaque de base: $baseAttack + Bonus: $totalAttackBonus = Total: $finalAttack'),
          ElevatedButton(
            onPressed: () {
              // Créez le personnage avec les valeurs sélectionnées
              Character newCharacter = Character(
                name,
                finalHealth,
                finalMagic,
                selectedRace,
                selectedClass, // Utiliser la classe sélectionnée
                finalAttack,
                selectedEquipement,
              );

              // Naviguez vers l'écran de jeu et passez le nouveau personnage en argument
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GameScreen(character: newCharacter)));
            },
            child: const Text('Créer personnage'),
          ),
        ],
      ),
    );
  }
}
