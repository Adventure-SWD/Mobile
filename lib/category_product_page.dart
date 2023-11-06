import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
    startImageSlider();
    super.initState();
  }

  Future<void> initializeData() async {
    futureProduct = BaseClient().fetchProductByCateId(widget.categoryId);
    await futureProduct.then((value) {
      setState(() {
        listProduct = value.toList();
      });
    });

    /*futureProductCategory = BaseClient().fetchProductByCateId(widget.id);
    futureProductCategory.then((value) {
      setState(() {
        listProductCategory = value.map((e) => e.categoryId).cast<Products>().toList();
      });
    });*/
  }

  void startImageSlider() {
    const duration = Duration(seconds: 2);

    Timer.periodic(duration, (Timer timer) {
      if (currentImageIndex < imageUrls.length - 1) {
        currentImageIndex++;
      } else {
        currentImageIndex = 0;
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(listProduct == null || listProduct.isEmpty) {
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
      //appBar: CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 40,),
          const Text(
            'Popular',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w300,
              height: 0,
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigate to the settings page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(id: "${listProduct[0].id}"),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(color: Color(0xFFFF8552)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(listProduct[0].image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              '${listProduct[0].price.toString()} VND',
                              style: TextStyle(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        listProduct[0].productName.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigate to the settings page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ProductDetailPage(id: "${listProduct[1].id}"),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(color: Color(0xFFFF8552)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(listProduct[1].image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              '${listProduct[1].price.toString()} VND',
                              style: TextStyle(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        listProduct[1].productName.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigate to the settings page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(id: "${listProduct[2].id}"),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(color: Color(0xFFFF8552)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(listProduct[2].image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              '${listProduct[2].price.toString()} VND',
                              style: TextStyle(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        listProduct[2].productName.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigate to the settings page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ProductDetailPage(id: "${listProduct[3].id}"),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(color: Color(0xFFFF8552)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(listProduct[3].image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              '${listProduct[3].price.toString()} VND',
                              style: TextStyle(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        listProduct[3].productName.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigate to the settings page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ProductDetailPage(id: "${listProduct[4].id}"),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(color: Color(0xFFFF8552)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(listProduct[4].image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              '${listProduct[4].price.toString()} VND',
                              style: TextStyle(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        listProduct[4].productName.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigate to the settings page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ProductDetailPage(id: "${listProduct[5].id}"),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(color: Color(0xFFFF8552)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(listProduct[5].image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              '${listProduct[5].price.toString()} VND',
                              style: TextStyle(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        listProduct[5].productName.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
