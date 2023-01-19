import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/common/ui/kSearchBox.dart';
import 'package:news_app/data/models/news_article_model.dart';
import 'package:news_app/theme/uiparameters.dart';
import 'package:news_app/common/ui/kArticleCard.dart';
import 'package:news_app/modules/presentation/home/home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        HomeScreenController.to.lazyLoadArticles();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Will hide keyboard when pressed outside the search box
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News App'),
        ),
        drawer: const HomePageDrawer(),
        body: homeBody(),
      ),
    );
  }

  Widget homeBody() {
    return GetBuilder<HomeScreenController>(builder: (controller) {
      // InitialState - First lauch state
      if (controller.homeScreenState == HomeScreenState.initial) {
        controller.getArticles();
      }

      // LoadingState - While loading news/articles
      if (controller.homeScreenState == HomeScreenState.loading) {
        return const Center(child: CircularProgressIndicator());
      }

      // ErrorState - On error while fetching news
      else if (controller.homeScreenState == HomeScreenState.error) {
        return RefreshIndicator(
          onRefresh: () async => controller.getArticles(),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.error_outline),
              Text("Error Occured!!"),
            ],
          )),
        );
      }

      // NewsSuccessState - On successful news Load
      else if (controller.homeScreenState == HomeScreenState.loaded) {
        return RefreshIndicator(
            onRefresh: () async => controller.getArticles(),
            child: Column(
              children: [
                const KSearchBox(),
                Expanded(child: buildArticles(context, controller.articles)),
              ],
            ));
      }

      // default child - display loading animation
      return const Center(child: CircularProgressIndicator());
    });
  }

  Widget buildArticles(BuildContext context, List<ArticleModel>? articles) {
    double heigth = UIParameters.getHeight(context);
    double width = UIParameters.getWidth(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(
                left: width * 0.025, right: width * 0.025, top: width * 0.01),
            itemCount: articles!.length + 1,
            itemBuilder: ((context, index) {
              if (index < articles.length) {
                return KArticleCard(
                  height: heigth * 0.451,
                  width: width,
                  padding: width * 0.03,
                  articleModel: articles[index],
                );
              }

              // show CircularProgressIndicator is list contains more items to load
              else {
                return HomeScreenController.to.hasMore
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ))
                    : Container();
              }
            }),
          ),
        ),
      ],
    );
  }
}
