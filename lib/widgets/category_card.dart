import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.textTheme,
    required this.name,
    required this.wallpaperLink,
  }) : super(key: key);

  final TextTheme textTheme;

  final String name;
  final String wallpaperLink;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 4.3,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(1, 1),
                  color: Colors.black54.withOpacity(0.3),
                  spreadRadius: 0.5,
                  blurRadius: 5)
            ],
            image: DecorationImage(
                image: NetworkImage(wallpaperLink), fit: BoxFit.cover)),
        // padding: EdgeInsets.symmetric(vertical: 50.h),
        margin: EdgeInsets.only(bottom: 20.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            color: Colors.black54.withOpacity(0.3),
            child: Center(
              child: Text(
                // wallpapersController.categories[index],
                name,
                style: textTheme.headline1?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ));
  }
}
