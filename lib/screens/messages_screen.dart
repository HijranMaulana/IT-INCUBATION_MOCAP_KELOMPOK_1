import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  static const _conversations = [
    _Conversation('sarah_dev', 'Sarah', 'Siap, nanti aku kabari ya!', '2 mnt'),
    _Conversation('budi.codes', 'Budi', 'Foto yang tadi keren banget', '15 mnt'),
    _Conversation('maya.design', 'Maya', 'Makasih sudah follow!', '1 jam'),
    _Conversation('andi.flutter', 'Andi', 'Kapan kita lanjut ngoding?', '3 jam'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final conversations = _conversations
        .where((conversation) =>
            conversation.username.toLowerCase().contains(_query.toLowerCase()) ||
            conversation.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        title: const Text(
          'Pesan',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            tooltip: 'Pesan baru',
            onPressed: () {},
            icon: const Icon(Icons.edit_square),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Cari',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFF1F1F1),
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Pesan',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Text('Permintaan', style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          Expanded(
            child: conversations.isEmpty
                ? const Center(child: Text('Tidak ada percakapan'))
                : ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final conversation = conversations[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFFEBDFFF),
                          child: Text(
                            conversation.name[0],
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                        title: Text(conversation.username),
                        subtitle: Text(
                          conversation.preview,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          conversation.time,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => ChatScreen(conversation: conversation),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
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
  final List<String> _messages = ['Hai! Apa kabar?', 'Baik, kamu gimana?'];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    setState(() => _messages.add(message));
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
            Text(widget.conversation.username, style: const TextStyle(fontSize: 16)),
            const Text(
              'Aktif sekarang',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
        actions: [
          IconButton(tooltip: 'Telepon', onPressed: () {}, icon: const Icon(Icons.call_outlined)),
          IconButton(tooltip: 'Video', onPressed: () {}, icon: const Icon(Icons.videocam_outlined)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isMine = index >= 2;
                return Align(
                  alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 280),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMine ? const Color(0xFFEBDFFF) : const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(_messages[index]),
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
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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

class _Conversation {
  const _Conversation(this.username, this.name, this.preview, this.time);

  final String username;
  final String name;
  final String preview;
  final String time;
}