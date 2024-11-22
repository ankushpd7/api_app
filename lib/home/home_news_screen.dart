import 'package:api_app/core/models/new_model.dart';
import 'package:api_app/core/services/new_service.dart';
import 'package:flutter/material.dart';

class HomeNewsScreen extends StatelessWidget {
  final NewsService newsService = NewsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Latest News")),
      body: FutureBuilder<List<dynamic>>(
        future: newsService.fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news available.'));
          } else {
            List<dynamic> articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                News news = News.fromJson(articles[index]);
                return ListTile(
                  title: Text(news.title),
                  subtitle: Text(news.description),
                  onTap: () {},
                  leading: news.imageUrl.isNotEmpty
                      ? Image.network(news.imageUrl,
                          width: 50, height: 50, fit: BoxFit.cover)
                      : Icon(Icons.image),
                );
              },
            );
          }
        },
      ),
    );
  }
}
