import 'dart:math';

import 'package:flutter/foundation.dart';

class KeyboardState extends ChangeNotifier {
  // ignore: prefer_final_fields
  Set<String> _pressedKeys = {};
  static const List<String> _sampleTexts = [
    'The quick brown fox jumps over the lazy dog.',
    'Flutter is a framework for building beautiful apps.',
    'Practice makes perfect when typing fast.',
    'A journey of a thousand miles begins with a step.',
    'Coding is like poetry with logic and structure.',
    'The quick brown fox jumps over the lazy dog. Many people use this sentence to practice typing because it contains every letter in the alphabet.',
    'Morning light streams through the window as birds begin their cheerful songs. Coffee brews in the kitchen, filling the house with a pleasant aroma.',
    'Walking along the beach at sunset creates a sense of peace and tranquility. The waves crash against the shore in a rhythmic pattern.',
    'Reading books transports us to different worlds and perspectives. Learning new information expands our minds and helps us grow as individuals.',
    'Practice makes perfect when learning any new skill. Consistent effort over time leads to improvement and mastery.',
    'The beauty of nature surrounds us in every season. From blooming flowers in spring to falling leaves in autumn, each moment is a gift.',
    'Summer brings warm days and star filled nights. Children play outside until their parents call them home for dinner.',
    'Autumn leaves fall gently from trees, creating a colorful carpet on the ground. The crisp air signals the changing of seasons.',
    'Writing regularly improves communication skills and clarity of thought. Many successful people maintain journals to organize their ideas.',
    'Mountains tower in the distance, their peaks covered in snow even during summer months. Hiking trails wind through valleys and forests below.',
    'Cooking a meal from scratch requires patience and attention to detail. Fresh ingredients make all the difference in the final result.',
  ];
  String currentText = '';
  String userInput = '';
  int currentPosition = 0;
  bool isCompleted = false;

  Set<String> get pressedKeys => _pressedKeys;

  KeyboardState() {
    _loadRandomText();
  }

  void pressKey(String key) {
    _pressedKeys.add(key.toUpperCase());
    notifyListeners();
  }

  void releaseKey(String key) {
    _pressedKeys.remove(key.toUpperCase());
    notifyListeners();
  }

  void _loadRandomText() {
    currentText = _sampleTexts[Random().nextInt(_sampleTexts.length)];
    userInput = '';
    currentPosition = 0;
    isCompleted = false;
    notifyListeners();
  }

  void updateUserInput(String input) {
    if (isCompleted) return; // Предотвратить ввод после завершения

    userInput = input;
    currentPosition = input.length;

    if (currentPosition >= currentText.length) {
      isCompleted = true;
      Future.delayed(const Duration(seconds: 1), () {
        _loadRandomText();
      });
    }

    notifyListeners();
  }

  void resetText() {
    _loadRandomText();
  }

  void setText(String text) {
    currentText = text;
    userInput = '';
    currentPosition = 0;
    notifyListeners();
  }
}
