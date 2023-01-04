import 'package:flutter/material.dart';
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
          boxShadow: [
            BoxShadow(
                color: Colors.grey, spreadRadius: 1, blurRadius: width * 0.01)
          ],
          borderRadius: BorderRadius.circular(width * 0.05),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
            if (articleModel.urlToImage != null)
              SizedBox(
                height: heigth * 0.55,
                child: Image.network(
                  articleModel.urlToImage!,
                  fit: BoxFit.scaleDown,
                ),
              ),
            SizedBox(
              child: Text(
                DateTime.parse(articleModel.publishedAt!).toString(),
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
