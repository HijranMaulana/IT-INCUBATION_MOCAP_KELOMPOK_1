import 'package:flutter/material.dart';

class StoryList extends StatelessWidget {
  const StoryList({super.key});

  static const List<Map<String, String>> stories = [
    {
      'name': 'Your Story',
      'profile': 'https://picsum.photos/seed/profile1/150/150',
      'story': 'https://picsum.photos/seed/story1/800/1200',
    },
    {
      'name': 'Nabila',
      'profile': 'https://picsum.photos/seed/profile2/150/150',
      'story': 'https://picsum.photos/seed/story2/800/1200',
    },
    {
      'name': 'Raka',
      'profile': 'https://picsum.photos/seed/profile3/150/150',
      'story': 'https://picsum.photos/seed/story3/800/1200',
    },
    {
      'name': 'Adit',
      'profile': 'https://picsum.photos/seed/profile4/150/150',
      'story': 'https://picsum.photos/seed/story4/800/1200',
    },
    {
      'name': 'Salsa',
      'profile': 'https://picsum.photos/seed/profile5/150/150',
      'story': 'https://picsum.photos/seed/story5/800/1200',
    },
    {
      'name': 'Fahmi',
      'profile': 'https://picsum.photos/seed/profile6/150/150',
      'story': 'https://picsum.photos/seed/story6/800/1200',
    },
    {
      'name': 'Putri',
      'profile': 'https://picsum.photos/seed/profile7/150/150',
      'story': 'https://picsum.photos/seed/story7/800/1200',
    },
    {
      'name': 'Bagas',
      'profile': 'https://picsum.photos/seed/profile8/150/150',
      'story': 'https://picsum.photos/seed/story8/800/1200',
    },
    {
      'name': 'Dinda',
      'profile': 'https://picsum.photos/seed/profile9/150/150',
      'story': 'https://picsum.photos/seed/story9/800/1200',
    },
    {
      'name': 'Rizky',
      'profile': 'https://picsum.photos/seed/profile10/150/150',
      'story': 'https://picsum.photos/seed/story10/800/1200',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: true,
                  pageBuilder: (_, __, ___) => StoryViewer(
                    stories: stories,
                    initialIndex: index,
                  ),
                ),
              );
            },
            child: Container(
              width: 78,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                children: [
                  // INSTAGRAM RING
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFFFEDA75),
                          Color(0xFFFA7E1E),
                          Color(0xFFD62976),
                          Color(0xFF962FBF),
                          Color(0xFF4F5BD5),
                        ],
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.network(
                          story['profile']!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    story['name']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class StoryViewer extends StatefulWidget {
  final List<Map<String, String>> stories;
  final int initialIndex;

  const StoryViewer({
    super.key,
    required this.stories,
    required this.initialIndex,
  });

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer>
    with SingleTickerProviderStateMixin {
  late int currentIndex;

  late AnimationController _progressController;

  bool isLiked = false;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _startStory();
  }

  void _startStory() {
    _progressController
      ..reset()
      ..forward();

    _progressController.removeStatusListener(_storyFinished);

    _progressController.addStatusListener(_storyFinished);
  }

  void _storyFinished(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _nextStory();
    }
  }

  void _nextStory() {
    if (currentIndex < widget.stories.length - 1) {
      setState(() {
        currentIndex++;
        isLiked = false;
      });

      _startStory();
    } else {
      Navigator.pop(context);
    }
  }

  void _previousStory() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        isLiked = false;
      });

      _startStory();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.stories[currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapUp: (details) {
          final width = MediaQuery.of(context).size.width;

          if (details.localPosition.dx < width / 2) {
            _previousStory();
          } else {
            _nextStory();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ==============================
            // STORY IMAGE
            // ==============================

            Image.network(
              story['story']!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: Colors.grey.shade900,
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                );
              },
            ),

            // ==============================
            // DARK GRADIENT
            // ==============================

            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                    Colors.black54,
                  ],
                  stops: [
                    0,
                    0.45,
                    1,
                  ],
                ),
              ),
            ),

            // ==============================
            // PROGRESS BAR
            // ==============================

            Positioned(
              top: 10,
              left: 8,
              right: 8,
              child: Row(
                children: List.generate(
                  widget.stories.length,
                  (index) {
                    return Expanded(
                      child: Container(
                        height: 3,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: index < currentIndex
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )
                            : index == currentIndex
                                ? AnimatedBuilder(
                                    animation: _progressController,
                                    builder: (context, child) {
                                      return FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor:
                                            _progressController.value,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const SizedBox(),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ==============================
            // USER PROFILE
            // ==============================

            Positioned(
              top: 30,
              left: 15,
              right: 8,
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      story['profile']!,
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          width: 42,
                          height: 42,
                          color: Colors.grey,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  Text(
                    story['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    '5m',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),

                  const Spacer(),

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),

            // ==============================
            // BOTTOM ACTION
            // ==============================

            Positioned(
              left: 12,
              right: 12,
              bottom: 20,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white70,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Kirim pesan...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // LIKE
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    child: Icon(
                      isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.white,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 18),

                  const Icon(
                    Icons.send_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}