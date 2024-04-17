import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniblog/models/blogpost_model.dart';

class UpdateBlogpostPage extends StatefulWidget {
  final BlogpostModel blogpost;

  const UpdateBlogpostPage({Key? key, required this.blogpost}) : super(key: key);

  @override
  _UpdateBlogpostPageState createState() => _UpdateBlogpostPageState();
}

class _UpdateBlogpostPageState extends State<UpdateBlogpostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Mevcut blog gönderisi bilgilerini kontrolcülere yerleştirme
    _titleController.text = widget.blogpost.title;
    _authorController.text = widget.blogpost.author;
    _contentController.text = widget.blogpost.content;
  }

  Future<void> updateBlogpost(String id) async {
    try {
      final response = await http.put(
        Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': id,
          'title': _titleController.text,
          'content': _contentController.text,
          'thumbnail': widget.blogpost.thumbnail,
          'author': _authorController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Güncelleme işlemi başarılı oldu, ana sayfaya geri dön
        Navigator.pop(context);
      } else {
        // Güncelleme işlemi başarısız oldu, uygun bir hata mesajı gösterebilirsiniz
      }
    } catch (error) {
      // Hata işleme
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Blogpost'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: _authorController,
              decoration: const InputDecoration(labelText: 'Author'),
            ),
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                updateBlogpost(widget.blogpost.id);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
