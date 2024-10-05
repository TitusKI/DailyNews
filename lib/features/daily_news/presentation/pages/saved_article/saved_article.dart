import 'package:daily_news/config/routes/routes.dart';
import 'package:daily_news/core/constants/export.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:daily_news/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:daily_news/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:daily_news/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SavedArticles extends HookWidget {
  const SavedArticles({super.key});

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      title: const Text("Saved Articles"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>()..add(const GetSavedArticleEvent()),
      child: Scaffold(
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
        onRemove: (article) => _onRemoveArticle(context, article!),
        onArticlePressed: (article) => _onArticlePressed(context, article!),
      );
    },
  );
}

void _onBackButtonTapped(BuildContext context) {
  Navigator.pop(context);
}

void _onRemoveArticle(BuildContext context, ArticleEntity article) {
  BlocProvider.of<LocalArticleBloc>(context).add(RemoveArticleEvent(article));
}

void _onArticlePressed(BuildContext context, ArticleEntity article) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ArticleDetailView(
            article: article,
          )));
}
