class PostModel {
  final String username;
  final String userImage;
  final String postImage;
  final String caption;
  final int likes;
  final bool isVerified;

  PostModel({
    required this.username,
    required this.userImage,
    required this.postImage,
    required this.caption,
    required this.likes,
    this.isVerified = false,
  });
}

// Dummy data
List<PostModel> dummyPosts = [
  PostModel(
    username: "manutd",
    userImage:
        "https://instagram.fsub32-2.fna.fbcdn.net/v/t51.82787-19/631015021_18577480114007078_4852837564620816700_n.jpg?_nc_cat=1&ccb=7-5&_nc_sid=bf7eb4&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLnd3dy40MDAuQzMifQ%3D%3D&_nc_ohc=eNwEXV25pKcQ7kNvwFbyZc3&_nc_oc=AdrMcvyn9AdzejyuBOebaRIlXLBLbt3eycKsq3eeaQEG8rUk3SiTDtGr-xooj6Vxw_A&_nc_zt=24&_nc_ht=instagram.fsub32-2.fna&_nc_gid=o5cuDBQHK_pp5waGel_KCQ&_nc_ss=7b2a8&oh=00_AQLBkyxyaaF9885lJLBIbMovcZgpyviO8A-ZPzZ1wRVLGg&oe=6ABE6F63",
    postImage:
        "https://instagram.fsub32-1.fna.fbcdn.net/v/t51.82787-15/802778653_18645808258007078_6439919020333343961_n.jpg?stp=dst-jpg_e35_tt6&_nc_cat=107&_nc_map=urlgen_bucketless&ig_cache_key=Mzk4MzM1ODAzMzk5MTYxODEwMw%3D%3D.3-ccb7-5&ccb=7-5&_nc_sid=58cdad&efg=eyJ2ZW5jb2RlX3RhZyI6IkZFRUQueHBpZHMuMTQ0MC5zZHIucmVndWxhcl9waG90by5DMyJ9&_nc_ohc=GnrO9Hrgt4IQ7kNvwFjUP9u&_nc_oc=AdrgJ9uBLiN1vB5Qt46Vu2_MgdgrIheGPZfUqJgAEEs8s3X0stCaHBlhjm6oTIe0z2E&_nc_ad=z-m&_nc_cid=0&_nc_zt=23&_nc_ht=instagram.fsub32-1.fna&_nc_gid=boiEniV-O_uD1JuDA1gaiw&_nc_ss=7a22e&oh=00_AQK6pB5I2fK1gvQjMwm_jDFry_4Pu8q22ymQc9OG8G_ePg&oe=6ABE5C96",
    caption: "Now that was our idea of a very good night out.",
    likes: 632000,
    isVerified: true,
  ),
  PostModel(
    username: "menfess.uinmlg",
    userImage:
        "https://instagram.fsub32-1.fna.fbcdn.net/v/t51.82787-19/731058976_18128916817600343_4876799826995774482_n.jpg?_nc_cat=106&_nc_map=urlgen_bucketless&ccb=7-5&_nc_sid=bf7eb4&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLnd3dy4xMDgwLkMzIn0%3D&_nc_ohc=PUWaenYDh4IQ7kNvwEhbobx&_nc_oc=AdrWJL0d0RV4viRFSj56cdiFoMnY38e_Ukcw1YHqCLVgBMu-mEKYTmcjgtfnEaB1r30&_nc_zt=24&_nc_ht=instagram.fsub32-1.fna&_nc_gid=Pkf3M54GQxGLrcBLAjUxeg&_nc_ss=7baaf&oh=00_AQKt5_QaES2TurjKzImOatqZHPkYG92Snsq3ti-i8ScZmQ&oe=6ABE4D00",
    postImage:
        "https://instagram.fsub32-1.fna.fbcdn.net/v/t51.82787-15/824507987_18146814796600343_1850721137602158118_n.heic?stp=dst-jpg_e35_tt6&_nc_cat=107&_nc_map=urlgen_bucketless&ig_cache_key=Mzk5MzcxMTg1MjA1OTM2MzEyOQ%3D%3D.3-ccb7-5&ccb=7-5&_nc_sid=58cdad&efg=eyJ2ZW5jb2RlX3RhZyI6IkZFRUQueHBpZHMuMTQ0MC5zZHIucmVndWxhcl9waG90by5DMyJ9&_nc_ohc=tzoc7QZ_GocQ7kNvwGho1vB&_nc_oc=AdqSya75PERWtAwXDGQOlYYhEFRQ1I83JLHlrxySTACM7-dqMTOItT9DKSgCR60goDw&_nc_ad=z-m&_nc_cid=0&_nc_zt=23&_nc_ht=instagram.fsub32-1.fna&_nc_gid=W0BOGB5K6lg_Qbq3OQBUrA&_nc_ss=7a22e&oh=00_AQJaIokoabvRu0S1k-dEG8XkqZM-UiE2LDdgtA_hfyBQww&oe=6ABE5A34",
    caption: "No Comment🙏",
    likes: 819,
    isVerified: false,
  ),
  PostModel(
    username: "himatif.encoder",
    userImage:
        "https://instagram.fsub32-1.fna.fbcdn.net/v/t51.2885-19/291933010_5533222090061204_9010657460936864975_n.jpg?_nc_cat=100&_nc_map=urlgen_bucketless&ccb=7-5&_nc_sid=bf7eb4&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLnd3dy4xMDAwLkMzIn0%3D&_nc_ohc=b-jviy6hvyYQ7kNvwH7TfaV&_nc_oc=AdpsW0QtWhUz3tbcxc-LhpOOFUkpFj3XWHIzirakZENLAWDRM0I4IoXCHUBcE45oCVU&_nc_zt=24&_nc_ht=instagram.fsub32-1.fna&_nc_ss=7baaf&oh=00_AQK2oNRRRYyo3ecpgjF7gtDTkPcaVkHATeE5h-vNMOmbIg&oe=6ABE77B7",
    postImage:
        "https://instagram.fsub32-2.fna.fbcdn.net/v/t51.82787-15/814290460_18492662734100067_2485172271070379411_n.webp?_nc_cat=102&_nc_map=urlgen_bucketless&ig_cache_key=Mzk4ODk4OTI0NTk3NjcwMjAxNw%3D%3D.3-ccb7-5&ccb=7-5&_nc_sid=58cdad&efg=eyJ2ZW5jb2RlX3RhZyI6IkZFRUQueHBpZHMuMTQ0MC5zZHIucmVndWxhcl9waG90by5DMyJ9&_nc_ohc=KOF-G6Qba1EQ7kNvwHyzoCz&_nc_oc=Adp6-DABtGmj3RFVyYkxXDhV8wSEje0XjbGonE937qafwBNoittDjdLTwOtKkzw4wb4&_nc_ad=z-m&_nc_cid=0&_nc_zt=23&_nc_ht=instagram.fsub32-2.fna&_nc_gid=944xUhHSrVIqkh15q_2wlg&_nc_ss=7a22e&oh=00_AQKTfJRQkuBPfYe5b0Sd0mHQEYEtOwNOs3gL5C1nb6aphA&oe=6ABE73F4",
    caption: "📸 PHOTO DOCUMENTATION — DAY 2...",
    likes: 12950,
    isVerified: false,
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
  profileImage: "https://i.pravatar.cc/150?img=1",
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