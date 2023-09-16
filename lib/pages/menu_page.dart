import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sushi_restaurant/components/button.dart';
import 'package:sushi_restaurant/components/food_tile.dart';
import 'package:sushi_restaurant/models/shop.dart';
import 'package:sushi_restaurant/pages/food_details.dart';
import 'package:sushi_restaurant/themes/colors.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  //food menu

  void navigateToFoodDetails(int index) {
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsPage(
          food: foodMenu[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: Colors.grey[900],
        ),
        title: Text(
          "Delhi",
          style: TextStyle(color: Colors.grey[900]),
        ),
        centerTitle: true,
        actions: [
          //cart button
          IconButton(
              onPressed: () => {Navigator.pushNamed(context, '/cartpage')},
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.grey[900],
              ))
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //promo banner
        Container(
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          padding: const EdgeInsets.all(25),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              children: [
                Text(
                  'Get 32% off',
                  style: GoogleFonts.dmSerifDisplay(
                      fontSize: 20, color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(text: "Redeem", onTap: () {}),
              ],
            ),
            Image.asset(
              'lib/assets/sushi.png',
              height: 100,
            ),
          ]),
        ),

        const SizedBox(height: 25),
        // search bar

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search here...",
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),

        const SizedBox(height: 25),

        // menu list
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            "Food menu",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey[800]),
          ),
        ),

        const SizedBox(height: 10),

        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: foodMenu.length,
            itemBuilder: (context, index) => FoodTile(
              food: foodMenu[index],
              onTap: () => navigateToFoodDetails(index),
            ),
          ),
        ),

        const SizedBox(height: 25),

        // popular food
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
          padding: const EdgeInsets.all(20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // image
            Row(
              children: [
                Image.asset(
                  'lib/assets/sushi1.png',
                  height: 60,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // name
                    Text(
                      "Sushi Box",
                      style: GoogleFonts.dmSerifDisplay(fontSize: 18),
                    ),
                    const SizedBox(height: 10),

                    // price
                    Text(
                      '\$28.00',
                      style: TextStyle(color: Colors.grey[700]),
                    )
                  ],
                ),
              ],
            ),

            //heart
            Icon(
              Icons.favorite_outline,
              color: Colors.grey,
              size: 29,
            ),
          ]),
        ),
      ]),
    );
  }
}
