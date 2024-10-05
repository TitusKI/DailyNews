import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:equatable/equatable.dart';

abstract class LocalArticleEvent extends Equatable {
  final ArticleEntity? article;
  const LocalArticleEvent({this.article});
  @override
  List<Object> get props => [article!];
}

class GetSavedArticleEvent extends LocalArticleEvent {
  const GetSavedArticleEvent();
}

class SaveArticleEvent extends LocalArticleEvent {
  const SaveArticleEvent(ArticleEntity article) : super(article: article);
}

class RemoveArticleEvent extends LocalArticleEvent {
  const RemoveArticleEvent(ArticleEntity article) : super(article: article);
}
