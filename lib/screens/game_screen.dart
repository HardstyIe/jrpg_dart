import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jrpg_dart/models/race.dart';

import '../models/character.dart';

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
  List<String> combatLogs = [];

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      player1 = Character(
        widget.character.name,
        100 +
            widget.character.race.healthBonus, // santé de base + bonus de race
        10 + widget.character.race.magicBonus, // magie de base + bonus de race
        widget.character.race,
        5 +
            widget
                .character.race.attackBonus, // attaque de base + bonus de race
      );

      Race randomRace = getRandomRace();
      int randomHealth = Random().nextInt(20) + 80;
      int randomMagic = Random().nextInt(5) + 5;
      int randomAttack = Random().nextInt(5) + 5;

      player2 = Character(
          'Adversaire', randomHealth, randomMagic, randomRace, randomAttack);

      combatLogs.clear();
    });
  }

  void performTurn() {
    setState(() {
      if (isPlayer1Turn && player1!.isAlive && player2!.isAlive) {
        print("Tour de ${player1!.name}");
        player1!.performTurn(player2!, combatLogs);
      } else if (!isPlayer1Turn && player1!.isAlive && player2!.isAlive) {
        print("Tour de ${player2!.name}");
        player2!.performTurn(player1!, combatLogs);
      }

      if (!player1!.isAlive) {
        print("${player1!.name} est vaincu !");
      }

      if (!player2!.isAlive) {
        print("${player2!.name} est vaincu !");
      }

      isPlayer1Turn = !isPlayer1Turn; // Change le tour
    });
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                '${player1!.name}: ${player1!.health} HP, ${player1!.magic} MP'),
            Text(
                '${player2!.name}: ${player2!.health} HP, ${player2!.magic} MP'),
            ElevatedButton(
              onPressed: () {
                performTurn();
              },
              child: Text('Prochain tour'),
            ),
            ElevatedButton(
              onPressed: () {
                resetGame();
              },
              child: Text('Réinitialiser'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: combatLogs.length,
                itemBuilder: (context, index) {
                  return Text(combatLogs[index]);
                },
              ),
            ),
          ],
        ),
        if (!player1!.isAlive || !player2!.isAlive)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      player1!.isAlive
                          ? "${player1!.name} a gagné le combat"
                          : "${player2!.name} a gagné le combat",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        resetGame();
                      },
                      child: Text('Fermer'),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
