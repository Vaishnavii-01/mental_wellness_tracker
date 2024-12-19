import 'package:flutter/material.dart';
import 'package:mental_wellness_tracker/models/mood.dart';

class Board extends ChangeNotifier {

  final List<Mood> _board = [
    Mood(
      name: "Happy",
      desc: "You're feeling upbeat and positive! Embrace the joy and energy of this moment, and let it fuel your day.",
      imagePath: 'assets/emoji_7632206.png',
    ),
    Mood(
      name: "Neutral",
      desc: "You're in a calm and balanced state. Everything feels steady, without highs or lows—just going with the flow.",
      imagePath: 'assets/man_14755968.png',
    ),
    Mood(
      name: "Sad",
      desc: "It seems like you're feeling down or a bit off today. It's okay to have these moments—acknowledge how you're feeling and take care of yourself.",
      imagePath: 'assets/person_14755951.png',
    ),
  ];


  final List<Mood> _userCart = [];


  List<Mood> get board => _board;

  List<Mood> get userCart => _userCart;


  void addMoodToCart(Mood mood) {
     final today = DateTime.now();

    // Check if any mood is already added today
    final existingMood = userCart.any((item) =>
        item.addedDate!.year == today.year &&
        item.addedDate!.month == today.month &&
        item.addedDate!.day == today.day);

    if (existingMood) {
      // Do not add; notify the user
      throw Exception("You can only select one mood per day.");
    }

    // Add the mood with the current date
    mood.addedDate = today;
    _userCart.add(mood);
    notifyListeners();
  }

  void removeMoodFromCart(Mood mood) {
    _userCart.remove(mood);
    notifyListeners();
  }
}