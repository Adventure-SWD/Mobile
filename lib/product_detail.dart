import 'package:flutter/material.dart';
import 'package:metrofood/Model/products.dart';
import 'package:metrofood/api/baseclient.dart';

class ProductDetailPage extends StatefulWidget {
  final String id;
  const ProductDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
    _ProductDetailPageState();
}
class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<List<Products>> futureListProduct;
  late List<String> listProductId;
  late Future<Products> futureProduct;
  late Products product;
  late int imagePos = 0;


  @override
  void initState() {
    initializedData();
    super.initState();
  }

  Future<void> initializedData() async {
    futureListProduct = BaseClient().fetchProduct();
    await futureListProduct.then((value) => {
      setState(() {
        listProductId = value.map((e) => e.id).toList();
      })
    });
    futureProduct = BaseClient().fetchProductById(widget.id);
    await futureProduct.then((value) {
      setState(() {
        product = value;
      });
    });
    for(int i = 0 ; i <= listProductId.length ; i++) {
      if(product.id == listProductId[i]) {
        imagePos = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if(product == null) {
      return Center();
    }
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.white,
                  child: Hero(
                    tag: 0,
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.categoryData.categoryName,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.productName,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Giá bán: ${product.price} VND",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.productDescription,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Thêm vào giỏ hàng"),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Mua ngay"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Các phần khác như phần "Sản phẩm liên quan", phần "Câu hỏi thường gặp", v.v.
              ]),
            ),
          ],
        ),
      ),
    );
  }
}


final List<String> _images = [
  'https://kenh14cdn.com/2018/1/25/14-15168854449721199424947.jpg',
  'https://cdn.tgdd.vn/Files/2020/08/19/1281398/cach-lam-khoai-tay-chien-trong-10-phut-voi-noi-chien-khong-dau-khoai-gion-de-lau-cung-khong-mem-202008191207088100.jpg',
  'https://banhmihanoi.net/wp-content/uploads/2020/05/banh-mi-pate-2.jpg',
  'https://th.bing.com/th/id/R.77b7a8dc14339b022b9adf648b7b2ce6?rik=3jI6i6z7G3St9A&pid=ImgRaw&r=0',
  'https://beverages2u.com/wp-content/uploads/2019/05/0001200010010_B-1024x1024.jpg',
  'https://th.bing.com/th/id/OIP.7E2w-tUiWknbqZLS_awCMAHaE4?pid=ImgDet&rs=1'
];