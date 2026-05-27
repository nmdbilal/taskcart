import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskcart/features/ecommerce/domain/entities/category_entity.dart';

class CategorySectionWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  const CategorySectionWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (_, index) {
          final category = categories[index];
          return Container(
            margin: EdgeInsets.only(right: 12.w),
            child: Column(
              children: [
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: Colors.green.shade100),
                  ),
                  child: Center(
                    child: Text(category.icon, style: TextStyle(fontSize: 26.sp)),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(category.name, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500)),
              ],
            ),
          );
        },
      ),
    );
  }
}