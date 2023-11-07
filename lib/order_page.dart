import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metrofood/Model/order.dart';
import 'package:metrofood/api/baseclient.dart';
import 'package:metrofood/order_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import Orders class and ordersFromJson function here

class TransactionHistoryPage extends StatefulWidget {
  static const routeName = '/order-page';
  const TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  late Future<List<Orders>> futureOrder;
  late List<Orders> ordersList = [];
  late String userId;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId')!;
    BaseClient().fetchOrderByUserId(userId).then((value) {
      setState(() {
        ordersList = value.toList();
      });
    });
  }

  String formatCurrency(int value) {
    final format = NumberFormat("#,###");
    return format.format(value);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử giao dịch'),
      ),
      body: ListView.builder(
        itemCount: ordersList.length,
        itemBuilder: (context, index) {
          final order = ordersList[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Mã đơn hàng: ${order.orderTokenQr}'),
              subtitle: Text('Tổng giá: ${formatCurrency(order.totalPrice)} ₫'),
              trailing: Text('Trạng thái: ${order.orderStatus}'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailPage(id: "${order.orderId}")));
              },
            ),
          );
        },
      ),
    );
  }
}
