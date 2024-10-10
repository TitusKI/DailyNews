const String newsApiBaseURL = 'https://newsapi.org/v2';
const String newsApiKey = 'c253d2daf33f4ac58364bdd87638611f';

const String countryQuery = 'us';

const String categoryQuery = 'general';

enum Category {
  entertaiment,
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

const String getArticles =
    "$newsApiBaseURL/top-headlines?country=$countryQuery&category=$categoryQuery&apiKey=$newsApiKey";
