import 'package:flutter/material.dart';
import 'package:infinite_list/controllers/DBController.dart';
import 'package:infinite_list/providers/ProductProvider.dart';
import 'package:infinite_list/views/Components/AppBarSearch.dart';
import 'package:infinite_list/views/Components/ItemProductWidget.dart';
import 'package:infinite_list/views/Components/SearchScreen.dart';
import 'package:infinite_list/views/FavoriteScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  int skip = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProductProvider>().getProduct(skip: 0);
      context.read<ProductProvider>().getFavoriteProducts();
    });

    DBController().getFavoriteList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        skip += 20;
        context.read<ProductProvider>().getProduct(skip: skip);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarSearch(
          controller: _searchController,
          onTap: context.watch<ProductProvider>().isError
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
          onTapFavoriteButton: context.watch<ProductProvider>().isError
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoriteScreen(),
                    ),
                  );
                }),
      body: context.watch<ProductProvider>().isError
          ? const Center(
              child: Text(
                "Loading product failed.\nPlease check your network.",
                textAlign: TextAlign.center,
              ),
            )
          : ListView(
              controller: _scrollController,
              children: [
                GridView.builder(
                  padding: const EdgeInsets.all(4.0),
                  primary: false,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: context.watch<ProductProvider>().listProducts.length,
                  itemBuilder: (context, index) {
                    return ItemProductWidget(product: context.watch<ProductProvider>().listProducts[index]);
                  },
                ),
                Visibility(
                  visible: context.watch<ProductProvider>().isLoading,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
