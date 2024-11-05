import 'package:daily_news/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:daily_news/features/daily_news/domain/usecases/remove_article.dart';
import 'package:daily_news/features/daily_news/domain/usecases/save_article.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:daily_news/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticlesState> {
  LocalArticleBloc() : super(const LocalArticlesLoading()) {
    on<GetSavedArticleEvent>(_getSavedArticle);
    on<SaveArticleEvent>(_saveArticle);
    on<RemoveArticleEvent>(_removeArtile);
  }

  void _getSavedArticle(
      GetSavedArticleEvent event, Emitter<LocalArticlesState> emit) async {
    final articles = await sl<GetSavedArticleUseCase>().call();
    emit(LocalArticlesDone(articles));
  }

  void _removeArtile(
      RemoveArticleEvent event, Emitter<LocalArticlesState> emit) async {
    await sl<RemoveArticleUseCase>().call(parms: event.article);
    print(event.article);
    print("Article deleted successfully");
    final articles = await sl<GetSavedArticleUseCase>().call();
    print(articles.length);
    emit(LocalArticlesDone(articles));
  }

  void _saveArticle(
      SaveArticleEvent event, Emitter<LocalArticlesState> emit) async {
    await sl<SaveArticleUseCase>().call(parms: event.article);
    final articles = await sl<GetSavedArticleUseCase>().call();
    emit(LocalArticlesDone(articles));
  }
}
