import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskcart/features/ecommerce/domain/entities/product_entity.dart';
import 'package:taskcart/features/ecommerce/presentation/pages/widgets/product_card_widget.dart';

class SearchPage extends StatefulWidget {
  final List<ProductEntity> products;
  const SearchPage({super.key, required this.products});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<ProductEntity> _results = [];

  @override
  void initState() {
    super.initState();
    _results = widget.products;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _results = query.trim().isEmpty
          ? widget.products
          : widget.products
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        toolbarHeight: 75,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: _onSearch,
          style: TextStyle(fontSize: 15.sp),
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15.sp),
            border: InputBorder.none,
            suffixIcon: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (_, value, __) => value.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () {
                  _controller.clear();
                  _onSearch('');
                },
              )
                  : const SizedBox(),
            ),
          ),
        ),
      ),
      body: _results.isEmpty
          ? _buildEmpty()
          : GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.72,
        ),
        itemCount: _results.length,
        itemBuilder: (_, index) =>
            ProductCards(product: _results[index]),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 64.sp, color: Colors.grey[300]),
          SizedBox(height: 16.h),
          Text('No products found',
              style: TextStyle(fontSize: 15.sp, color: Colors.grey[500])),
        ],
      ),
    );
  }
}