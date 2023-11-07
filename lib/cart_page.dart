import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrofood/Model/cart.dart';
import 'package:metrofood/api/baseclient.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/cart-page';
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalPrice = 0.0;
  String? userId = "";
  String? tripId = "";
  String? storeId = "";

  @override
  void initState() {
    super.initState();
    getInformation();
  }

  void getInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    tripId = prefs.getString('tripId');
    storeId = prefs.getString('storeId');
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    final cart = cartProvider.cart;
    totalPrice = cartProvider.getTotalPrice();
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
      ),
      body: ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final product = cart.items[index];
          return ListTile(
            leading: Image.network(product.productData.image),
            title: Text(product.productData.productName),
            subtitle: Text(
                '\$${product.priceOfProductBelongToTimeService.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (product.quantity > 1) {
                      cartProvider.updateQuantity(
                          product, product.quantity - 1);
                      setState(() {});
                    }
                  },
                ),
                Text(product.quantity.toString()),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    cartProvider.updateQuantity(product, product.quantity + 1);
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(
                      Icons.delete), // Sử dụng biểu tượng hoặc hình ảnh tùy ý
                  onPressed: () {
                    if (cart.items.length == 1) {
                      cartProvider.removeFromCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Giỏ hàng của bạn đang trống'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                    cartProvider.removeFromCart(product);
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(),
            Text(
              'Tổng giá tiền: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () async {
                if (cart.items.length == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Giỏ hàng của bạn đang trống'),
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  getInformation();
                  final response = BaseClient().createOrder(
                      applicationUserID: userId!,
                      tripId: tripId!,
                      storeId: storeId!,
                      products: cart.items.toList());
                  response.then((value) {
                    if (value.statusCode == 200) {
                      // Xử lý kết quả thành công
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Đã tạo đơn hàng thành công'),
                        ),
                      );
                      cartProvider.clearCart();
                      Navigator.pop(context);
                    } else if (value.statusCode == 400) {
                      // Xử lý lỗi hoặc trạng thái khác
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Tài khoản không đủ để đặt hàng, vui lòng nạp thêm!'),
                        ),
                      );
                      cartProvider.clearCart();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Gặp lỗi khi đặt hàng, vui lòng thử lại sau!'),
                        ),
                      );
                      cartProvider.clearCart();
                      Navigator.pop(context);
                    }
                  });
                }
              },
              child: Text('Đặt hàng'),
            ),
          ],
        ),
      ),
    );
  }
}
