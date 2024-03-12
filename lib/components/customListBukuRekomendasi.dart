import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListRekomendasiBuku extends StatelessWidget {
  final context;

  CustomListRekomendasiBuku({
    super.key,
    required this.context,
  });

  List<CardItem> items = const [
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
    return ScreenUtilInit(
      builder: (context,_) =>
      SizedBox(
        height: 100.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount : 4,
          separatorBuilder: (context, _) => SizedBox(width: 15,),
          itemBuilder: (context, index) => builCard(items:items[index]),
        ),
      ),
    );
  }

  Widget builCard({
    required CardItem items,
})=> ClipRRect(
  borderRadius: BorderRadius.circular(100),
  child: AspectRatio(
    aspectRatio: 2 / 2,
    child: Image.asset(
      items.imageURl,
      fit: BoxFit.fill,
    ),
  ),
);
}

class CardItem {
  final String imageURl;

  const CardItem({
    required this.imageURl,
});
}
