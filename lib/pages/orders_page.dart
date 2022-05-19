import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/componets/app_drawer.dart';
import 'package:shop/componets/order_widget.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // ignore: prefer_const_constructors
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(
              child: Text('Ocooreu um erro no Servidor'),
            );
          } else {
            return Consumer<OrderList>(
              builder: (BuildContext ctx, orders, child) => ListView.builder(
                itemCount: orders?.itmsCount,
                itemBuilder: (ctx, i) => OrderWidget(
                  order: orders.items[i],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
