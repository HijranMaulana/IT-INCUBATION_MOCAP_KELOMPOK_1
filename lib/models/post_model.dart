class PostModel {
  final String username;
  final String userImage;
  final String postImage;
  final String caption;
  final int likes;

  PostModel({
    required this.username,
    required this.userImage,
    required this.postImage,
    required this.caption,
    required this.likes,
  });
}

// Dummy data
List<PostModel> dummyPosts = [
  PostModel(
    username: "sarah_dev",
    userImage: "https://i.pravatar.cc/150?img=1",
    postImage: "https://picsum.photos/id/237/500/500",
    caption: "Ngoding sambil ngopi ☕ #flutter",
    likes: 1245,
  ),
  PostModel(
    username: "budi.codes",
    userImage: "https://i.pravatar.cc/150?img=2",
    postImage: "https://picsum.photos/id/1015/500/500",
    caption: "Belajar Flutter itu seru banget!",
    likes: 5120,
  ),
];

// Tambahkan di bawah class PostModel dan dummyPosts yang sudah ada

class UserModel {
  final String username;
  final String name;
  final String profileImage;
  final String bio;
  final int posts;
  final int followers;
  final int following;

  UserModel({
    required this.username,
    required this.name,
    required this.profileImage,
    required this.bio,
    required this.posts,
    required this.followers,
    required this.following,
  });
}

UserModel dummyUser = UserModel(
  username: "just.izumi7",
  name: "h",
  profileImage: "https://i.pravatar.cc/150?img=1",
  bio: "Flutter Dev\n Malang, Indonesia",
  posts: 24,
  followers: 6520,
  following: 740,
);

// Data grid foto profile (bisa pakai postImage yang sama)
List<String> dummyGridImages = List.generate(
  15,
  (index) => "https://picsum.photos/id/${(index + 10) * 3}/300/300",
);

List<String> dummyExploreImages = List.generate(
  30,
  (index) => "https://picsum.photos/id/${(index + 20) * 7}/300/300",
);