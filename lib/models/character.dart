import 'dart:math';

import 'race.dart';

class Character {
  String name;
  int health;
  int magic;
  int attackPower;
  Race race;
  int specialAttackCounter = 0;

  Character(this.name, this.health, this.magic, this.race, this.attackPower) {
    attackPower += race.attackBonus;
    magic += race.magicBonus;
    health += race.healthBonus;
  }

  bool get isAlive => health > 0;

  void attack(Character target, List<String> combatLogs) {
    int minDamage = (attackPower * 0.6).toInt();
    int maxDamage = (attackPower * 1.2).toInt();
    int damage = Random().nextInt(maxDamage - minDamage + 1) + minDamage;

    combatLogs.add("$name attaque ${target.name} pour $damage dégâts.");
    target.health -= damage;
  }

  void specialAttack(Character target, List<String> combatLogs) {
    combatLogs.add("$name utilise une attaque spéciale !");
    attack(target, combatLogs);
    attack(target, combatLogs);
  }

  void useMagic(List<String> combatLogs) {
    int recoveredHealth = (health * 0.5).toInt();
    combatLogs.add(
        "$name utilise de la magie pour récupérer $recoveredHealth points de vie.");
    health += recoveredHealth;
    magic = 0;
  }

  void performTurn(Character target, List<String> combatLogs) {
    specialAttackCounter++;

    if (health <= (0.3 * 100) && magic > 0) {
      useMagic(combatLogs);
      return;
    }

    if (specialAttackCounter >= 5) {
      specialAttack(target, combatLogs);
      specialAttackCounter = 0;
      return;
    }

    attack(target, combatLogs);
    magic += 2; // Récupérer 2 points de magie à chaque tour
  }
}
