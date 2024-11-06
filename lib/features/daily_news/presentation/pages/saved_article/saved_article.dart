import 'package:daily_news/config/routes/names.dart';
import 'package:daily_news/core/constants/export.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:daily_news/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:daily_news/features/daily_news/presentation/pages/home/home.dart';
import 'package:daily_news/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:daily_news/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedArticles extends StatefulWidget {
  const SavedArticles({super.key});

  @override
  State<SavedArticles> createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  int selectedIndex = 2;

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
        ),
      ),
      title: const Text("Saved Articles"),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      color: Colors.white,
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                  text: "Home",
                  icon: Icons.home,
                  selected: selectedIndex == 0,
                  onPressed: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                    Navigator.pushNamed(context, RoutesName.HOME);
                  }),
              IconBottomBar(
                  text: "Categories",
                  icon: Icons.category,
                  selected: selectedIndex == 1,
                  onPressed: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                    Navigator.popAndPushNamed(
                        context, RoutesName.ARTICLE_CATEGORY);
                  }),
              IconBottomBar(
                  text: "Saved",
                  icon: Icons.bookmark,
                  selected: selectedIndex == 2,
                  onPressed: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>()..add(const GetSavedArticleEvent()),
      child: Scaffold(
        bottomNavigationBar: _buildBottomNavBar(),
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }
}

Widget _buildBody() {
  return BlocBuilder<LocalArticleBloc, LocalArticlesState>(
      builder: (context, state) {
    if (state is LocalArticlesLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is LocalArticlesDone) {
      return _buildArticleList(state.articles!);
    }
    return Container();
  });
}

Widget _buildArticleList(List<ArticleEntity> articles) {
  if (articles.isEmpty) {
    return const Center(
      child: Text(
        "No Saved Articles",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
  return ListView.builder(
    itemCount: articles.length,
    itemBuilder: (context, index) {
      return ArticleWidgets(
        article: articles[index],
        isRemovable: true,
        // onRemove: (article) => _onRemoveArticle(context, article!),
        // onArticlePressed: (article) => _onArticlePressed(context, article!),
      );
    },
  );
}

// void _onRemoveArticle(BuildContext context, ArticleEntity article) {
//   BlocProvider.of<LocalArticleBloc>(context).add(RemoveArticleEvent(article));
// }

void _onArticlePressed(BuildContext context, ArticleEntity article) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ArticleDetailView(
            article: article,
          )));
}
