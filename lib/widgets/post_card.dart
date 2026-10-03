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
  bool isSaved = false;

  late AnimationController _smallHeartController;
  late Animation<double> _smallHeartScale;

  late AnimationController _bigHeartController;
  late Animation<double> _bigHeartScale;
  late Animation<double> _bigHeartOpacity;

  @override
  void initState() {
    super.initState();
    isLiked = false;
    likeCount = widget.post.likes;

    _smallHeartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _smallHeartScale = Tween<double>(begin: 1.0, end: 1.4)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(_smallHeartController);

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

  void _toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isSaved ? "Postingan disimpan" : "Postingan dihapus dari simpanan"),
        duration: const Duration(seconds: 1),
      ),
    );
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

  // ===== BOTTOM SHEET COMMENT =====
  void _openComments() {
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Komentar",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Divider(),
                    Expanded(
                      child: widget.post.comments.isEmpty
                          ? const Center(
                              child: Text(
                                "Belum ada komentar.\nJadilah yang pertama berkomentar!",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: widget.post.comments.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.grey,
                                        child: Icon(Icons.person, size: 18, color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            style: const TextStyle(color: Colors.black, fontSize: 14),
                                            children: [
                                              const TextSpan(
                                                text: "pengguna ",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              TextSpan(text: widget.post.comments[index]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, size: 18, color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              decoration: const InputDecoration(
                                hintText: "Tambahkan komentar...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              final text = commentController.text.trim();
                              if (text.isEmpty) return;
                              setSheetState(() {
                                widget.post.comments.add(text);
                              });
                              setState(() {});
                              commentController.clear();
                              FocusScope.of(context).unfocus();
                            },
                            child: const Text(
                              "Kirim",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ===== BOTTOM SHEET SHARE =====
  void _openShareSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final options = [
          {"icon": Icons.link, "label": "Salin Link"},
          {"icon": Icons.chat_bubble_outline, "label": "Kirim via Pesan"},
          {"icon": Icons.more_horiz, "label": "Lainnya"},
        ];

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Bagikan ke",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              ...options.map((opt) {
                return ListTile(
                  leading: Icon(opt["icon"] as IconData),
                  title: Text(opt["label"] as String),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Postingan dibagikan: ${opt["label"]}')),
                    );
                  },
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ===== BOTTOM SHEET MORE OPTIONS (titik tiga) =====
  void _openMoreOptions() {
    final post = widget.post;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Postingan dari ${post.username}",
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.report_outlined, color: Colors.red),
                title: const Text("Laporkan", style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Postingan ${post.username} dilaporkan')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_remove_outlined),
                title: Text("Batal Ikuti ${post.username}"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Berhenti mengikuti ${post.username}')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text("Salin Link"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Link disalin ke clipboard')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("Tentang Akun Ini"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Info akun ${post.username}')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel_outlined),
                title: const Text("Batal"),
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
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
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                backgroundImage: NetworkImage(post.userImage),
                onBackgroundImageError: (exception, stackTrace) {},
              ),
              const SizedBox(width: 8),
              Text(
                post.username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (post.isVerified) ...[
                const SizedBox(width: 4),
                const Icon(Icons.verified, color: Colors.blue, size: 16),
              ],
              const Spacer(),
              GestureDetector(
                onTap: _openMoreOptions,
                child: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),

        // Gambar post + double tap to like + animasi hati besar
        GestureDetector(
          onDoubleTap: _handleDoubleTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                post.postImage,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: Colors.grey[200],
                    height: 300,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    height: 300,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey,
                            size: 40,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Gambar tidak dapat dimuat",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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

        // Aksi (like, comment, share, save)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
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
              IconButton(
                icon: const Icon(Icons.mode_comment_outlined),
                onPressed: _openComments,
              ),
              IconButton(
                icon: const Icon(Icons.send_outlined),
                onPressed: _openShareSheet,
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.black,
                ),
                onPressed: _toggleSave,
              ),
            ],
          ),
        ),

        // Likes & caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$likeCount likes",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "${post.username} ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: post.caption),
                  ],
                ),
              ),
              if (post.comments.isNotEmpty) ...[
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: _openComments,
                  child: Text(
                    "Lihat semua ${post.comments.length} komentar",
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ],
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}