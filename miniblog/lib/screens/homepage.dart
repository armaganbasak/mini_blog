import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/articles/article_bloc.dart';
import 'package:miniblog/blocs/articles/article_event.dart';
import 'package:miniblog/blocs/articles/article_state.dart';
import 'package:miniblog/models/blogpost_model.dart';
import 'package:miniblog/repositories/article_repository.dart';
import 'package:miniblog/screens/add_blog.dart';
import 'package:miniblog/screens/blog_details.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ana Sayfa"),
        backgroundColor: Colors.blue.shade200,
      ),
      body: BlocProvider(
        create: (context) => ArticleBloc(articleRepository: ArticleRepository()),
        child: const BlogList(), 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AddBlog()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BlogList extends StatelessWidget {
  const BlogList({Key? key}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state is ArticlesLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is ArticlesLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<ArticleBloc>(context).add(FetchArticles());
            },
            child: ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                String contentNew = blog.content.length > 5 ? '${blog.content.substring(0, 5)}...' : blog.content;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(blog.thumbnail),
                  ),
                  title: Text(blog.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Yazar: ${blog.author}"),
                      const SizedBox(height: 8),
                      Text("İçerik: $contentNew"),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetailPage(blogpost: blog)));
                  },
                );
              },
            ),
          );
        } else if (state is ArticlesLoadFail) {
          return Center(child: Text('Failed to load articles'));
        } else if (state is ArticlesNotLoaded) {
          // FetchArticles event'ini tetikle
          context.read<ArticleBloc>().add(FetchArticles());
          return const Center(
            child: Text("Yazıların yükleme işlemi başlamadı.."),
          );
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}