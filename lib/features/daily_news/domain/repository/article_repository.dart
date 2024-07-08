import 'package:daily_news/core/resources/data_state.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
