import 'package:flutter/material.dart';

class ProfileStats extends StatelessWidget {
  final int posts;
  final int followers;
  final int following;

  const ProfileStats({
    super.key,
    required this.posts,
    required this.followers,
    required this.following,
  });

  Widget _buildStat(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.black87)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStat("Posts", posts),
        _buildStat("Followers", followers),
        _buildStat("Following", following),
      ],
    );
  }
}