import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jrpg_dart/models/race.dart';

import '../models/character.dart';
import '../models/character_class.dart';
import '../models/equipment.dart';
import '../widget/character_status_widget.dart';
import '../widget/combat_control_widget.dart';
import '../widget/combat_log_widget.dart';
import '../widget/endofcombat_widget.dart';

class GameScreen extends StatefulWidget {
  final Character character;

  GameScreen({required this.character});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Character? player1;
  Character? player2;
  bool isPlayer1Turn = true;
  late int initialPlayerHealth;
  List<String> combatLogs = [];

  @override
  void initState() {
    super.initState();
    initialPlayerHealth = widget.character.health;

    // Déterminer aléatoirement qui commence
    resetGame();
  }

  void resetGame() {
    setState(() {
      player1 = widget.character;
      player1!.health = initialPlayerHealth; // Réinitialiser la santé du joueur

      // Générez un adversaire aléatoire
      Race randomRace = getRandomRace();
      int randomHealth = Random().nextInt(20) + 80; // santé entre 80 et 100
      int randomMagic = Random().nextInt(5) + 5; // magie entre 5 et 10
      int randomAttack = Random().nextInt(5) + 5; // attaque entre 5 et 10

      EquipmentSet randomEquipmentSet = availableEquipmentSets[
          Random().nextInt(availableEquipmentSets.length)];
      Equipement randomEquipment = randomEquipmentSet.weapons.first; // Example
      CharacterClass randomClass =
          availableClasses[Random().nextInt(availableClasses.length)];
      player2 = Character(
        'Adversaire',
        randomHealth,
        randomMagic,
        randomRace,
        randomClass, // Utilisation de la classe aléatoire
        randomAttack,
        randomEquipment,
      );

      combatLogs.clear();
    });
  }

  void performTurn() {
    setState(() {
      // Déterminer aléatoirement quel joueur joue ce tour
      bool isPlayer1Active = Random().nextBool();

      if (isPlayer1Active && player1!.isAlive && player2!.isAlive) {
        combatLogs.add("Tour de ${player1!.name}");
        player1!.performTurn(player2!, combatLogs);
      } else if (!isPlayer1Active && player1!.isAlive && player2!.isAlive) {
        combatLogs.add("Tour de ${player2!.name}");
        player2!.performTurn(player1!, combatLogs);
      }

      if (!player1!.isAlive) {
        print("${player1!.name} est vaincu !");
      }

      if (!player2!.isAlive) {
        print("${player2!.name} est vaincu !");
      }
    });
  }

  void resetOpponentHealth() {
    setState(() {
      player2!.health = Random().nextInt(20) + 80; // santé entre 80 et 100
    });
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CharacterStatusWidget(character: player1!),
            CharacterStatusWidget(character: player2!),
            CombatControlsWidget(
                performTurn: performTurn,
                resetGame: resetGame,
                resetOpponentHealth:
                    resetOpponentHealth), // Ajout d'un bouton pour réinitialiser les HP de l'adversaire
            CombatLogWidget(combatLogs: combatLogs),
          ],
        ),
        if (!player1!.isAlive || !player2!.isAlive)
          EndOfCombatWidget(
            isPlayer1Alive: player1!.isAlive,
            player1Name: player1!.name,
            player2Name: player2!.name,
            resetGame: resetGame,
          ),
      ],
    );
  }
}
