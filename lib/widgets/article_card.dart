import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/home_screen/data/models/article_model.dart';

class ArticleCard extends StatelessWidget {
  final double height;
  final double width;
  final double padding;
  final ArticleModel articleModel;

  const ArticleCard({
    Key? key,
    required this.height,
    required this.width,
    required this.padding,
    required this.articleModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement ontap
      },
      child: Card(
        margin: const EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Show image only if its available
              if (articleModel.urlToImage != null)
                Center(
                  child: CachedNetworkImage(
                    height: height * 0.55,
                    imageUrl: articleModel.urlToImage!,
                    cacheKey: articleModel.urlToImage!,
                    // Show circularProgressIndicator while image load
                    placeholder: (_, __) {
                      return const Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()),
                      );
                    },
                    // Show error message while image load fails
                    errorWidget: (_, __, ___) {
                      return Row(
                        children: const [
                          Icon(Icons.error_outline),
                          Text(
                            'Error fetching image',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              const SizedBox(height: 5),

              // Show title only if its available
              if (articleModel.title != null)
                SizedBox(
                  height: height * 0.15,
                  child: Text(
                    articleModel.title!,
                    maxLines: 2,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: width * 0.055,
                        fontWeight: FontWeight.w400),
                  ),
                ),

              // Show published date only if its avaiable
              if (articleModel.publishedAt != null)
                Text(
                  DateFormat('MMM dd, y hh:mm a')
                      .format(DateTime.parse(articleModel.publishedAt!)),
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
              const SizedBox(height: 5),

              // Show descripition only if its available
              if (articleModel.description != null)
                SizedBox(
                  height: height * 0.1,
                  child: Text(
                    articleModel.description!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
