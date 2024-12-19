import 'package:mental_wellness_tracker/components/my_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.face_2,
                    size: 72,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              MyListTile(
                  text: "Select your MOOD",
                  icon: Icons.home,
                  onTap: () => Navigator.pop(context)),

              MyListTile(
                  text: "MOOD Cart",
                  icon: Icons.border_all_rounded,
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamed(context, '/mood_cart');
                  }),

              MyListTile(
                  text: "ChatBot",
                  icon: Icons.computer_outlined,
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamed(context, '/chat_page');
                  }),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: MyListTile(
                text: "Exit",
                icon: Icons.logout,
                onTap: () {
                  Navigator.pop(context);

                  Navigator.pushNamed(context, '/intro_page');

                  SystemNavigator.pop();
                }),
          ),
        ],
      ),
    );
  }
}