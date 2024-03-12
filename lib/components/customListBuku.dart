import 'package:flutter/material.dart';

class CustomListBuku extends StatelessWidget {
  final context;

  CustomListBuku({
    super.key,
    required this.context,
  });

  List<CardItem> items = [
    CardItem(
      imageURl: "lib/assets/buku/buku1.png",
    ),
    CardItem(
      imageURl: "lib/assets/buku/buku2.png",
    ),
    CardItem(
      imageURl: "lib/assets/buku/buku3.png",
    ),
    CardItem(
      imageURl: "lib/assets/buku/buku4.png",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount : 4,
        separatorBuilder: (context, _) => SizedBox(width: 10,),
        itemBuilder: (context, index) => builCard(items:items[index]),
      ),
    );
  }

  Widget builCard({
    required CardItem items,
  })=> Column(
    children: [
      SizedBox(
        height: 150,
        child: AspectRatio(
          aspectRatio: 4 / 5,
          child: Image.asset(
            items.imageURl,
            fit: BoxFit.fill,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {},
            child: const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Icon(
              Icons.bookmark_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    ],
  );
}

class CardItem {
  final String imageURl;

  const CardItem({
    required this.imageURl,
  });
}
