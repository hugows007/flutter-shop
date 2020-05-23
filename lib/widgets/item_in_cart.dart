import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/providers/cart_items.dart';

class ItemInCart extends StatelessWidget {
  final Cart cartItem;

  ItemInCart(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Tem certeza?'),
              content: Text('Quer remover o item do carrinho?'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Sim'),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Não'),
                ),
              ],
            ));
      },
      onDismissed: (_) {
        Provider.of<CartItems>(context, listen: false)
            .removeItem(cartItem.productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('${cartItem.price}'),
                ),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text(
                'Total: R\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
            trailing: Text('${cartItem.quantity}x'),
          ),
        ),
      ),
    );
  }
}
