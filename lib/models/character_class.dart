import 'equipment.dart';

class CharacterClass {
  final String name;
  final List<EquipmentSet> allowedEquipmentSets; // Ajoutez ce champ

  CharacterClass(this.name, this.allowedEquipmentSets);
}

final warriorClass = CharacterClass(
    'Guerrier', [warriorEquipmentSet, humanEquipmentSet]); // Exemple

final wizardClass =
    CharacterClass('Sorcier', [wizardEquipmentSet, elfEquipmentSet]); // Exemple

final thiefClass = CharacterClass(
    'Voleur', [thiefEquipmentSet, goblinEquipmentSet]); // Exemple

final availableClasses = [
  warriorClass,
  wizardClass,
  thiefClass,
]; // Ajoutez cette liste
