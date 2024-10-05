import 'package:daily_news/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:daily_news/features/daily_news/domain/usecases/remove_article.dart';
import 'package:daily_news/features/daily_news/domain/usecases/save_article.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticlesState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;
  LocalArticleBloc(this._getSavedArticleUseCase, this._saveArticleUseCase,
      this._removeArticleUseCase)
      : super(const LocalArticlesLoading()) {
    on<GetSavedArticleEvent>(_getSavedArticle);
    on<SaveArticleEvent>(_saveArticle);
    on<RemoveArticleEvent>(_removeArtile);
  }

  void _getSavedArticle(
      GetSavedArticleEvent event, Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void _removeArtile(
      RemoveArticleEvent event, Emitter<LocalArticlesState> emit) async {
    await _removeArticleUseCase(parms: event.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void _saveArticle(
      SaveArticleEvent event, Emitter<LocalArticlesState> emit) async {
    await _saveArticleUseCase(parms: event.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }
}
