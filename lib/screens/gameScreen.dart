import 'package:flutter/material.dart';

import '../models/character.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Character player1 = Character('Joueur 1', 100, 10);
  Character player2 = Character('Joueur 2', 100, 10);
  bool isPlayer1Turn = true;
  List<String> combatLogs = [];

  void resetGame() {
    setState(() {
      player1 = Character('Joueur 1', 100, 10);
      player2 = Character('Joueur 2', 100, 10);
      combatLogs.clear();
    });
  }

  void performAttack() {
    setState(() {
      player1.attack(player2, combatLogs);
      if (!player2.isAlive) {
        print("${player2.name} est vaincu !");
      }
    });
  }

  void performTurn() {
    setState(() {
      if (isPlayer1Turn && player1.isAlive && player2.isAlive) {
        print("Tour de ${player1.name}");
        player1.performTurn(player2, combatLogs);
      } else if (!isPlayer1Turn && player1.isAlive && player2.isAlive) {
        print("Tour de ${player2.name}");
        player2.performTurn(player1, combatLogs);
      }

      if (!player1.isAlive) {
        print("${player1.name} est vaincu !");
      }

      if (!player2.isAlive) {
        print("${player2.name} est vaincu !");
      }

      isPlayer1Turn = !isPlayer1Turn; // Change le tour
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${player1.name}: ${player1.health} HP, ${player1.magic} MP'),
            Text('${player2.name}: ${player2.health} HP, ${player2.magic} MP'),
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
        if (!player1.isAlive || !player2.isAlive)
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
                      player1.isAlive
                          ? "Joueur 1 a gagné le combat"
                          : "Joueur 2 a gagné le combat",
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
