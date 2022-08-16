import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  //const OrdersScreen({ Key? key }) : super(key: key);
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _orderFuture;

  Future _obtainOrderFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _orderFuture = _obtainOrderFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final ordersData = Provider.of<Orders>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: _orderFuture,
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                //Error Handling
                return Center(child: Text('An Error Occured!'));
              } else {
                return Consumer<Orders>(
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                  ),
                );
              }
            }
          },
        ));
  }
}
