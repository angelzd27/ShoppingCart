import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/grocery_item_tile.dart';
import '../model/cart_model.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Icon(
            Icons.home,
            color: Colors.grey[700],
          ),
        ),
        title: Text(
          'Bienvenido!',
          style: TextStyle(
            fontSize: 26,
            color: Colors.grey[700],
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CartPage();
            },
          ),
        ),
        child: const Icon(Icons.shopping_bag),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              child: Text(grettings(),
                  style: TextStyle(fontSize: 20)),
            ),
            // child: Text(
            //   'Buenas Tardes',
            //   style: TextStyle(fontSize: 20),
            // ),
          ),

          const SizedBox(height: 4),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Tenemos lo mejor para ti",
              style: GoogleFonts.montserrat(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: Text(
              "Productos",
              style: GoogleFonts.montserrat(
                //fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),

          Expanded(
            child: Consumer<CartModel>(
              builder: (context, value, child) {
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: value.shopItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return GroceryItemTile(
                        itemName: value.shopItems[index][0],
                        itemPrice: value.shopItems[index][1],
                        imagePath: value.shopItems[index][2],
                        color: value.shopItems[index][3],
                        onPressed: () =>
                          // Provider.of<CartModel>(context, listen: false)
                          //     .addItemToCart(index),
                          _showMaterialDialog(context, index, value.shopItems[index][0]));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _showMaterialDialog(BuildContext context, index, name) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar al carrito'),
          content: Text('Estas seguro de agregar $name al carrito?'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar')),
            TextButton(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false)
                .addItemToCart(index);
                Navigator.pop(context);
              },
              child: Text('Aceptar'),
            )
          ],
        );
      });
}

String grettings() {
  var hour = DateTime.now().hour;

  if (hour >= 6 && hour <= 12) {
    return 'Buenos días!';
  } else if (hour > 12 && hour < 19) {
    return 'Buenas tardes!';
  } else {
    return 'Buenas noches!';
  }
}
