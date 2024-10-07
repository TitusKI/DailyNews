import 'package:daily_news/core/usecase/usecase.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:daily_news/features/daily_news/domain/repository/article_repository.dart';

// Usecase is the domain where all the bussiness logic GetSaved executed
class GetSavedArticleUseCase implements Usecase<List<ArticleEntity>, void> {
  final ArticleRepository _articleRepository;
  const GetSavedArticleUseCase(this._articleRepository);
  @override
  Future<List<ArticleEntity>> call({void parms}) {
    return _articleRepository.getSavedArticles();
  }
}
