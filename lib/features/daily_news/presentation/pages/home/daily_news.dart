import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:daily_news/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:daily_news/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../config/routes/routes.dart';

class DailyNews extends StatelessWidget {
  final String? newsType;
  final List<ArticleEntity>? articles;
  const DailyNews({super.key, this.newsType, this.articles});

// late RemoteArticleBloc _bloc
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(newsType ?? "",
          style: const TextStyle(
            color: Colors.black,
          )),
      actions: [
        GestureDetector(
          onTap: () => _onShowSavedArticles(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(
              Icons.bookmark,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }

  _buildBody() {
    return
        // BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        //   builder: (context, state) {
        // if (state is RemoteArticleLoading) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        // if (state is RemoteArticleError) {
        //   return InfoBannerActionsFb1(
        //     primaryColor: const Color(0xff4338CA),
        //     text: "Your internet connection was restored",
        //     actions: [
        //       TextButton(
        //         child: const Text(
        //           'TRY AGAIN',
        //           style: TextStyle(color: Color(0xff4338CA)),
        //         ),
        //         onPressed: () {
        //           context
        //               .read<RemoteArticleBloc>()
        //               .add(const GetArticlesEvent());
        //         },
        //       ),
        //     ],
        //     icon: const Icon(
        //       Icons.signal_wifi_connected_no_internet_4,
        //       color: Colors.white,
        //     ),
        //   );
        // }

        // if (state is RemoteArticleDone) {
        ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _onArticlePressed(context, articles![index]),
          child: ArticleWidgets(
            article: articles?[index],
          ),
        );
      },
      itemCount: articles!.length,
    );

    //     return Container();
    // //   },
    // );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity? article) {
    if (article != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ArticleDetailView(
                article: article,
              )));
    }
  }

  void _onShowSavedArticles(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.SAVED_ARTICLE);
  }
}

class InfoBannerActionsFb1 extends StatelessWidget {
  final Icon icon;
  final Color primaryColor;
  final List<TextButton> actions;
  final String text;

  const InfoBannerActionsFb1(
      {required this.icon,
      required this.actions,
      required this.text,
      this.primaryColor = Colors.blue,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: MaterialBanner(
        forceActionsBelow: true,
        elevation: 10,
        content: Text(
          text,
          style: TextStyle(color: primaryColor),
        ),
        leading: CircleAvatar(
          backgroundColor: primaryColor,
          child: icon,
        ),
        actions: actions,
      ),
    );
  }
}
