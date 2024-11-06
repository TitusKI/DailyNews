import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_news/config/routes/names.dart';
import 'package:daily_news/config/theme/app_theme.dart';
import 'package:daily_news/core/resources/generic_state.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:daily_news/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:daily_news/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    context.read<RemoteArticleBloc>().getRecentArticles();
    context.read<RemoteArticleBloc>().getPopularArticles();
    context.read<RemoteArticleBloc>().getAllArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TopBar(),
              const SearchInput(),
              const PromoCard(),
              // Headline(),

              BlocBuilder<RemoteArticleBloc, GenericState>(
                builder: (context, state) {
                  return CardListView(
                    articles: state.recentArticles,
                    newsType: "Recent News",
                    newsDesc: "Get recent news everyday",
                  );
                },
              ),

              BlocBuilder<RemoteArticleBloc, GenericState>(
                builder: (context, state) {
                  // context.read<RemoteArticleBloc>().getPopularArticles();
                  return CardListView(
                    articles: state.popularArticles,
                    newsType: "Popular News",
                    newsDesc: "Popular news of the year",
                  );
                },
              ),
              BlocBuilder<RemoteArticleBloc, GenericState>(
                builder: (context, state) {
                  // context.read<RemoteArticleBloc>().getAllArticles();
                  return CardListView(
                    articles: state.data,
                    newsType: "Explore News",
                    newsDesc: "Explore all news of the year",
                  );
                },
              ),

              // SHeadline(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
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
                    selected: _selectedIndex == 0,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    }),
                IconBottomBar(
                    text: "Categories",
                    icon: Icons.category,
                    selected: _selectedIndex == 1,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                      Navigator.popAndPushNamed(
                          context, RoutesName.ARTICLE_CATEGORY);
                    }),
                IconBottomBar(
                    text: "Saved",
                    icon: Icons.bookmark,
                    selected: _selectedIndex == 2,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                      Navigator.pushNamed(context, RoutesName.SAVED_ARTICLE);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {super.key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed});

  final IconData icon;
  final Function() onPressed;
  final bool selected;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: selected ? AppColors.primaryColor : Colors.grey,
          ),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 14,
              height: .1,
              color: selected ? AppColors.primaryColor : Colors.grey),
        )
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Discover \nNews",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.25)),
            ]),
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.newspaper,
                size: 25,
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 25.0, right: 25.0, bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.1)),
        ]),
        child: TextField(
          onChanged: (value) {
            //Do something wi
          },
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
        ),
      ),
    );
  }
}

class PromoCard extends StatelessWidget {
  const PromoCard({super.key, this.article});

  final ArticleEntity? article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff4567b7), AppColors.primaryColor])),
        child: const Stack(
          children: [
            Opacity(
              opacity: .5,
              child: Image(image: AssetImage('assets/news/news_logo.jpg')),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: Text(
                  "Daily \nNews",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardListView extends StatelessWidget {
  const CardListView({super.key, this.newsType, this.newsDesc, this.articles});

  final List<ArticleEntity>? articles;
  final String? newsDesc;
  final String? newsType;

  void _onArticlePressed(BuildContext context, ArticleEntity? article) {
    if (article != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ArticleDetailView(article: article)));
    }
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsType ?? "",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    newsDesc ?? " ",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              BlocBuilder<RemoteArticleBloc, GenericState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DailyNews(
                            articles: articles,
                            newsType: newsType ?? " ",
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "View More",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.normal),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0, right: 25.0),
          child: SizedBox(
            height: 200,
            child: BlocBuilder<RemoteArticleBloc, GenericState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                // if (state.failure != null) {
                //   print("The ERROR Message is:");
                //   print(state.failure);
                //   return const Center(
                //     child: Icon(Icons.signal_wifi_connected_no_internet_4),
                //   );
                // }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: articles?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => _onArticlePressed(context, articles![index]),
                      child: ArticleCard(
                        article: articles?[index],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, this.article});

  final ArticleEntity? article;

  Widget _buildImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: article?.urlToImage != null
          ? AspectRatio(
              aspectRatio: 1.5,
              child: CachedNetworkImage(
                imageUrl: article!.urlToImage!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CupertinoActivityIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            )
          : Container(
              height: 100,
              color: Colors.grey[300],
              child: const Icon(Icons.image, color: Colors.grey),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 10),
              blurRadius: 10,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(0.1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImage(context),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                article?.title ?? "No Title",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              article?.author ?? "Unknown Author",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
