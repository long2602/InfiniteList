import 'package:flutter/material.dart';
import 'package:infinite_list/models/Product.dart';
import 'package:provider/provider.dart';

import '../../providers/ProductProvider.dart';

class ItemProductWidget extends StatelessWidget {
  final Product product;
  final bool isEnableFav;
  const ItemProductWidget({super.key, required this.product, this.isEnableFav = true});

  @override
  Widget build(BuildContext context) {
    final isCheck = context.watch<ProductProvider>().listFavoriteProducts.where(
      (element) {
        return element.idProduct == product.id;
      },
    );
    return Material(
      elevation: 1,
      child: InkWell(
        onTap: isEnableFav
            ? () {
                if (isCheck.isEmpty) {
                  context.read<ProductProvider>().setFavoriteProducts(isFavorite: true, idProduct: product.id);
                } else {
                  context.read<ProductProvider>().setFavoriteProducts(isFavorite: false, idProduct: product.id, id: isCheck.first.id);
                }
              }
            : () {},
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(fontSize: 12),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${product.price.toString()}\$",
                                style: TextStyle(color: Colors.deepOrangeAccent),
                              ),
                              Text(
                                "${product.stock} sold",
                                style: TextStyle(fontSize: 8),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                isCheck.isEmpty ? Icons.favorite_border : Icons.favorite,
                color: Colors.deepOrangeAccent,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
