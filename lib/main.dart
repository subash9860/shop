import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Screen/product_overview_screen.dart';

import '../Screen/auth_screen.dart';
import '../Screen/edit_product_screen.dart';
import '../providers/auth.dart';
import './Screen/users_products_screen.dart';
import '../Screen/order_screen.dart';
import '../providers/orders.dart';
import '../Screen/cart_screen.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import '../Screen/product_detail_screen.dart';
// import '../Screen/product_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (create) => Products('', '', []),
            update: (ctx, auth, previousProducts) => Products(
                auth.token!,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
          ),
          // ChangeNotifierProvider(create: (ctx) => Products()),
          ChangeNotifierProvider(create: (ctx) => Cart()),

          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (create) => Orders('', '', []),
            update: (ctx, auth, previousProducts) => Orders(
                auth.token!,
                auth.userId,
                previousProducts == null ? [] : previousProducts.orders),
          ),
          // ChangeNotifierProvider(create: (ctx) => Orders()),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                  .copyWith(secondary: Colors.deepOrange),
              fontFamily: 'Lato',
            ),
            home: auth.isAuth!
                ? const ProductsOverviewScreen()
                : const AuthScreen(),
            // const ProductsOverviewScreen(),
            routes: {
              ProductDetailScreen.routeName: (ctx) =>
                  const ProductDetailScreen(),
              CartScreen.routeName: (ctx) => const CartScreen(),
              OrderScreen.routeName: (ctx) => const OrderScreen(),
              UserProductScreen.routeName: (ctx) => const UserProductScreen(),
              EditProductScreen.routeName: (ctx) => const EditProductScreen(),
            },
          ),
        )
        // ChangeNotifierProvider(
        //   create: (ctx) => Products(),
        //   child:

        );
  }
}
