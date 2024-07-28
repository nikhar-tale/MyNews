import 'package:flutter/material.dart';
import 'package:my_news/models/news_article.dart';
import 'package:my_news/views/widgets/shimmer.dart';
import 'package:intl/intl.dart'; // Add this import

class NewsTile extends StatelessWidget {
  final NewsArticle article;
  final bool isLoading;

  const NewsTile({super.key, required this.article, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShimmerLoading(
      isLoading: isLoading,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.urlToImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    article.urlToImage!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 12.0),
              Text(
                article.title ?? '',
                style: theme.textTheme.bodyText1?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              const SizedBox(height: 8.0),
              if (article.description != null)
                Text(
                  article.description ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Source: ${article.source?.name ?? ''}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Published: ${_formatDate(article.publishedAt)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null) return '';
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('yMMMd');
    return formatter.format(parsedDate);
  }
}
