import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  final ValueChanged<int> updateDrawer;

  const MenuDrawer({
    super.key,
    required this.selectedIndex,
    required this.updateDrawer,
  });

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: Text(
              'Navigate to...',
            ),
          ),
          ListTile(
            title: const Text('Home'),
            selected: selectedIndex == 0,
            onTap: () {
              updateDrawer(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Watchlist'),
            selected: selectedIndex == 1,
            onTap: () {
              updateDrawer(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Watched'),
            selected: selectedIndex == 2,
            onTap: () {
              updateDrawer(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Ignored'),
            selected: selectedIndex == 3,
            onTap: () {
              updateDrawer(3);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
