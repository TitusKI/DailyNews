import 'package:daily_news/config/theme/app_theme.dart';
import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:daily_news/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:daily_news/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleWidgets extends StatelessWidget {
  const ArticleWidgets({
    super.key,
    this.article,
    this.isRemovable = false,
    this.onRemove,
    this.onArticlePressed,
  });

  final void Function(ArticleEntity? article)? onRemove;
  final void Function(ArticleEntity? article)? onArticlePressed;
  final ArticleEntity? article;
  final bool isRemovable;

  Widget _buildImage(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width / 3.5;

    return GestureDetector(
      onTap: () => _onArticlePressed(context, article),
      child: (article?.urlToImage?.isNotEmpty == true ||
              article?.urlToImage != null)
          ? CachedNetworkImage(
              imageUrl: article!.urlToImage!,
              imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: imageWidth,
                  height: imageWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, progress) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: imageWidth,
                  height: imageWidth,
                  color: Colors.black.withOpacity(0.1),
                  child: const Center(child: CupertinoActivityIndicator()),
                ),
              ),
              errorWidget: (context, url, error) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: imageWidth,
                  height: imageWidth,
                  color: Colors.black.withOpacity(0.1),
                  child: const Icon(Icons.error, color: Colors.red),
                ),
              ),
            )
          : Image.asset(
              "assets/news/news_logo.jpg", // Fallback placeholder image
              width: imageWidth,
              height: imageWidth,
              fit: BoxFit.cover,
            ),
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity? article) {
    if (article != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ArticleDetailView(
            article: article,
          ),
        ),
      );
    }
  }

  Widget _buildTitleAndDescription(BuildContext context) {
    return GestureDetector(
      onTap: () => _onArticlePressed(context, article),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            article?.title ?? "No title available",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          // Description
          Text(
            article?.description ?? "No description available",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 6),
          // Date time
          Row(
            children: [
              const Icon(Icons.timeline_outlined, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                article?.publishedAt ?? 'Unknown date',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onRemoveArticle(BuildContext context, ArticleEntity article) async {
    // BlocProvider.of<LocalArticleBloc>(context).add(RemoveArticleEvent(article));
    context.read<LocalArticleBloc>().add(RemoveArticleEvent(article));
    // context.read<LocalArticleBloc>().add(const GetSavedArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(context),
          const SizedBox(width: 12),
          Expanded(child: _buildTitleAndDescription(context)),
          if (isRemovable)
            BlocBuilder<LocalArticleBloc, LocalArticlesState>(
              builder: (context, state) {
                if (state is LocalArticlesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context
                        .read<LocalArticleBloc>()
                        .add(RemoveArticleEvent(article!));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Article Deleted successfully'),
                        backgroundColor: AppColors.primaryColor,
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
