import 'package:flutter/material.dart';
import 'package:metrofood/Model/category.dart';
import 'package:metrofood/app_bar.dart';
import 'package:metrofood/baseclient.dart';

class CategoriesPage extends StatefulWidget{
  static const routeName = '/categories-page';
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}
class _CategoriesPageState extends State<CategoriesPage> {
  late Future<List<Categories>> futureCategory;
  List<String> listCategory = [];

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  Future<void> initializeData() async {
    futureCategory = BaseClient().fetchCategory();
    futureCategory.then((value) {
      setState(() {
        listCategory = value.map((e) => e.categoryName).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listCategory == null || listCategory.isEmpty) {
      return Center(
      );
    }
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            width: 331,
            height: 63,
            decoration: ShapeDecoration(
              color: const Color(0xFFD9D9D9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 5),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ben Thanh',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    Text(
                      '9h15',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform(
                      transform: Matrix4.identity()..translate(0.0, 0.0),
                      child: Container(
                        width: 52,
                        height: 20,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("https://via.placeholder.com/52x20"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Suoi Tien',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    Text(
                      '9h45',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
          const SizedBox(height: 40),
          SingleChildScrollView(
            child: Container (
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Số cột
                crossAxisSpacing: 16, // Khoảng cách ngang giữa các cột
                mainAxisSpacing: 16, // Khoảng cách dọc giữa các hàng
              ),
              itemCount: listCategory.length, // Số lượng phần tử trong danh sách
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  width: 150,
                  height: 150,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const ShapeDecoration(
                            color: Colors.black,
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Text(
                        listCategory[index], // Sử dụng dữ liệu từ danh sách
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          ),
        ],
      ),
    );
  }
}