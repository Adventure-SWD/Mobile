import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrofood/app_bar.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/cart-page';
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            'My Cart',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          Container(
            width: 360,
            height: 257,
            decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
          ),
          Text(
            'Recommend for you',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          Container(
            width: 271,
            height: 55,
            decoration: ShapeDecoration(
              color: Color(0xFFD9D9D9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Buy Now',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

