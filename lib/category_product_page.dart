import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:metrofood/Model/category.dart';
import 'package:metrofood/Model/products.dart';
import 'package:metrofood/api/baseclient.dart';
import 'package:metrofood/product_detail.dart';

class CategoryProductPage extends StatefulWidget {
  static const routeName = '/category_product-page';
  //const CategoryProductPage({super.key});
  //final String id;
  final String categoryId;
  const CategoryProductPage({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  // test category
  late Future<List<Categories>> futureCategory;
  List<String> listCategory = [];
  late Future<List<Products>> futureProductCategory;
  late List<Products> listProductCategory = [];

  late Future<List<Products>> futureProduct;
  late List<Products> listProduct = [];
  final List<String> imageUrls = [
    'images/banner1.png',
    'images/banner2.png',
    'images/banner3.png'
  ];
  int currentImageIndex = 0;


  @override
  void initState() {
    initializeData();
    super.initState();
  }

  String formatCurrency(double value) {
    final format = NumberFormat("#,###");
    return format.format(value);
  }

  Future<void> initializeData() async {
    futureProductCategory = BaseClient().fetchProduct();
    await futureProductCategory.then((value) {
      setState(() {
        listProductCategory =
            value.where((product) => product.categoryId == widget.categoryId).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(listProductCategory == null || listProductCategory.isEmpty) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              color: Color(0xFFFAFAFA), // Màu nền xám
            ),
            Center(
              child: CircularProgressIndicator(), // Màn hình loading (ví dụ: hiển thị một vòng tròn tiến trình)
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh mục sản phẩm'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20,),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Số cột
              crossAxisSpacing: 20, // Khoảng cách ngang giữa các cột
              mainAxisSpacing: 30, // Khoảng cách dọc giữa các hàng
            ),
            itemCount: listProductCategory.length,
            // Số lượng phần tử trong danh sách
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(0),
                width: 160,
                height: 160,
                decoration: ShapeDecoration(
                  color: Color(0xFFFF8552),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigate to the settings page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(id: "${listProductCategory[index].id}"),
                          ),
                        );
                      },
                      child: Container(
                        width: 160,
                        height: 125,
                        decoration: const BoxDecoration(color: Color(0xFFFF8552)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 160,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(listProductCategory[index].image),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0), // Add padding to align text 30px left
                              child: Text(
                                listProductCategory[index].productName.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Align content to the start (left)
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0), // Add padding to align text 10px left
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${formatCurrency(listProductCategory[index].price)} ₫',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
