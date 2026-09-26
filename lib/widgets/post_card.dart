import 'package:flutter/material.dart';
import '../models/post_model.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with TickerProviderStateMixin {
  late bool isLiked;
  late int likeCount;

  // Controller buat animasi icon hati kecil (di bawah foto)
  late AnimationController _smallHeartController;
  late Animation<double> _smallHeartScale;

  // Controller buat animasi hati besar (muncul saat double tap di foto)
  late AnimationController _bigHeartController;
  late Animation<double> _bigHeartScale;
  late Animation<double> _bigHeartOpacity;

  @override
  void initState() {
    super.initState();
    isLiked = false;
    likeCount = widget.post.likes;

    // Animasi icon hati kecil: mengecil lalu membesar (efek "pop")
    _smallHeartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _smallHeartScale = Tween<double>(begin: 1.0, end: 1.4)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(_smallHeartController);

    // Animasi hati besar di tengah foto
    _bigHeartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _bigHeartScale = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_bigHeartController);
    _bigHeartOpacity = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 70),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
    ]).animate(_bigHeartController);
  }

  @override
  void dispose() {
    _smallHeartController.dispose();
    _bigHeartController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
    _smallHeartController.forward().then((_) => _smallHeartController.reverse());
  }

  void _handleDoubleTap() {
    if (!isLiked) {
      setState(() {
        isLiked = true;
        likeCount += 1;
      });
    }
    _bigHeartController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(post.userImage)),
              const SizedBox(width: 8),
              Text(post.username,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              const Icon(Icons.more_vert),
            ],
          ),
        ),

        // Gambar post + double tap to like + animasi hati besar
        GestureDetector(
          onDoubleTap: _handleDoubleTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(post.postImage, fit: BoxFit.cover, width: double.infinity),
              AnimatedBuilder(
                animation: _bigHeartController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _bigHeartOpacity.value,
                    child: Transform.scale(
                      scale: _bigHeartScale.value,
                      child: child,
                    ),
                  );
                },
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 100,
                  shadows: [
                    Shadow(color: Colors.black26, blurRadius: 10),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Aksi (like, comment, share)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              // Icon like dengan animasi scale + ganti warna/bentuk
              GestureDetector(
                onTap: _toggleLike,
                child: AnimatedBuilder(
                  animation: _smallHeartController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _smallHeartScale.value,
                      child: child,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.black,
                      size: 26,
                    ),
                  ),
                ),
              ),
              IconButton(icon: const Icon(Icons.mode_comment_outlined), onPressed: () {}),
              IconButton(icon: const Icon(Icons.send_outlined), onPressed: () {}),
              const Spacer(),
              IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
            ],
          ),
        ),

        // Likes & caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$likeCount likes",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: "${post.username} ",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: post.caption),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}