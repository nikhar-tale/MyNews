import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_news/firebase_options.dart';
import 'package:my_news/views/screens/startup.dart';
import 'package:provider/provider.dart';
import 'package:my_news/providers/news_provider.dart';
import 'package:my_news/services/remote_config_service.dart';
import 'services/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final remoteConfigService = RemoteConfigService();
  await remoteConfigService.initialize();

  runApp(MyApp(remoteConfigService: remoteConfigService));
}

class MyApp extends StatelessWidget {
  final RemoteConfigService remoteConfigService;

  MyApp({super.key, required this.remoteConfigService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => NewsProvider(remoteConfigService)),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyNews',
          theme: AppTheme.buildTheme(),
          home: StartUp()),
    );
  }
}
