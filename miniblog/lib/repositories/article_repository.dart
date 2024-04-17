import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miniblog/models/blogpost_model.dart';

class ArticleRepository {
  Future<List<BlogpostModel>> fetchAll() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    final response = await http.get(url);

    final List body = json.decode(response.body);

    return body.map((element) => BlogpostModel.fromMap(element)).toList();
  }


  Future<void> addBlog({
    required String title,
    required String content,
    required String author,
    required String imagePath,
  }) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    var request = http.MultipartRequest("POST", url);
    request.fields["Title"] = title;
    request.fields["Content"] = content;
    request.fields["Author"] = author;

    final file = await http.MultipartFile.fromPath("File", imagePath);
    request.files.add(file);

    final response = await request.send();

    if (response.statusCode == 201) {
      // Başarılı
      print("Blog eklendi");
    } else {
      // Hata
      print("Blog eklenirken bir hata oluştu");
    }
  }
}

  
