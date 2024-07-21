import 'package:flutter/material.dart';

AppBar appBarSearch({required TextEditingController controller, required void Function()? onTap, required void Function()? onTapFavoriteButton}) {
  return AppBar(
    backgroundColor: Colors.deepOrangeAccent,
    titleSpacing: 0,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: TextField(
                controller: controller,
                maxLines: 1,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(fontSize: 14),
                cursorColor: Colors.deepOrangeAccent,
                readOnly: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
                onTap: onTap,
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onTapFavoriteButton,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
              height: 36,
              width: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.deepOrangeAccent,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

AppBar appBarSearch2({required TextEditingController controller, required void Function()? onBack, required FocusNode focusNode}) {
  return AppBar(
    backgroundColor: Colors.deepOrangeAccent,
    leading: IconButton(
      onPressed: onBack,
      icon: const Icon(Icons.arrow_back, color: Colors.white),
    ),
    titleSpacing: 0,
    title: Row(
      children: [
        Expanded(
          child: Container(
            height: 36,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              maxLines: 1,
              autofocus: true,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(fontSize: 14),
              cursorColor: Colors.deepOrangeAccent,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 13),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: 36,
            width: 36,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: const Icon(
              Icons.search,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),
      ],
    ),
  );
}
