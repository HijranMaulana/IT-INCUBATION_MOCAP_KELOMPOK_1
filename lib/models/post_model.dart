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
    likes: 245,
  ),
  PostModel(
    username: "budi.codes",
    userImage: "https://i.pravatar.cc/150?img=2",
    postImage: "https://picsum.photos/id/1015/500/500",
    caption: "Belajar Flutter itu seru banget!",
    likes: 512,
  ),
];