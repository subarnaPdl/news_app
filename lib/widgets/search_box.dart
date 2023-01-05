import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home_screen/logic/bloc/bloc.dart';

class SearchBox extends StatefulWidget {
  final BuildContext context;
  const SearchBox(this.context, {Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _tec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
      child: TextField(
        controller: _tec,
        style: TextStyle(color: Theme.of(context).textTheme.labelMedium?.color),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[400],
          contentPadding: const EdgeInsets.only(left: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search_rounded, color: Colors.white),
          // show clear icon only when there is some text in textfield
          suffixIcon: (_tec.text.isNotEmpty) ? clear() : null,
        ),

        // Update results on changed text
        onChanged: (value) => context.read<NewsBloc>().add(
              SearchArticlesEvent(searchText: value),
            ),
      ),
    );
  }

  Widget clear() {
    return IconButton(
        onPressed: () {
          _tec.clear(); // Clear textfield
          context
              .read<NewsBloc>()
              .add(SearchArticlesEvent(searchText: '')); // Update List
          FocusScope.of(context).requestFocus(FocusNode()); // Hide Keyboard
        },
        icon: const Icon(Icons.clear, color: Colors.white));
  }
}
