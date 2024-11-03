import 'package:daily_news/core/util/date_formatter.dart';

const String newsApiBaseURL = 'https://newsapi.org/v2';
const String newsApiKey = 'd8b7c4314951450f8f536ad3ec8e1693';

const String countryQuery = 'us';
// const String categoryQuery = 'general';
const String domains = 'bbc.co.uk, techcrunch.com, engadget.com';
const String popularDomains = 'bbc.co.uk, techcrunch.com';
DateTime date = DateTime.now().subtract(const Duration(days: 4));

String recentDomains =
    'bbc.co.uk, techcrunch.com, engadget.com&${formatDate(date)}';

enum Category {
  entertainment,
  general,
  health,
  science,
  sports,
  technology,
  business
}

enum SortBy {
  popularity,
  relevancy,
  publishedAt,
}

// const String getArticles =
//     "$newsApiBaseURL/top-headlines?country=$countryQuery&category=$categoryQuery&apiKey=$newsApiKey";
