// ignore_for_file: deprecated_member_use, unnecessary_new

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';

import 'package:shop/models/product_list.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/utils/app_routes.dart';
import 'pages/cart_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/products_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //criar varios provaider na aplica
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => new OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Shop-Flutter',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        //home: ,
        debugShowCheckedModeBanner: false,
        routes: {
          // AppRoutes.PRODUCT_DETAIL: ((context) => ProductDetailPage()),
          AppRoutes.HOME: ((context) => ProductOverviewPage()),
          AppRoutes.PRODUCT_DETAIL: ((context) => ProductDetailPage()),
          AppRoutes.CART_PAGE: ((context) => CartPage()),
          AppRoutes.ORDERS: ((context) => OrdersPage()),
          AppRoutes.PRODUCTSPAGE: ((context) => ProductsPage()),
          AppRoutes.PRODUCT_FORM_PAGE: ((context) => ProductFormPage()),
        },
      ),
    );
  }
}
