import 'package:daily_news/features/daily_news/domain/entities/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleWidgets extends StatelessWidget {
  final ArticleEntity? article;
  final bool? isRemovable;
  final void Function(ArticleEntity? article)? onRemove;
  final void Function(ArticleEntity? article)? onArticlePressed;
  const ArticleWidgets(
      {super.key,
      this.article,
      this.isRemovable,
      this.onRemove,
      this.onArticlePressed});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsetsDirectional.only(
          start: 14, end: 14, bottom: 5, top: 5),
      height: screenSize.width / 2.2,
      child: Row(
        children: [
          _buildImage(context),
          _buildTitleAndDescription(),
          IconButton(
            onPressed: () => onRemove,
            icon: const Icon(Icons.remove_circle_outline_outlined),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return GestureDetector(
      onTap: () => onArticlePressed!(article),
      child: CachedNetworkImage(
        imageUrl: article!.urlToImage ?? '',
        imageBuilder: (context, imageProvider) => Padding(
          padding: const EdgeInsetsDirectional.only(end: 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 3.3,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.07),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, progress) => Padding(
          padding: const EdgeInsetsDirectional.only(end: 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.07),
              ),
              child: const CupertinoActivityIndicator(),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Padding(
          padding: const EdgeInsetsDirectional.only(end: 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  0.07,
                ),
              ),
              child: const Icon(
                Icons.error,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return InkWell(
      onTap: () => onArticlePressed!(article),
      child: Expanded(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              article!.title ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
                // fontFamily: "Butler",
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  article!.description ?? "",
                  maxLines: 2,
                ),
              ),
            ),
            // Date time
            Row(
              children: [
                const Icon(
                  Icons.timeline_outlined,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  article!.publishedAt ?? '',
                  style: const TextStyle(fontSize: 12),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
