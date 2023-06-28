import 'package:flutter/material.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsPage(),
    );
  }
}

class NewsPage extends StatelessWidget {
  final List<News> newsList = [
    News(
      title: '公告标题1',
      content: '公告内容1',
    ),
    News(
      title: '公告标题2',
      content: '公告内容2',
    ),
    // Add more news items as needed
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('浏览公告'),
      ),
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.asset(
                'assets/images/news_icon.jpg', // Replace with your image path
                width: 48,
                height: 48,
              ),
              title: Text(newsList[index].title),
              subtitle: Text(newsList[index].content),
            ),
          );
        },
      ),
    );
  }
}

class News {
  final String title;
  final String content;

  News({required this.title, required this.content});
}
