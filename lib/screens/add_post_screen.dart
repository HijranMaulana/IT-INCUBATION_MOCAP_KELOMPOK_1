import 'package:flutter/material.dart';
import '../models/post_model.dart';

class AddPostScreen extends StatefulWidget {
  final VoidCallback? onPostCreated;

  const AddPostScreen({super.key, this.onPostCreated});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  static final List<String> _sampleImages = List.generate(
    6,
    (index) => "https://picsum.photos/id/${(index + 50) * 5}/500/500",
  );

  bool _isPosting = false;

  @override
  void dispose() {
    _imageUrlController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  void _pickSample(String url) {
    setState(() {
      _imageUrlController.text = url;
    });
  }

  Future<void> _submitPost() async {
    final url = _imageUrlController.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan atau pilih gambar dulu ya')),
      );
      return;
    }

    setState(() => _isPosting = true);

    await Future.delayed(const Duration(milliseconds: 400));

    dummyPosts.insert(
      0,
      PostModel(
        username: dummyUser.username,
        userImage: dummyUser.profileImage,
        postImage: url,
        caption: _captionController.text.trim(),
        likes: 0,
      ),
    );

    if (!mounted) return;

    _imageUrlController.clear();
    _captionController.clear();

    setState(() => _isPosting = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Postingan berhasil dibuat!')));

    widget.onPostCreated?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        title: const Text(
          'Postingan Baru',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: _isPosting ? null : _submitPost,
            child: _isPosting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    'Bagikan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 700;
            final maxContentWidth = isWide ? 720.0 : constraints.maxWidth;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildPreview()),
                            const SizedBox(width: 24),
                            Expanded(child: _buildForm()),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildPreview(),
                            const SizedBox(height: 16),
                            _buildForm(),
                          ],
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPreview() {
    final currentUrl = _imageUrlController.text.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: currentUrl.isEmpty
                ? const Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 56,
                      color: Colors.black38,
                    ),
                  )
                : Image.network(
                    currentUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => const Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                        size: 56,
                        color: Colors.black38,
                      ),
                    ),
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Pilih contoh gambar',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _sampleImages.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final url = _sampleImages[index];
              final isSelected = currentUrl == url;
              return GestureDetector(
                onTap: () => _pickSample(url),
                child: Container(
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(url, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _imageUrlController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            labelText: 'URL gambar',
            hintText: 'https://...',
            prefixIcon: const Icon(Icons.link),
            filled: true,
            fillColor: const Color(0xFFF1F1F1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _captionController,
          maxLines: 4,
          minLines: 3,
          decoration: InputDecoration(
            labelText: 'Tulis caption...',
            alignLabelWithHint: true,
            filled: true,
            fillColor: const Color(0xFFF1F1F1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: _isPosting ? null : _submitPost,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: _isPosting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Bagikan Postingan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ],
    );
  }
}