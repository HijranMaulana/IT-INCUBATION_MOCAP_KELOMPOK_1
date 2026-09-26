import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/story_list.dart';
import '../widgets/post_card.dart';
import '../models/post_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        children: [
          const StoryList(),
          const Divider(),
          ...dummyPosts.map((post) => PostCard(post: post)),
        ],
      ),
    );
  }
}