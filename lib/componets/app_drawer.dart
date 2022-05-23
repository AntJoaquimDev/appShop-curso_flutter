import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/custom_route.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem Vindo User!'),
            automaticallyImplyLeading: false, //retirar icon meno do appbar
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.shop,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Loja'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.AUTH_OR_HOME),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Pedidos'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS),
            // Navigator.of(context).pushReplacement(
            //CustomRoute(builder: (ctx) => OrdersPage()),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.edit,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Gerenciar Produto'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.PRODUCTSPAGE),
          ),
          Divider(),
          ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('Sair'),
              onTap: () {
                Provider.of<Auth>(
                  context,
                  listen: false,
                ).logout();
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.AUTH_OR_HOME,
                );
              }),
        ],
      ),
    );
  }
}
