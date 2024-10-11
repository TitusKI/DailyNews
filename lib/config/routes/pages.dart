import 'package:daily_news/config/routes/names.dart';
import 'package:daily_news/core/constants/export.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:daily_news/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:daily_news/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:daily_news/features/daily_news/presentation/pages/saved_article/saved_article.dart';
import 'package:daily_news/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPages {
  const AppPages();
  List<PageEntity> routes() {
    return [
      PageEntity(
        route: RoutesName.HOME,
        page: const DailyNews(),
        bloc: BlocProvider(
          create: (_) => sl<RemoteArticleBloc>(),
        ),
      ),
      PageEntity(
        route: RoutesName.ARTICLE_DETAIL,
        page: const ArticleDetailView(),
        bloc: BlocProvider(
          create: (_) => sl<LocalArticleBloc>(),
        ),
      ),
      PageEntity(
        route: RoutesName.SAVED_ARTICLE,
        page: const SavedArticles(),
        bloc: BlocProvider(
          create: (_) =>
              sl<LocalArticleBloc>()..add(const GetSavedArticleEvent()),
        ),
      )
    ];
  }

  List<dynamic> allBlocProvider(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      if (bloc.bloc != null) {
        blocProviders.add(bloc.bloc);
      }
    }
    return blocProviders;
  }

  MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
            builder: (_) => result.first.page!, settings: settings);
      }
    }
    // ignore: avoid_print
    print("Invalid route name: ${settings.name}");
    return MaterialPageRoute(
        builder: (_) => const DailyNews(), settings: settings);
  }
}

class PageEntity {
  String? route;
  Widget? page;
  dynamic bloc;
  PageEntity({this.route, this.page, this.bloc});
}
