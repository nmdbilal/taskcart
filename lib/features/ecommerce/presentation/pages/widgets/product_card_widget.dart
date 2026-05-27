import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskcart/features/ecommerce/domain/entities/product_entity.dart';

class ProductCards extends StatefulWidget {
  final ProductEntity product;
  const ProductCards({super.key, required this.product});

  @override
  State<ProductCards> createState() => _ProductCardsState();
}

class _ProductCardsState extends State<ProductCards> {
  int _qty = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
              child: CachedNetworkImage(
                imageUrl: widget.product.image,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (_, _) => Container(color: Colors.grey[100]),
                errorWidget: (_, _, _) => Container(
                  color: Colors.grey[100],
                  child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  widget.product.unit,
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey[500]),
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${widget.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700]),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 13.sp),
                        SizedBox(width: 2.w),
                        Text('${widget.product.rating}',
                            style: TextStyle(
                                fontSize: 11.sp, color: Colors.grey[600])),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _qty == 0 ? _buildAddButton() : _buildQtyControls(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
      key: const ValueKey('add'),
      width: double.infinity,
      height: 30.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          padding: EdgeInsets.zero,
        ),
        onPressed: () => setState(() => _qty = 1),
        child: Text('Add',
            style: TextStyle(fontSize: 12.sp, color: Colors.white)),
      ),
    );
  }

  Widget _buildQtyControls() {
    return Container(
      key: const ValueKey('qty'),
      height: 30.h,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => setState(() => _qty > 1 ? _qty-- : _qty = 0),
            child: Container(
              width: 30.w,
              height: 30.h,
              alignment: Alignment.center,
              child: Icon(
                _qty == 1 ? Icons.delete_outline : Icons.remove,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ),
          Text(
            '$_qty',
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          GestureDetector(
            onTap: () => setState(() => _qty++),
            child: Container(
              width: 30.w,
              height: 30.h,
              alignment: Alignment.center,
              child: Icon(Icons.add, color: Colors.white, size: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}