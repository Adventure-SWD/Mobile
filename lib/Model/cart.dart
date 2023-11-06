import 'package:flutter/material.dart';
import 'package:metrofood/Model/products.dart';

class Cart {
  List<Products> items = [];
}
class CartProvider extends ChangeNotifier {
  Cart _cart = Cart();

  Cart get cart => _cart;

  void addToCart(Products product) {
    final existingProduct = _cart.items.firstWhere((item) => item.id == product.id, orElse: () {
      return Products(
        id: 'default', // Thay 'default' bằng giá trị mặc định thích hợp
        categoryId: 'default',
        productName: 'default',
        productDescription: 'default',
        image: 'default',
        price: 0.0,
        categoryData: CategoryData(
          categoryName: 'default',
          created: DateTime.now(),
          createBy: 'default',
          lastModified: 'default',
          lastModifiedBy: 'default',
          isDelete: false,
          id: 'default',
          domainEvents: [],
        ),
        quantity: 0, // Số lượng mặc định
      );
    });
    if (existingProduct.id != 'default') {
      // Sản phẩm đã tồn tại trong giỏ hàng, cập nhật số lượng
      updateQuantity(existingProduct, existingProduct.quantity + 1);
    } else {
      // Sản phẩm chưa tồn tại trong giỏ hàng, thêm sản phẩm mới
      product.quantity = 1; // Đặt số lượng mặc định là 1
      _cart.items.add(product);
      notifyListeners();
    }
  }
  void removeFromCart(Products product) {
    _cart.items.remove(product);
    notifyListeners();
  }
  void updateQuantity(Products product, int newQuantity) {
    final cartItem = _cart.items.firstWhere((item) => item.id == product.id, orElse: () {
      return Products(
        id: 'default', // Thay 'default' bằng giá trị mặc định thích hợp
        categoryId: 'default',
        productName: 'default',
        productDescription: 'default',
        image: 'default',
        price: 0.0,
        categoryData: CategoryData(
          categoryName: 'default',
          created: DateTime.now(),
          createBy: 'default',
          lastModified: 'default',
          lastModifiedBy: 'default',
          isDelete: false,
          id: 'default',
          domainEvents: [],
        ),
        quantity: 0, // Số lượng mặc định
      );
    });
    if (cartItem != null) {
      cartItem.quantity = newQuantity;
      notifyListeners();
    }
  }
  double getTotalPrice() {
    double totalPrice = 0.0;
    for (Products product in _cart.items) {
      totalPrice += product.price;
    }
    return totalPrice;
  }

// Thêm các phương thức khác để thao tác với giỏ hàng (xóa sản phẩm, tính tổng giá trị, v.v.)
}
