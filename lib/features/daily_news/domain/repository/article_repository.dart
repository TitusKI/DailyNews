import 'package:daily_news/core/resources/data_state.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  // Top - Headlines via category
//general
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
// business
  Future<DataState<List<ArticleEntity>>> getBusinessArticles();
// sports
  Future<DataState<List<ArticleEntity>>> getSportsArticles();
// technology
  Future<DataState<List<ArticleEntity>>> getTechnologyArticles();
// science
  Future<DataState<List<ArticleEntity>>> getScienceArticles();
// entertainmet
  Future<DataState<List<ArticleEntity>>> getEntertaimentArticles();
// health
  Future<DataState<List<ArticleEntity>>> getHealthArticles();
// Everything  sortBy
// popularity
  Future<DataState<List<ArticleEntity>>> getPopularArticles();
// publishedAt recent
  Future<DataState<List<ArticleEntity>>> getRecentArticles();
  Future<DataState<List<ArticleEntity>>> getAllNewsArticles();

  Future<List<ArticleEntity>> getSavedArticles();
  Future<void> saveArticle(ArticleEntity article);
  Future<void> removeArticle(ArticleEntity article);
}
