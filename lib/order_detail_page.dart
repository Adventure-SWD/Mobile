import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metrofood/Model/order_detail.dart';
import 'package:metrofood/api/baseclient.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderDetailPage extends StatefulWidget {
  final String id;
  const OrderDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State createState() {
    return _OrderDetailPageState();
  }
}
class _OrderDetailPageState extends State<OrderDetailPage> {
  late Future<List<OrderDetail>> futureOrderDetail;
  late List<OrderDetail> listOrderDetails = [];


  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    futureOrderDetail = BaseClient().fetchOrderDetailByOrderId(widget.id);
    await futureOrderDetail.then((value) {
      setState(() {
        listOrderDetails = value.toList();
      });
    });
  }

  String formatCurrency(int value) {
    final format = NumberFormat("#,###");
    return format.format(value);
  }

  @override
  Widget build(BuildContext context) {
    if(listOrderDetails == null || listOrderDetails.isEmpty) {
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
      appBar: AppBar(
        title: Text('Chi tiết giao dịch'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10,),
                Text('Mã qr Đơn hàng'),
                SizedBox(height: 10,),
                QrImageView(
                  data: '${listOrderDetails[0].orderData.orderTokenQr}',
                  version: QrVersions.auto,
                  size: 150,
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
              child: ListView.builder(
                itemCount: listOrderDetails.length,
                itemBuilder: (context, index) {
                  final product = listOrderDetails[index].productData;
                  return ListTile(
                    leading: Image.network(product.image),
                    title: Text(product.productName),
                    subtitle: Text(
                        '\$${formatCurrency(listOrderDetails[index].price)} ₫'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Số lượng : ${listOrderDetails[index].quanity.toString()}'),
                      ],
                    ),
                  );
                },
              ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(),
            Text(
              'Tổng tiền: \$${formatCurrency(listOrderDetails[0].orderData.totalPrice)} ₫',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}