import 'package:daily_news/core/resources/data_state.dart';
import 'package:daily_news/core/usecase/usecase.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:daily_news/features/daily_news/domain/repository/article_repository.dart';

// Usecase is the domain where all the bussiness logic get executed
class GetArticleUseCase
    implements Usecase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;
  const GetArticleUseCase(this._articleRepository);
  @override
  Future<DataState<List<ArticleEntity>>> call({void parms}) {
    return _articleRepository.getNewsArticles();
  }
}
