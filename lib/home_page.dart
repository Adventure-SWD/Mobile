import 'package:flutter/material.dart';
import 'package:metrofood/Model/category.dart';
import 'package:metrofood/Model/products.dart';
import 'package:metrofood/api/baseclient.dart';
import 'package:metrofood/category_product_page.dart';
import 'dart:async';

import 'package:metrofood/product_detail.dart';


class HomePage extends StatefulWidget {
  static const routeName = '/home-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // test cate
  late Future<List<Categories>> futureCategory;
  late List<Categories> listCategory = [];


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
    futureProduct = BaseClient().fetchProduct();
    await futureProduct.then((value) {
      setState(() {
        listProduct = value.toList();
      });
    });

    futureCategory = BaseClient().fetchCategory();
    await futureCategory.then((value) {
      setState(() {
        listCategory = value.toList();
      });
    });
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
          Container(
            width: 288,
            height: 127,
            decoration: ShapeDecoration(
              color: const Color(0xFFFF8552),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: ClipRRect (
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrls[currentImageIndex],
                fit: BoxFit.cover,
              ),
            )
          ),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/categories-page');
                },
                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  // Navigate to the settings page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProductPage(categoryId: "${listCategory[6].id}"),
                    ),
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFFF8552),
                    shape: OvalBorder(),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lunch_dining,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(height: 5), // Add a spacer between icon and text
                      Text(
                        'Bread',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigate to the settings page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProductPage(categoryId: "${listCategory[5].id}"),
                    ),
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFFF8552),
                    shape: OvalBorder(),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.icecream,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(height: 5), // Add a spacer between icon and text
                      Text(
                        'Candy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigate to the settings page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProductPage(categoryId: "${listCategory[1].id}"),
                    ),
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFFF8552),
                    shape: OvalBorder(),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.food_bank,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(height: 5), // Add a spacer between icon and text
                      Text(
                        'Food',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigate to the settings page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProductPage(categoryId: "${listCategory[4].id}"),
                    ),
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFFF8552),
                    shape: OvalBorder(),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.liquor,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(height: 5), // Add a spacer between icon and text
                      Text(
                        'Drinks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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

          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Số cột
              crossAxisSpacing: 20, // Khoảng cách ngang giữa các cột
              mainAxisSpacing: 30, // Khoảng cách dọc giữa các hàng
            ),
            itemCount: 6,
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
                            builder: (context) => ProductDetailPage(id: "${listProduct[index].id}"),
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
                                  image: NetworkImage(listProduct[index].image),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0), // Add padding to align text 30px left
                              child: Text(
                                listProduct[index].productName.toString(),
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
                      mainAxisAlignment: MainAxisAlignment.center, // Align content to the start (left)
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0), // Add padding to align text 10px left
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${listProduct[index].price.toString()} VND',
                              style: TextStyle(
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

