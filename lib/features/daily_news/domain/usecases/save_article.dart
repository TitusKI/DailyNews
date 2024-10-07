import 'package:daily_news/core/usecase/usecase.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:daily_news/features/daily_news/domain/repository/article_repository.dart';

// Usecase is the domain where all the bussiness logic get executed
class SaveArticleUseCase implements Usecase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;
  const SaveArticleUseCase(this._articleRepository);
  @override
  Future<void> call({ArticleEntity? parms}) {
    return _articleRepository.saveArticle(parms!);
  }
}
