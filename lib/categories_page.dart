import 'package:flutter/material.dart';
import 'package:metrofood/Model/category.dart';
import 'package:metrofood/app_bar.dart';
import 'package:metrofood/api/baseclient.dart';
import 'package:metrofood/category_product_page.dart';

class CategoriesPage extends StatefulWidget{
  static const routeName = '/categories-page';
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}
class _CategoriesPageState extends State<CategoriesPage> {
  late Future<List<Categories>> futureCategory;
  List<String> listCategory = [];
  List<String> listCategoryId = [];

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

    futureCategory.then((value) {
      setState(() {
        listCategoryId = value.map((e) => e.id).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listCategory == null || listCategory.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Danh mục sản phẩm'),
        ),
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
      appBar: const CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 5),
          SingleChildScrollView(
            child: Container (
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
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
                    color: Color(0xFFFF8552),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: InkWell( // Wrap the Column in InkWell
                    onTap: () {
                      // Navigate to the settings page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryProductPage(categoryId: "${listCategoryId[index]}"),
                        ),
                      );
                    },
                    child: Column( // Ensure the Column is the child of InkWell
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFE6E6E6),
                              shape: OvalBorder(),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.lunch_dining_sharp,
                                color: Colors.black,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          listCategory[index], // Sử dụng dữ liệu từ danh sách
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        )
                      ],
                    ),
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