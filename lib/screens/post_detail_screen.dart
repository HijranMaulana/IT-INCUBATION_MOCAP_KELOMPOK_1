import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../widgets/post_card.dart';

class PostDetailScreen extends StatelessWidget {
  final List<PostModel> posts;
  final int initialIndex;

  const PostDetailScreen({
    super.key,
    required this.posts,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        title: const Text("Posts"),
      ),
      // PageView vertikal: bisa swipe naik/turun buat pindah antar post,
      // dimulai dari foto yang di-tap (initialIndex)
      body: PageView.builder(
        controller: PageController(initialPage: initialIndex),
        scrollDirection: Axis.vertical,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: PostCard(post: posts[index]),
          );
        },
      ),
    );
  }
}