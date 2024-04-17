import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/articles/article_bloc.dart';
import 'package:miniblog/repositories/article_repository.dart';
import 'package:miniblog/screens/homepage.dart';
import 'package:miniblog/themes/dark_theme.dart';
import 'package:miniblog/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  ThemeMode themeMode = ThemeMode.light;
  late ArticleBloc _articleBloc;

  @override
  void initState() {
    super.initState();
    _readThemeData();

    // ArticleRepository ve ArticleBloc nesnelerini oluştur
    final ArticleRepository articleRepository = ArticleRepository();
    _articleBloc = ArticleBloc(articleRepository: articleRepository);
  }

  _readThemeData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isDark = preferences.getBool("DARKTHEME");
    if (isDark != null && isDark) {
      setState(() {
        themeMode = ThemeMode.dark;
      });
    }
  }

  @override
  void dispose() {
    // ArticleBloc'un kaynaklarını temizle
    _articleBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: BlocProvider<ArticleBloc>(
        create: (context) => _articleBloc,
        child: const Homepage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
