import 'package:daily_news/core/constants/export.dart';
import 'package:daily_news/core/resources/data_state.dart';
import 'package:daily_news/core/usecase/usecase.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:daily_news/injection_container.dart';

class GetEntertainmentArticlesUsecases
    implements Usecase<DataState<List<ArticleEntity>>, void> {
  @override
  Future<DataState<List<ArticleEntity>>> call({void parms}) async {
    return await sl<ArticleRepository>().getEntertaimentArticles();
  }
}
