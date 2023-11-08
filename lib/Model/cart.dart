import 'package:flutter/material.dart';
import 'package:metrofood/Model/menu_product.dart';
import 'package:metrofood/Model/menu_product_new.dart';
import 'package:metrofood/Model/products.dart';

class Cart {
  List<MenuProductDatum> items = [];
}
class CartProvider extends ChangeNotifier {
  Cart _cart = Cart();

  Cart get cart => _cart;

  void addToCart(MenuProductDatum product) {
    final existingProduct = _cart.items.firstWhere((item) => item.productId == product.productId, orElse: () {
      return MenuProductDatum.empty();
    });
    if (existingProduct.productId != 'default') {
      updateQuantity(existingProduct, existingProduct.quantity + 1);
    } else {
      product.quantity = 1;
      _cart.items.add(product);
      notifyListeners();
    }
  }

  void removeFromCart(MenuProductDatum product) {
    _cart.items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cart.items.clear();
    notifyListeners();
  }

  void updateQuantity(MenuProductDatum product, int newQuantity) {
    final cartItem = _cart.items.firstWhere((item) => item.id == product.id, orElse: () {
      return MenuProductDatum.empty();
    });
    if (cartItem != null) {
      cartItem.quantity = newQuantity;
      notifyListeners();
    }
  }

  double getTotalPrice() {
    double totalPrice = 0.0;
    for (MenuProductDatum product in _cart.items) {
      totalPrice += product.priceOfProductBelongToTimeService * product.quantity;
    }
    return totalPrice;
  }

// Các phương thức khác
}

