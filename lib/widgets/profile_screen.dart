import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../widgets/profile_stats.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            dummyUser.username,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                      backgroundImage: NetworkImage(dummyUser.profileImage),
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
                    Text(
                      dummyUser.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
                        onPressed: () {},
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
                        onPressed: () {},
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
                height: MediaQuery.of(context).size.width * 1.3, // perkiraan tinggi grid
                child: TabBarView(
                  children: [
                    // Tab 1: Grid postingan
                    GridView.builder(
                      padding: const EdgeInsets.all(2),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: dummyGridImages.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          dummyGridImages[index],
                          fit: BoxFit.cover,
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