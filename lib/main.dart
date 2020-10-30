import 'package:flutter/material.dart';
import 'package:news_provider_app/pages/tabs_page.dart';
import 'package:news_provider_app/services/news_service.dart';
import 'package:news_provider_app/theme/tema.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new NewsService()),
      ],
          child: MaterialApp(
        theme: miThema,
        debugShowCheckedModeBanner: false,
        title: 'News Provider',
        home: TabsPage(),
      ),
    );
  }
}