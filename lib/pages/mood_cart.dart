import 'package:mental_wellness_tracker/components/my_button.dart';
import 'package:mental_wellness_tracker/models/mood.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/board.dart';
import 'package:intl/intl.dart';

class MoodCart extends StatelessWidget {
  const MoodCart({super.key});

  void removeMoodfromCart(BuildContext context, Mood mood) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Is this your MOOD for today?"),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<Board>().removeMoodFromCart(mood);
            },
            child: const Text("No"),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Board>().userCart;
    final sortedCart = [...cart]..sort((a, b) => b.addedDate!.compareTo(a.addedDate!));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("MOOD Cart"),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            child: sortedCart.isEmpty
                ? const Center(child: Text("You haven't selected any MOOD"))
                : ListView.builder(
                    itemCount: sortedCart.length,
                    itemBuilder: (context, index) {
                      final item = sortedCart[index];
                      final formattedDate = DateFormat('dd-MM-yyyy').format(item.addedDate!);
                        return ListTile(
                        title: Text(
                          item.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          formattedDate,
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        onTap: () => removeMoodfromCart(context, item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}