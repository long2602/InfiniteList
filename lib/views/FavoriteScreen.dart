import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ProductProvider.dart';
import 'Components/ItemProductWidget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProductProvider>().getListProductFavorite();
    });
  }

  fetchListFavorite() {
    context.watch<ProductProvider>().listProducts.forEach(
          (element) {},
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: const Text(
          "Favorite",
          style: TextStyle(color: Colors.white),
        ),
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
        itemCount: context.watch<ProductProvider>().listProductsFav.length,
        itemBuilder: (context, index) {
          return ItemProductWidget(
            product: context.watch<ProductProvider>().listProductsFav[index],
            isEnableFav: false,
          );
        },
      ),
    );
  }
}
