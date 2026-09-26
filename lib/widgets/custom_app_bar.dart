import 'package:flutter/material.dart';
import '../screens/messages_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      title: const Text(
        "Instagram",
        style: TextStyle(
          fontFamily: 'Billabong', // opsional, kalau ga ada font ini pakai default
          fontSize: 28,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.send_outlined, color: Colors.black),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const MessagesScreen(),
              ),
            );
          },
        ),  
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}