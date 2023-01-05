import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home_screen/data/models/article_model.dart';
import 'package:news_app/home_screen/logic/bloc/bloc.dart';
import 'package:news_app/theme/uiparameters.dart';
import 'package:news_app/widgets/article_card.dart';
import 'package:news_app/widgets/search_box.dart';
import 'package:news_app/widgets/sidemenu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        context.read<NewsBloc>().add(LazyLoadArticlesEvent());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
        drawer: const SideMenu(),
        body: homeBody(),
      ),
    );
  }

  Widget homeBody() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        // NewsInitialState - First lauch state
        if (state is NewsInitialState) {
          context.read<NewsBloc>().add(GetArticlesEvent());
        }

        // NewsLoadingState - While loading news/articles
        else if (state is NewsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        // NewsErrorState - On error while fetching news
        else if (state is NewsErrorState) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<NewsBloc>().add(
                    GetArticlesEvent(
                        categoryName: context.read<NewsBloc>().categoryName),
                  );
            },
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
        else if (state is NewsSuccessState) {
          return RefreshIndicator(
              onRefresh: () async {
                context.read<NewsBloc>().add(
                      GetArticlesEvent(
                          categoryName: context.read<NewsBloc>().categoryName),
                    );
              },
              child: Column(
                children: [
                  SearchBox(context),
                  Expanded(child: buildArticles(context, state.articles)),
                ],
              ));
        }

        // default child - display loading animation
        return const Center(child: CircularProgressIndicator());
      },
    );
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
              controller: _controller,
              padding: EdgeInsets.only(
                  left: width * 0.025, right: width * 0.025, top: width * 0.01),
              itemCount: articles!.length + 1,
              itemBuilder: ((context, index) {
                if (index < articles.length) {
                  return ArticleCard(
                    height: heigth * 0.451,
                    width: width,
                    padding: width * 0.03,
                    articleModel: articles[index],
                  );
                }

                // show CircularProgressIndicator is list contains more items to load
                else {
                  return context.watch<NewsBloc>().hasMore
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ))
                      : Container();
                }
              })),
        ),
      ],
    );
  }
}
