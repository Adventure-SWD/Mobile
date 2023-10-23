import 'package:flutter/material.dart';
import 'package:metrofood/cart_page.dart';

class ProductDetailPage extends StatelessWidget {
  final int heroTag;

  const ProductDetailPage({Key? key, required this.heroTag}) : super(key: key);

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(_images[heroTag]),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Content goes here",
              style: Theme.of(context).textTheme.headline5,
            ),
          )
        ],
      ),
    );*/

  @override
  Widget build(BuildContext context) {
    final product = _images[heroTag];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
                child: Hero(
                  tag: heroTag,
                  child: Image.network(_images[heroTag]),
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
                      _product[heroTag],
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Giá bán: ${_price[heroTag]}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _description[heroTag],
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartPage(),
                              ),
                            );
                          },
                          child: const Text("Thêm vào giỏ hàng"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartPage(),
                              ),
                            );
                          },
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
    );
  }
}

final List<String> _images = [
  'https://th.bing.com/th/id/R.602cb9cd48da72f879ac18ea1c945f6e?rik=YU956u%2b9jFHGVA&pid=ImgRaw&r=0',
  'https://cdn.tgdd.vn/Files/2020/08/19/1281398/cach-lam-khoai-tay-chien-trong-10-phut-voi-noi-chien-khong-dau-khoai-gion-de-lau-cung-khong-mem-202008191207088100.jpg',
  'https://banhmihanoi.net/wp-content/uploads/2020/05/banh-mi-pate-2.jpg',
  'https://th.bing.com/th/id/R.77b7a8dc14339b022b9adf648b7b2ce6?rik=3jI6i6z7G3St9A&pid=ImgRaw&r=0',
  'https://beverages2u.com/wp-content/uploads/2019/05/0001200010010_B-1024x1024.jpg',
  'https://th.bing.com/th/id/OIP.7E2w-tUiWknbqZLS_awCMAHaE4?pid=ImgDet&rs=1'
];

final List<String> _product = [
  'Cơm chiên',
  'Khoai tây chiên',
  'Bánh mỳ',
  'Cocacola',
  'Pepsi',
  'Cà phê'
];

final List<String> _price = [
  '30,000',
  '15,000',
  '25,000',
  '10,000',
  '10,000',
  '15,000'
];

final List<String> _description = [
  'Cơm gà chiên nóng hổi vừa thồi vừa ăn',
  'Khoai tây chiên rắc muối giòn tan',
  'Bánh mỳ với nhiều loại nhân khác nhau',
  'Nước ngọt có ga Cocacola',
  'Nước ngọt có ga Pepsi',
  'Cà phê sữa đá'
];