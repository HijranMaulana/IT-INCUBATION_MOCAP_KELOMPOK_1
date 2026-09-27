import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../widgets/profile_stats.dart';
import '../screens/post_detail_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Ubah dummyGridImages jadi PostModel lengkap, biar bisa dibuka di PostDetailScreen
  List<PostModel> get _profilePosts => List.generate(
        dummyGridImages.length,
        (index) => PostModel(
          username: dummyUser.username,
          userImage: dummyUser.profileImage,
          postImage: dummyGridImages[index],
          caption: "Postingan ke-${index + 1} dari ${dummyUser.name}",
          likes: (index + 1) * 23,
          isVerified: dummyUser.isVerified,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dummyUser.username,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              if (dummyUser.isVerified) ...[
                const SizedBox(width: 4),
                const Icon(Icons.verified, color: Colors.blue, size: 18),
              ],
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: foto profile + stats
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: const Color(0xFFDBDBDB),
                      backgroundImage: dummyUser.profileImage.isEmpty
                            ? null
                            : NetworkImage(dummyUser.profileImage),
                      onBackgroundImageError: dummyUser.profileImage.isEmpty
                            ? null
                            : (exception, stackTrace) {},
                      child: dummyUser.profileImage.isEmpty
                              ? const Icon(Icons.person, size: 55, color: Colors.white)
                              : null,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ProfileStats(
                        posts: dummyUser.posts,
                        followers: dummyUser.followers,
                        following: dummyUser.following,
                      ),
                    ),
                  ],
                ),
              ),

              // Nama & bio
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          dummyUser.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (dummyUser.isVerified) ...[
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, color: Colors.blue, size: 16),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(dummyUser.bio),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Tombol Edit Profile & Share Profile
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Fitur edit profil segera hadir")),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.grey),
                        ),
                        child: const Text("Edit Profile"),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Link profil disalin")),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.grey),
                        ),
                        child: const Text("Share Profile"),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              const Divider(),

              // Tab: Grid post & Tagged
              const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(icon: Icon(Icons.grid_on)),
                  Tab(icon: Icon(Icons.person_pin_outlined)),
                ],
              ),

              // Grid foto — pakai SizedBox dengan tinggi manual karena di dalam SingleChildScrollView
              SizedBox(
                height: MediaQuery.of(context).size.width * 1.3,
                child: TabBarView(
                  children: [
                    // Tab 1: Grid postingan (sekarang bisa di-tap)
                    GridView.builder(
                      padding: const EdgeInsets.all(2),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: dummyGridImages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PostDetailScreen(
                                  posts: _profilePosts,
                                  initialIndex: index,
                                ),
                              ),
                            );
                          },
                          child: Image.network(
                            dummyGridImages[index],
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Container(color: Colors.grey[200]);
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    // Tab 2: Tagged (kosong dulu)
                    const Center(child: Text("Belum ada postingan tag")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}