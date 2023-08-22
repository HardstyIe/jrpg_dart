import 'package:flutter/material.dart';

class EndOfCombatWidget extends StatelessWidget {
  final bool isPlayer1Alive;
  final String player1Name;
  final String player2Name;
  final Function resetGame;

  EndOfCombatWidget({
    required this.isPlayer1Alive,
    required this.player1Name,
    required this.player2Name,
    required this.resetGame,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                isPlayer1Alive
                    ? "$player1Name a gagné le combat"
                    : "$player2Name a gagné le combat",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () => resetGame(),
                child: Text('Fermer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
