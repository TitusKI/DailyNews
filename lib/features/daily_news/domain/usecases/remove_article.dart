import 'package:daily_news/core/usecase/usecase.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:daily_news/features/daily_news/domain/repository/article_repository.dart';

// Usecase is the domain where all the bussiness logic get executed
class RemoveArticleUseCase implements Usecase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;
  const RemoveArticleUseCase(this._articleRepository);
  @override
  Future<void> call({ArticleEntity? parms}) {
    return _articleRepository.removeArticle(parms!);
  }
}
