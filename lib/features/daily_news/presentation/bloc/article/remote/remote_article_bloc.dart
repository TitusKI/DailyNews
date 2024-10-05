import 'package:daily_news/core/resources/data_state.dart';
import 'package:daily_news/features/daily_news/domain/usecases/top_headlines/get_article.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;
  // Specify the init state as a loading
  RemoteArticleBloc(this._getArticleUseCase)
      : super(const RemoteArticleLoading()) {
    on<GetArticlesEvent>(_onGetArticle);
  }
  void _onGetArticle(
      GetArticlesEvent event, Emitter<RemoteArticleState> emit) async {
    print('On gettting Article');
    // in dart a method name CALL can be run both by calling
    //object.call() and
    //object()
    final dataState = await _getArticleUseCase();
    print(" Data Fetched Succesfully : ${dataState.data}");
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(
        RemoteArticleDone(dataState.data!),
      );
    }
    if (dataState is DataFailed) {
      print(dataState.error);
      emit(
        RemoteArticleError(dataState.error!),
      );
    }
  }
}
