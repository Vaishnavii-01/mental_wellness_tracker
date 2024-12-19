import 'package:mental_wellness_tracker/components/my_drawer.dart';
import 'package:mental_wellness_tracker/components/my_mood_tile.dart';
import 'package:mental_wellness_tracker/models/mood.dart';
import 'package:mental_wellness_tracker/models/board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoodBoard extends StatelessWidget {
  const MoodBoard({super.key});

  @override
  Widget build(BuildContext context) {

    final moods = context.watch<Board>().board;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("MOOD Board"),
          actions: [

            IconButton(
                padding: const EdgeInsets.only(right: 25.0),
                onPressed: () => Navigator.pushNamed(context, '/mood_cart'),
                icon: const Icon(Icons.border_all_rounded))
          ],
        ),
        drawer: const MyDrawer(),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                "Pick your today's MOOD",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),

            SizedBox(
              height: 550,
              child: ListView.builder(
                itemCount: moods.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) {

                  final mood = moods[index];

                  return MyMoodTile(mood: mood);
                },
              ),
            ),
          ],
        ));
  }
}