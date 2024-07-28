import 'package:flutter/material.dart';
import 'package:my_news/models/news_article.dart';
import 'package:my_news/services/firebase_service.dart';
import 'package:my_news/services/remote_config_service.dart';
import 'package:my_news/views/screens/login_screen.dart';
import 'package:my_news/views/widgets/common_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:my_news/providers/news_provider.dart';
import 'package:my_news/views/widgets/news_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  final remoteConfigService = RemoteConfigService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: CommonAppBar(
        title: 'MyNews',
        isHomeScreen: true,
        fontSize: 14,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.near_me_rounded,
                color: theme.scaffoldBackgroundColor,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                remoteConfigService.countryCode.toUpperCase(),
                style: theme.textTheme.displayLarge?.copyWith(
                    color: theme.scaffoldBackgroundColor, fontSize: 14),
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: _signout,
                child: Text(
                  "LogOut",
                  style: theme.textTheme.displayLarge?.copyWith(
                      color: theme.scaffoldBackgroundColor, fontSize: 14),
                ),
              )
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Top Headlines',
                    style: theme.textTheme.bodyText1?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Consumer<NewsProvider>(
                  builder: (context, newsProvider, child) {
                    if (newsProvider.isLoading) {
                      return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return NewsTile(
                              isLoading: true, article: NewsArticle());
                        },
                      );
                    } else if (newsProvider.errorMessage.isNotEmpty) {
                      return Center(child: Text(newsProvider.errorMessage));
                    } else {
                      return ListView.builder(
                        itemCount: newsProvider.articles.length,
                        itemBuilder: (context, index) {
                          return NewsTile(
                              article: newsProvider.articles[index]);
                        },
                      );
                    }
                  },
                ),
              ),
            ]),
      ),
    );
  }

  Future<void> _signout() async {
    try {
      await _firebaseService.signOut();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
