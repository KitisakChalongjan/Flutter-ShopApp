import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_product_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  //const UserProductItem({ Key? key }) : super(key: key);
  final String id;
  final String title;
  final String imageUrl;
  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: id);
            },
            icon: Icon(
              Icons.edit,
            ),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: () async {
              try {
                await Provider.of<Products>(context, listen: false)
                    .deleteProduct(id);
              } catch (error) {
                scaffold.showSnackBar(
                  SnackBar(
                    content: Text(
                      'Deleting Failed!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
            icon: Icon(
              Icons.delete,
            ),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
