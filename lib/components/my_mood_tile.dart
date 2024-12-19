import 'package:mental_wellness_tracker/models/mood.dart';
import 'package:mental_wellness_tracker/models/board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyMoodTile extends StatelessWidget {
  final Mood mood;
  const MyMoodTile({super.key, required this.mood});

  void addtoCart(BuildContext context) {
    try {
    context.read<Board>().addMoodToCart(mood);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Mood added successfully!"),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("You can only select one mood per day."),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(25.0),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12)),
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  child: Image.asset(mood.imagePath),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                mood.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                textAlign: TextAlign.left,
              ),
              Text(
                mood.desc,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12)),
                child: IconButton(
                  onPressed: () => addtoCart(context),
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}