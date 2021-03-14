import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    @required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Theme.of(context).focusColor.withOpacity(0.5),
          width: 0.5,
        ),
        color: Theme.of(context).focusColor.withOpacity(0.1),
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Поиск ...',
          hintStyle:
          Theme.of(context).textTheme.subtitle1.copyWith(
            color: Theme.of(context)
                .textTheme
                .subtitle1
                .color
                .withOpacity(0.5),
          ),
          suffixIcon: Icon(
            Icons.search,
            size: 25.0,
            color: Theme.of(context).focusColor.withOpacity(0.5),
          ),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
