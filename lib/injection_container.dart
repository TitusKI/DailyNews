import 'package:daily_news/features/daily_news/domain/usecases/everything/get_all_news_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/everything/get_popular_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/everything/get_recent_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/top_headlines/get_business_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/top_headlines/get_entertainment_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/top_headlines/get_health_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/top_headlines/get_science_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/top_headlines/get_sports_articles.dart';
import 'package:daily_news/features/daily_news/domain/usecases/top_headlines/get_technology_articles.dart';

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
  sl.registerSingleton<GetBusinessArticlesUsecase>(
    GetBusinessArticlesUsecase(),
  );
  sl.registerSingleton<GetSportsArticlesUsecase>(
    GetSportsArticlesUsecase(),
  );
  sl.registerSingleton<GetTechnologyArticlesUsecases>(
    GetTechnologyArticlesUsecases(),
  );
  sl.registerSingleton<GetScienceArticlesUsecases>(
    GetScienceArticlesUsecases(),
  );
  sl.registerSingleton<GetEntertainmentArticlesUsecases>(
    GetEntertainmentArticlesUsecases(),
  );
  sl.registerSingleton<GetHealthArticlesUsecases>(
    GetHealthArticlesUsecases(),
  );
  sl.registerSingleton<GetPopularArticlesUsecases>(
    GetPopularArticlesUsecases(),
  );

  sl.registerSingleton<GetRecentArticlesUsecases>(
    GetRecentArticlesUsecases(),
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
    () => RemoteArticleBloc(),
  );
  // LocalArticleBloc
  sl.registerFactory<LocalArticleBloc>(() => LocalArticleBloc());
}
