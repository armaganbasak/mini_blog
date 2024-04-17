import 'package:miniblog/models/blogpost_model.dart';

abstract class ArticleState {}

class ArticlesNotLoaded extends ArticleState {}

class ArticlesLoaded extends ArticleState {
  final List<BlogpostModel> blogs;

  ArticlesLoaded({required this.blogs});
}

class ArticlesLoading extends ArticleState {}

class ArticlesLoadFail extends ArticleState {}