import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/home_screen/data/models/article_model.dart';

class ArticleCard extends StatelessWidget {
  final double heigth;
  final double width;
  final double padding;

  final ArticleModel articleModel;

  const ArticleCard({
    Key? key,
    required this.heigth,
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
      child: Container(
        padding: EdgeInsets.all(padding),
        margin: EdgeInsets.only(bottom: width * 0.03),
        height: heigth,
        width: width,
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //       color: Colors.grey, spreadRadius: 1, blurRadius: width * 0.01)
          // ],
          borderRadius: BorderRadius.circular(width * 0.05),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Show title only if its available
            if (articleModel.title != null)
              SizedBox(
                height: heigth * 0.15,
                child: Text(
                  articleModel.title!,
                  maxLines: 2,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: width * 0.055,
                      fontWeight: FontWeight.w400),
                ),
              ),

            // Show descripition only if its available
            if (articleModel.description != null)
              SizedBox(
                height: heigth * 0.15,
                child: Text(
                  articleModel.description!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
              ),

            // Show image only if its available
            if (articleModel.urlToImage != null)
              SizedBox(
                height: heigth * 0.55,
                child: CachedNetworkImage(
                  imageUrl: articleModel.urlToImage!,
                  cacheKey: articleModel.urlToImage!,
                  // Show circularProgressIndicator while image load
                  placeholder: (_, __) {
                    return const SizedBox(
                        height: 50, child: CircularProgressIndicator());
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

            // Show published date only if its avaiable
            if (articleModel.publishedAt != null)
              SizedBox(
                child: Text(
                  DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                      .parse(articleModel.publishedAt!)
                      .toUtc()
                      .toString(),
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
