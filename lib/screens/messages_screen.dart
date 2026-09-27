import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  final _conversations = [
    _Conversation(
      username: 'sarah_dev',
      name: 'Sarah',
      time: '2 mnt',
      isOnline: true,
      isUnread: true,
      messages: [
        _ChatMessage('Hai! Apa kabar?', isMine: false),
        _ChatMessage('Siap, nanti aku kabari ya!', isMine: true),
        _ChatMessage('Siap, nanti aku kabari ya!', isMine: false),
      ],
    ),
    _Conversation(
      username: 'budi.codes',
      name: 'Budi',
      time: '15 mnt',
      isOnline: true,
      isUnread: false,
      messages: [
        _ChatMessage('Aku baru lihat fotonya', isMine: true),
        _ChatMessage('Foto yang tadi keren banget', isMine: false),
      ],
    ),
    _Conversation(
      username: 'maya.design',
      name: 'Maya',
      time: '1 jam',
      isOnline: false,
      isUnread: false,
      messages: [
        _ChatMessage('Senang lihat karya-karyamu!', isMine: true),
        _ChatMessage('Makasih sudah follow!', isMine: false),
      ],
    ),
    _Conversation(
      username: 'andi.flutter',
      name: 'Andi',
      time: '3 jam',
      isOnline: false,
      isUnread: false,
      messages: [
        _ChatMessage('Besok sempat lanjut project?', isMine: true),
        _ChatMessage('Kapan kita lanjut ngoding?', isMine: false),
      ],
    ),
  ];

  final _requests = [
    _MessageRequest('nina.photo', 'Nina', 'Hai, boleh kenalan?'),
    _MessageRequest('rizky.travel', 'Rizky', 'Kamu punya rekomendasi tempat?'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openRequests() async {
    final accepted = await Navigator.of(context).push<_Conversation>(
      MaterialPageRoute<_Conversation>(
        builder: (_) => MessageRequestsScreen(requests: _requests),
      ),
    );
    if (!mounted) return;

    setState(() {
      if (accepted != null) {
        _requests.removeWhere(
          (request) => request.username == accepted.username,
        );
        _conversations.removeWhere(
          (conversation) => conversation.username == accepted.username,
        );
        _conversations.insert(0, accepted);
      }
    });

    if (accepted != null) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ChatScreen(conversation: accepted),
        ),
      );
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final conversations = _conversations
        .where(
          (conversation) =>
              conversation.username.toLowerCase().contains(
                _query.toLowerCase(),
              ) ||
              conversation.name.toLowerCase().contains(_query.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pesan',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
        ),
        actions: [
          IconButton(
            tooltip: 'Pesan baru',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) =>
                      NewMessageScreen(conversations: _conversations),
                ),
              );
            },
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF3EDFF),
              foregroundColor: const Color(0xFF6542A6),
            ),
            icon: const Icon(Icons.edit_square),
          ),
          const SizedBox(width: 12),
        ],
      ),
      backgroundColor: const Color(0xFFFCFBFE),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 14),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Cari teman atau pesan',
                hintStyle: const TextStyle(
                  color: Color(0xFF8A8790),
                  fontSize: 14,
                ),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF746E7B)),
                filled: true,
                fillColor: const Color(0xFFF2F0F5),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 2, 18, 10),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Pesan terbaru',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ),
                TextButton(
                  onPressed: _openRequests,
                  style: TextButton.styleFrom(
                    minimumSize: const Size(48, 48),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    foregroundColor: const Color(0xFF6542A6),
                    tapTargetSize: MaterialTapTargetSize.padded,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Permintaan',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (_requests.isNotEmpty) ...[
                        const SizedBox(width: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0EAFB),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${_requests.length}',
                            style: const TextStyle(
                              color: Color(0xFF6542A6),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: conversations.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0EAFB),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.search_off,
                            color: Color(0xFF7655AD),
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Belum ada hasil',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Coba kata kunci lainnya',
                          style: TextStyle(
                            color: Color(0xFF77727D),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final conversation = conversations[index];
                      return InkWell(
                        onTap: () async {
                          conversation.isUnread = false;
                          await Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  ChatScreen(conversation: conversation),
                            ),
                          );
                          if (mounted) setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              _ConversationAvatar(conversation: conversation),
                              const SizedBox(width: 13),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      conversation.username,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: conversation.isUnread
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      conversation.preview,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: conversation.isUnread
                                            ? const Color(0xFF34313A)
                                            : const Color(0xFF77727D),
                                        fontSize: 13,
                                        fontWeight: conversation.isUnread
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    conversation.time,
                                    style: const TextStyle(
                                      color: Color(0xFF85808A),
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  if (conversation.isUnread)
                                    Container(
                                      width: 9,
                                      height: 9,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF7655AD),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class MessageRequestsScreen extends StatefulWidget {
  const MessageRequestsScreen({required this.requests, super.key});

  final List<_MessageRequest> requests;

  @override
  State<MessageRequestsScreen> createState() => _MessageRequestsScreenState();
}

class _MessageRequestsScreenState extends State<MessageRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Permintaan pesan',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFCFBFE),
      body: widget.requests.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0EAFB),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mark_email_read_outlined,
                      color: Color(0xFF7655AD),
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Tidak ada permintaan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              itemCount: widget.requests.length,
              itemBuilder: (context, index) {
                final request = widget.requests[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFECE8F1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFF8A55),
                                  Color(0xFFCE3C9B),
                                  Color(0xFF7655AD),
                                ],
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: const Color(0xFFEBDFFF),
                              child: Text(
                                request.name[0],
                                style: const TextStyle(
                                  color: Color(0xFF573C83),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  request.username,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  request.name,
                                  style: const TextStyle(
                                    color: Color(0xFF77727D),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chat_bubble_outline,
                            size: 19,
                            color: Color(0xFF817A89),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(58, 12, 0, 14),
                        child: Text(
                          request.preview,
                          style: const TextStyle(
                            color: Color(0xFF45414B),
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() => widget.requests.remove(request));
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF625D68),
                                side: const BorderSide(
                                  color: Color(0xFFE2DDE8),
                                ),
                              ),
                              child: const Text('Hapus'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pop(request.toConversation());
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF7655AD),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Terima'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({required this.conversation, super.key});

  final _Conversation conversation;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  List<_ChatMessage> get _messages => widget.conversation.messages;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(message, isMine: true));
      widget.conversation.time = 'sekarang';
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.conversation.username,
              style: const TextStyle(fontSize: 16),
            ),
            const Text(
              'Aktif sekarang',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Telepon',
            onPressed: () {},
            icon: const Icon(Icons.call_outlined),
          ),
          IconButton(
            tooltip: 'Video',
            onPressed: () {},
            icon: const Icon(Icons.videocam_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isMine
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 280),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: message.isMine
                          ? const Color(0xFFEBDFFF)
                          : const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(message.text),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'Kirim pesan...',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Kirim',
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({required this.conversations, super.key});

  final List<_Conversation> conversations;

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contacts = widget.conversations
        .where(
          (conversation) =>
              conversation.username.toLowerCase().contains(
                _query.toLowerCase(),
              ) ||
              conversation.name.toLowerCase().contains(_query.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pesan baru',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFCFBFE),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Cari teman',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF746E7B)),
                filled: true,
                fillColor: const Color(0xFFF2F0F5),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text(
              'Pilih teman untuk memulai percakapan',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final conversation = contacts[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => ChatScreen(conversation: conversation),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        _ConversationAvatar(conversation: conversation),
                        const SizedBox(width: 13),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conversation.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              conversation.username,
                              style: const TextStyle(
                                color: Color(0xFF77727D),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Conversation {
  _Conversation({
    required this.username,
    required this.name,
    required this.time,
    required this.isOnline,
    required this.isUnread,
    required this.messages,
  });

  final String username;
  final String name;
  String time;
  final bool isOnline;
  bool isUnread;
  final List<_ChatMessage> messages;

  String get preview =>
      messages.isEmpty ? 'Mulai percakapan' : messages.last.text;
}

class _ChatMessage {
  const _ChatMessage(this.text, {required this.isMine});

  final String text;
  final bool isMine;
}

class _MessageRequest {
  const _MessageRequest(this.username, this.name, this.preview);

  final String username;
  final String name;
  final String preview;

  _Conversation toConversation() => _Conversation(
    username: username,
    name: name,
    time: 'baru',
    isOnline: false,
    isUnread: true,
    messages: [_ChatMessage(preview, isMine: false)],
  );
}

class _ConversationAvatar extends StatelessWidget {
  const _ConversationAvatar({required this.conversation});

  final _Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 54,
          height: 54,
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFFF8A55), Color(0xFFCE3C9B), Color(0xFF7655AD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFEBDFFF),
            child: Text(
              conversation.name[0],
              style: const TextStyle(
                color: Color(0xFF573C83),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        if (conversation.isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFF42B883),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFCFBFE), width: 2),
              ),
            ),
          ),
      ],
    );
  }
}