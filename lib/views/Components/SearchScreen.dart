import 'package:flutter/material.dart';
import 'package:infinite_list/views/Components/AppBarSearch.dart';
import 'package:provider/provider.dart';

import '../../providers/ProductProvider.dart';
import 'ItemProductWidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      context.read<ProductProvider>().searchProduct(key: _searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSearch2(
        controller: _searchController,
        focusNode: _focusNode,
        onBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(4.0),
        primary: false,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: context.watch<ProductProvider>().listProductsSearch.length,
        itemBuilder: (context, index) {
          return ItemProductWidget(product: context.watch<ProductProvider>().listProductsSearch[index]);
        },
      ),
    );
  }
}
