import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedFilter = 0;

  final List<String> filters = [
    'All',
    'Likes',
    'Comments',
    'Followers',
    'Mentions',
  ];

  // Dummy notification
  final List<Map<String, dynamic>> notifications = [
    {
      'type': 'like',
      'username': 'sarah_dev',
      'message': 'liked your post.',
      'time': '2m',
      'userImage': 'https://i.pravatar.cc/150?img=1',
      'postImage': 'https://picsum.photos/id/237/500/500',
      'isNew': true,
    },
    {
      'type': 'comment',
      'username': 'budi.codes',
      'message': 'commented on your post: "Nice! 🔥"',
      'time': '8m',
      'userImage': 'https://i.pravatar.cc/150?img=2',
      'postImage': 'https://picsum.photos/id/1015/500/500',
      'isNew': true,
    },
    {
      'type': 'follow',
      'username': 'andipratama',
      'message': 'started following you.',
      'time': '15m',
      'userImage': 'https://i.pravatar.cc/150?img=3',
      'isNew': true,
      'following': false,
    },
    {
      'type': 'like',
      'username': 'nabila',
      'message': 'liked your post.',
      'time': '1h',
      'userImage': 'https://i.pravatar.cc/150?img=4',
      'postImage': 'https://picsum.photos/id/1025/500/500',
      'isNew': false,
    },
    {
      'type': 'mention',
      'username': 'fahmi',
      'message': 'mentioned you in a comment.',
      'time': '2h',
      'userImage': 'https://i.pravatar.cc/150?img=5',
      'postImage': 'https://picsum.photos/id/1035/500/500',
      'isNew': false,
    },
    {
      'type': 'follow',
      'username': 'putri_ayu',
      'message': 'started following you.',
      'time': '4h',
      'userImage': 'https://i.pravatar.cc/150?img=6',
      'isNew': false,
      'following': false,
    },
    {
      'type': 'like',
      'username': 'bagas',
      'message': 'liked your post.',
      'time': '1d',
      'userImage': 'https://i.pravatar.cc/150?img=7',
      'postImage': 'https://picsum.photos/id/1040/500/500',
      'isNew': false,
    },
    {
      'type': 'comment',
      'username': 'dimas.tech',
      'message': 'commented on your post: "Keren banget!"',
      'time': '1d',
      'userImage': 'https://i.pravatar.cc/150?img=8',
      'postImage': 'https://picsum.photos/id/1067/500/500',
      'isNew': false,
    },
    {
      'type': 'like',
      'username': 'maya_putri',
      'message': 'liked your post.',
      'time': '2d',
      'userImage': 'https://i.pravatar.cc/150?img=9',
      'postImage': 'https://picsum.photos/id/1074/500/500',
      'isNew': false,
    },
  ];

  List<Map<String, dynamic>> get filteredNotifications {
    if (selectedFilter == 0) {
      return notifications;
    }

    String type;

    switch (selectedFilter) {
      case 1:
        type = 'like';
        break;
      case 2:
        type = 'comment';
        break;
      case 3:
        type = 'follow';
        break;
      case 4:
        type = 'mention';
        break;
      default:
        type = '';
    }

    return notifications
        .where((notification) => notification['type'] == type)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,

        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: _showNotificationSettings,
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          _buildFilterMenu(),
          const Divider(height: 1),
          Expanded(
            child: _buildNotificationList(),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FILTER
  // =========================================================

  Widget _buildFilterMenu() {
    return SizedBox(
      height: 58,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 9,
        ),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final selected = selectedFilter == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = index;
              });
            },

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),

              margin: const EdgeInsets.only(right: 8),

              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),

              decoration: BoxDecoration(
                color: selected
                    ? Colors.black
                    : Colors.grey.shade100,

                borderRadius: BorderRadius.circular(25),
              ),

              child: Center(
                child: Text(
                  filters[index],
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : Colors.black87,

                    fontWeight: selected
                        ? FontWeight.bold
                        : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // =========================================================
  // NOTIFICATION LIST
  // =========================================================

  Widget _buildNotificationList() {
    final data = filteredNotifications;

    if (data.isEmpty) {
      return _buildEmptyState();
    }

    final newNotifications =
        data.where((item) => item['isNew'] == true).toList();

    final oldNotifications =
        data.where((item) => item['isNew'] == false).toList();

    return ListView(
      padding: const EdgeInsets.only(bottom: 20),
      children: [
        if (newNotifications.isNotEmpty) ...[
          _sectionTitle('New'),

          ...newNotifications.map(
            _buildNotificationItem,
          ),
        ],

        if (oldNotifications.isNotEmpty) ...[
          _sectionTitle('Earlier'),

          ...oldNotifications.map(
            _buildNotificationItem,
          ),
        ],
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        18,
        16,
        8,
      ),

      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // =========================================================
  // NOTIFICATION ITEM
  // =========================================================

  Widget _buildNotificationItem(
    Map<String, dynamic> notification,
  ) {
    final type = notification['type'];

    return InkWell(
      onTap: () {
        _openNotification(notification);
      },

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),

        color: notification['isNew'] == true
            ? Colors.grey.shade50
            : Colors.white,

        child: Row(
          children: [
            _buildAvatar(notification),

            const SizedBox(width: 12),

            Expanded(
              child: _buildNotificationText(
                notification,
              ),
            ),

            const SizedBox(width: 10),

            _buildTrailing(
              notification,
              type,
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // AVATAR
  // =========================================================

  Widget _buildAvatar(
    Map<String, dynamic> notification,
  ) {
    return Stack(
      clipBehavior: Clip.none,

      children: [
        CircleAvatar(
          radius: 27,

          backgroundColor: Colors.grey.shade200,

          backgroundImage: NetworkImage(
            notification['userImage'],
          ),
        ),

        Positioned(
          bottom: -2,
          right: -3,

          child: Container(
            width: 22,
            height: 22,

            decoration: BoxDecoration(
              color: _getIconColor(
                notification['type'],
              ),

              shape: BoxShape.circle,

              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),

            child: Icon(
              _getNotificationIcon(
                notification['type'],
              ),
              color: Colors.white,
              size: 12,
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // TEXT
  // =========================================================

  Widget _buildNotificationText(
    Map<String, dynamic> notification,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        RichText(
          maxLines: 3,

          overflow: TextOverflow.ellipsis,

          text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              height: 1.4,
            ),

            children: [
              TextSpan(
                text: notification['username'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextSpan(
                text: ' ${notification['message']}',
              ),
            ],
          ),
        ),

        const SizedBox(height: 4),

        Text(
          notification['time'],

          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // =========================================================
  // TRAILING
  // =========================================================

  Widget _buildTrailing(
    Map<String, dynamic> notification,
    String type,
  ) {
    // Kalau follower
    if (type == 'follow') {
      return _buildFollowButton(
        notification,
      );
    }

    // Kalau like/comment/mention
    if (notification['postImage'] != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(7),

        child: Image.network(
          notification['postImage'],

          width: 55,
          height: 55,

          fit: BoxFit.cover,

          errorBuilder: (
            context,
            error,
            stackTrace,
          ) {
            return Container(
              width: 55,
              height: 55,
              color: Colors.grey.shade200,
              child: const Icon(
                Icons.image_not_supported_outlined,
                color: Colors.grey,
              ),
            );
          },
        ),
      );
    }

    return const SizedBox();
  }

  // =========================================================
  // FOLLOW BUTTON
  // =========================================================

  Widget _buildFollowButton(
    Map<String, dynamic> notification,
  ) {
    final following =
        notification['following'] == true;

    return GestureDetector(
      onTap: () {
        setState(() {
          notification['following'] = !following;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 200,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),

        decoration: BoxDecoration(
          color: following
              ? Colors.grey.shade100
              : Colors.black,

          borderRadius: BorderRadius.circular(8),
        ),

        child: Text(
          following ? 'Following' : 'Follow',

          style: TextStyle(
            color: following
                ? Colors.black
                : Colors.white,

            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // EMPTY
  // =========================================================

  Widget _buildEmptyState() {
    String title;

    switch (selectedFilter) {
      case 1:
        title = 'No likes yet';
        break;

      case 2:
        title = 'No comments yet';
        break;

      case 3:
        title = 'No new followers';
        break;

      case 4:
        title = 'No mentions yet';
        break;

      default:
        title = 'No notifications';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            width: 85,
            height: 85,

            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.notifications_none_rounded,
              size: 45,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            title,

            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'When you receive new activity,\nit will appear here.',
            textAlign: TextAlign.center,

            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ICON
  // =========================================================

  IconData _getNotificationIcon(
    String type,
  ) {
    switch (type) {
      case 'like':
        return Icons.favorite;

      case 'comment':
        return Icons.chat_bubble;

      case 'follow':
        return Icons.person_add;

      case 'mention':
        return Icons.alternate_email;

      default:
        return Icons.notifications;
    }
  }

  Color _getIconColor(
    String type,
  ) {
    switch (type) {
      case 'like':
        return Colors.red;

      case 'comment':
        return Colors.blue;

      case 'follow':
        return Colors.green;

      case 'mention':
        return Colors.purple;

      default:
        return Colors.black;
    }
  }

  // =========================================================
  // OPEN NOTIFICATION
  // =========================================================

  void _openNotification(
    Map<String, dynamic> notification,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Membuka aktivitas @${notification['username']}',
        ),
      ),
    );
  }

  // =========================================================
  // SETTINGS
  // =========================================================

  void _showNotificationSettings() {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Container(
                  width: 40,
                  height: 4,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Notification Settings',

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                _settingItem(
                  Icons.favorite_border,
                  'Likes',
                ),

                _settingItem(
                  Icons.chat_bubble_outline,
                  'Comments',
                ),

                _settingItem(
                  Icons.person_add_outlined,
                  'New followers',
                ),

                _settingItem(
                  Icons.alternate_email,
                  'Mentions',
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _settingItem(
    IconData icon,
    String title,
  ) {
    return ListTile(
      leading: Icon(icon),

      title: Text(title),

      trailing: Switch(
        value: true,
        onChanged: (value) {},
      ),
    );
  }
}