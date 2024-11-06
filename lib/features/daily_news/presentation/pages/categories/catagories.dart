// ignore_for_file: use_build_context_synchronously

import 'package:daily_news/config/routes/names.dart';
import 'package:daily_news/config/theme/app_theme.dart';
import 'package:daily_news/core/resources/generic_state.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:daily_news/features/daily_news/presentation/pages/home/daily_news.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleCategory extends StatefulWidget {
  const ArticleCategory({super.key});

  @override
  State<ArticleCategory> createState() => _ArticleCategoryState();
}

class _ArticleCategoryState extends State<ArticleCategory> {
  final List<Map<String, String>> categories = [
    {'title': 'Business', 'image': 'assets/images/business.jpg'},
    {'title': 'Sports', 'image': 'assets/images/sports.jpg'},
    {'title': 'Technology', 'image': 'assets/images/technology.jpg'},
    {'title': 'Science', 'image': 'assets/images/science.jpg'},
    {'title': 'Entertainment', 'image': 'assets/images/entertainment.jpg'},
    {'title': 'Health', 'image': 'assets/images/health.jpg'},
    {'title': 'General', 'image': 'assets/images/general.jpg'},
  ];

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavBar(),
      body: BlocBuilder<RemoteArticleBloc, GenericState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () =>
                      _onCategoryTap(context, category['title']!, state),
                  child: Card(
                    elevation: 4,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            category['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                        Text(
                          category['title'] ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _onCategoryTap(
      BuildContext context, String category, GenericState state) async {
    final bloc = context.read<RemoteArticleBloc>();

    switch (category) {
      case "Business":
        await bloc.getPopularArticles();
        _navigateOnSuccess(context, state, state.popularArticles, category);
        break;
      case "Sports":
        await bloc.getSportsArticles();
        _navigateOnSuccess(context, state, state.sportsArticles, category);
        break;
      case "Technology":
        await bloc.getTechnologyArticles();
        _navigateOnSuccess(context, state, state.technologyArticles, category);
        break;
      case "Science":
        await bloc.getScienceArticles();
        _navigateOnSuccess(context, state, state.scienceArticles, category);
        break;
      case "Entertainment":
        await bloc.getEntertainmentArticles();
        _navigateOnSuccess(
            context, state, state.entertainmentArticles, category);
        break;
      case "Health":
        await bloc.getHealthArticles();
        _navigateOnSuccess(context, state, state.healthArticles, category);
        break;
      case "General":
        await bloc.getArticle();
        _navigateOnSuccess(context, state, state.generalArticles, category);
        break;
      default:
        bloc.getPopularArticles();
        _navigateOnSuccess(context, state, state.popularArticles, category);
        break;
    }
  }

  void _navigateOnSuccess(BuildContext context, GenericState state,
      List<ArticleEntity>? articles, String category) {
    if (state.isLoading) {
      showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
    } else if (articles != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DailyNews(
            articles: articles,
            newsType: category,
          ),
        ),
      );
    }

    //  else if (state.failure != null) {
    //   print("Error: ${state.failure}");
    // }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
        ),
      ),
      title: const Text("Categories"),
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
                  }),
              IconBottomBar(
                  text: "Saved",
                  icon: Icons.bookmark,
                  selected: selectedIndex == 2,
                  onPressed: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                    Navigator.pushNamed(context, RoutesName.SAVED_ARTICLE);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

// void onCatagoryTap(String? title) async {}

class IconBottomBar extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;

  const IconBottomBar({
    super.key,
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: selected ? AppColors.primaryColor : Colors.grey),
          Text(
            text,
            style: TextStyle(
                color: selected ? AppColors.primaryColor : Colors.grey),
          ),
        ],
      ),
    );
  }
}
