import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceryapp/pages/home_page.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Mi carrito",
                  style: GoogleFonts.montserrat(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: value.cartItems.length,
                    padding: EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            leading: Image.asset(
                              value.cartItems[index][2],
                              height: 36,
                            ),
                            title: Text(
                              value.cartItems[index][0],
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              '\$' + value.cartItems[index][1],
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () => _showMaterialDialog(
                                  context, index, value.cartItems[index][0]),
                              // Provider.of<CartModel>(context, listen: false)
                              //     .removeItemFromCart(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Precio Total',
                            style: TextStyle(color: Colors.green[200]),
                          ),

                          const SizedBox(height: 8),
                          // total price
                          Text(
                            '\$${value.calculateTotal()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade200),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            MaterialButton(
                              onPressed: () =>
                                _showConfirmationDialog(context),
                                child: Text(
                                  'Comprar Ahora',
                                  style: TextStyle(
                                  color: Colors.white,
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

void _showMaterialDialog(BuildContext context, index, name) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar del carrito'),
          content: Text('Estas seguro de eliminar $name del carrito?'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar')),
            TextButton(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false)
                    .removeItemFromCart(index);
                Navigator.pop(context);
              },
              child: Text('Aceptar'),
            )
          ],
        );
      });
}

void _showConfirmationDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Comfirmar Compra'),
          content: const Text(
              '¿Está seguro de confirmar la compra? \n\nLos artículos serán enviados a su domicilio!', textAlign: TextAlign.justify,),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar')),
            TextButton(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false)
                .removeAllItems();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ),
                );
                _showDialog(context);
              },
              child: Text('Aceptar'),
            )
          ],
        );
      });
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("¡Compra Completada!"),
        content: const Text("Gracias por su compra, pronto recibirá sus produtos."),
        actions: <Widget>[
          MaterialButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}