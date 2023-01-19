import 'package:flutter/material.dart';
import 'package:news_app/modules/presentation/home/home_screen.dart';

class KSearchBox extends StatefulWidget {
  const KSearchBox({Key? key}) : super(key: key);

  @override
  State<KSearchBox> createState() => _KSearchBoxState();
}

class _KSearchBoxState extends State<KSearchBox> {
  final TextEditingController _tec = TextEditingController();

  @override
  void dispose() {
    _tec.dispose();
    super.dispose();
  }

  void clear() {
    // Clear the textfield
    _tec.clear();
    //setState to update UI first
    setState(() {});
    // Recreate the initial list
    HomeScreenController.to.searchArticles();
    //Hide keyboard
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
      child: TextField(
        controller: _tec,
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
          suffixIcon: _suffixIcon(),
        ),

        // Update results on changed text
        onChanged: (value) {
          //setState to update UI first
          setState(() {});
          // Perform searching and updating list
          HomeScreenController.to.searchArticles(searchText: value);
        },
      ),
    );
  }

  Widget? _suffixIcon() {
    // Only show the clear button if the text field has something
    if (_tec.text.isNotEmpty) {
      return IconButton(
        icon: const Icon(Icons.clear, color: Colors.white),
        onPressed: clear, //run the clear function
      );
    }
    return null;
  }
}
