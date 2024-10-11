import 'package:daily_news/features/daily_news/domain/usecases/everything/get_all_news_articles.dart';

import 'core/constants/export.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  //floor local database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);
  //dio
  sl.registerSingleton<Dio>(Dio());
  // The use of Register Singleton
  //api Services
  sl.registerSingleton<NewsApiServices>(
    NewsApiServices(sl()),
  );
  // repositories
  sl.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(sl(), sl()),
  );
  // usecases
  sl.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(sl()),
  );
  sl.registerSingleton<GetAllNewsArticlesUsecase>(
    GetAllNewsArticlesUsecase(),
  );
  // Get Saved data from local
  sl.registerSingleton<GetSavedArticleUseCase>(
    GetSavedArticleUseCase(sl()),
  );
  // save data to local
  sl.registerSingleton<SaveArticleUseCase>(
    SaveArticleUseCase(sl()),
  );

  // remove data from local
  sl.registerSingleton<RemoveArticleUseCase>(
    RemoveArticleUseCase(sl()),
  );
  // blocs - use registerFactory since
  // it gets a new instance when a state is changes
  // RemoteArticleBloc
  sl.registerFactory<RemoteArticleBloc>(
    () => RemoteArticleBloc(sl()),
  );
  // LocalArticleBloc
  sl.registerFactory<LocalArticleBloc>(
      () => LocalArticleBloc(sl(), sl(), sl()));
}
