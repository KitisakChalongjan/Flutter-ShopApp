import 'package:flutter/material.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/user_product_item.dart';
import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  //const UserProductScreen({ Key? key }) : super(key: key);
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async{
    await Provider.of<Products>(context, listen: false).fetchAndSetproducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              itemBuilder: (_, i) => Column(
                    children: [
                      UserProductItem(
                        productData.items[i].id,
                        productData.items[i].title,
                        productData.items[i].imageUrl,
                      ),
                      Divider(),
                    ],
                  ),
              itemCount: productData.items.length),
        ),
      ),
    );
  }
}
