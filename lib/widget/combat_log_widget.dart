import 'package:flutter/material.dart';

class CombatLogWidget extends StatelessWidget {
  final List<String> combatLogs;

  CombatLogWidget({required this.combatLogs});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: combatLogs.length,
        itemBuilder: (context, index) {
          return Text(combatLogs[index]);
        },
      ),
    );
  }
}
