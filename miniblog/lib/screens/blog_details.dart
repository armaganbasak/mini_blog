import 'package:flutter/material.dart';
import 'package:miniblog/models/blogpost_model.dart';
import 'package:miniblog/screens/delete_blog.dart';
import 'package:miniblog/screens/edit_blog.dart';

class BlogDetailPage extends StatefulWidget {
  final BlogpostModel blogpost;

  const BlogDetailPage({Key? key, required this.blogpost}) : super(key: key);

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  double _imageHeight = 200.0; // Başlangıç boyutu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SelectableText(widget.blogpost.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateBlogpostPage(blogpost: widget.blogpost),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Delete(blogpostId: widget.blogpost.id);
                },
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _imageHeight == 200.0 ? _imageHeight = 400.0 : _imageHeight = 200.0;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500), // Animasyon süresi
                  height: _imageHeight, // Yüksekliği değiştirecek animasyon
                  child: Image.network(widget.blogpost.thumbnail),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.blogpost.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Yazar: ",
                style: TextStyle(color: Colors.red),
              ),
              Text(widget.blogpost.author),
              const SizedBox(height: 8),
              const Text(
                "İçerik: ",
                style: TextStyle(color: Colors.red),
              ),
              Text(widget.blogpost.content),
            ],
          ),
        ),
      ),
    );
  }
}
