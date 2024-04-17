import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniblog/screens/homepage.dart';

class Delete extends StatelessWidget {
  final String blogpostId;

  const Delete({Key? key, required this.blogpostId}) : super(key: key);

  Future<void> deleteBlogpost(String id, BuildContext context) async {
    try {
      final response = await http.delete(Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$id"));

      if (response.statusCode == 200) {
        // Silme işlemi başarılı oldu, ana sayfaya geri dön
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      } else {
        // Silme işlemi başarısız oldu, uygun bir hata mesajı gösterebilirsiniz
      }
    } catch (error) {
      // Hata işleme
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Blogpost'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bu blog gönderisini silmek istediğinize emin misiniz?'),
            ElevatedButton(
              onPressed: () async {
                await deleteBlogpost(blogpostId, context);
              },
              child: const Text('Sil'),
            ),
          ],
        ),
      ),
    );
  }
}