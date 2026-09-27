import 'package:flutter/material.dart';

class InstagramSearchPage extends StatefulWidget {
  const InstagramSearchPage({Key? key}) : super(key: key);

  @override
  State<InstagramSearchPage> createState() => _InstagramSearchPageState();
}

class _InstagramSearchPageState extends State<InstagramSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  // List Kategori Filter
  final List<String> _categories = [
    'IGTV',
    'Toko',
    'Seni',
    'Musik',
    'Olah Raga',
    'Makanan',
    'Gaya Hidup',
    'Mode',
  ];

  // Dummy Image URLs dari Unsplash
  final List<String> _dummyImages = List.generate(
    20,
    (index) => 'https://picsum.photos/id/${index + 10}/400/400',
  );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark Mode khas Instagram
      body: SafeArea(
        child: Column(
          children: [
            // 1. Search Bar Top
            _buildSearchBar(),

            // 2. Horizontal Category Chips
            _buildCategoryBar(),

            const SizedBox(height: 8),

            // 3. Grid Content (Search Feed)
            Expanded(
              child: _buildExploreGrid(),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Search Bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'Cari',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
            prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 9),
          ),
        ),
      ),
    );
  }

  // Widget Kategori Scrollable
  Widget _buildCategoryBar() {
    return SizedBox(
      height: 32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[800]!, width: 1),
            ),
            child: Text(
              _categories[index],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget Explore Grid dengan pola ala Instagram (2x2 + 1 Tall)
  Widget _buildExploreGrid() {
    return GridView.builder(
      itemCount: _dummyImages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        // Efek Reels/Video Icon opsional di pojok kanan atas
        bool isReels = index % 3 == 0;

        return Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              _dummyImages[index],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey[900]);
              },
            ),
            if (isReels)
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.movie_creation_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
          ],
        );
      },
    );
  }
}