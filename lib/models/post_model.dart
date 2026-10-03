class PostModel {
  final String username;
  final String userImage;
  final String postImage;
  final String caption;
  final int likes;
  final bool isVerified;
  final List<String> comments;

  PostModel({
    required this.username,
    required this.userImage,
    required this.postImage,
    required this.caption,
    required this.likes,
    this.isVerified = false,
    List<String>? comments,
  }) : comments = comments ?? [];
}

// Dummy data
List<PostModel> dummyPosts = [
  PostModel(
    username: "traveler_id",
    userImage: "https://picsum.photos/seed/manutd_profile/150/150",
    postImage: "https://picsum.photos/seed/manutd_post/500/500",
    caption: "Liburan singkat tapi berkesan ✈️",
    likes: 632000,
    isVerified: true,
    comments: ["Keren banget!", "Mantap jiwa"],
  ),
  PostModel(
    username: "user_anonim",
    userImage: "https://picsum.photos/seed/menfess_profile/150/150",
    postImage: "https://picsum.photos/seed/menfess_post/500/500",
    caption: "Random thoughts hari ini 🌧️",
    likes: 819,
    isVerified: false,
  ),
  PostModel(
    username: "daily.snapshot",
    userImage: "https://picsum.photos/seed/himatif_profile/150/150",
    postImage: "https://picsum.photos/seed/himatif_post/500/500",
    caption: "📸 Momen sederhana di sore hari",
    likes: 12950,
    isVerified: false,
    comments: ["Lanjutkan dokumentasinya!"],
  ),
];

class UserModel {
  final String username;
  final String name;
  final String profileImage;
  final String bio;
  final int posts;
  final int followers;
  final int following;
  final bool isVerified;

  UserModel({
    required this.username,
    required this.name,
    required this.profileImage,
    required this.bio,
    required this.posts,
    required this.followers,
    required this.following,
    this.isVerified = false,
  });
}

UserModel dummyUser = UserModel(
  username: "mocap.kelompok1",
  name: "Kelompok 1",
  profileImage: "",
  bio: "Flutter Dev\n Malang, Indonesia",
  posts: 24,
  followers: 6520,
  following: 740,
);

// Data grid foto profile (bisa pakai postImage yang sama)
List<String> dummyGridImages = List.generate(
  17,
  (index) => "https://picsum.photos/id/${(index + 10) * 3}/300/300",
);

List<String> dummyExploreImages = List.generate(
  30,
  (index) => "https://picsum.photos/id/${(index + 20) * 7}/300/300",
);