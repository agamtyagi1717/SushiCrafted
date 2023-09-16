import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_restaurant/components/button.dart';
import 'package:sushi_restaurant/models/food.dart';
import 'package:sushi_restaurant/models/shop.dart';
import 'package:sushi_restaurant/themes/colors.dart';
import 'package:provider/provider.dart';

class FoodDetailsPage extends StatefulWidget {
  final Food food;
  const FoodDetailsPage({super.key, required this.food});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  int quantityCount = 0;

  void decrementQuantity() {
    setState(() {
      if (quantityCount > 0) quantityCount--;
    });
  }

  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  //add to cart
  void addtoCart() {
    // only add to cart if theres someting in the cart
    if (quantityCount > 0) {
      //get access to shop
      final shop = context.read<Shop>();

      //add to cart
      shop.addToCart(widget.food, quantityCount);

      // let the user know success
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: primaryColor,
                content: const Text(
                  'Successfully added to cart',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        //pop once to remove dialogue box
                        Navigator.pop(context);
                        // pop again to go to prev screen
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.done,
                        color: Colors.white,
                      ))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          // listview of food details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                children: [
                  //image
                  Image.asset(
                    widget.food.imagePath,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // rating
                  Row(
                    children: [
                      //star
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),
                      const SizedBox(width: 10),
                      //rating
                      Text(
                        widget.food.rating,
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),

                  // food name
                  Text(
                    widget.food.name,
                    style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                  ),

                  const SizedBox(height: 25),

                  // description
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    "Sushi, a culinary masterpiece that transcends taste. Discover the art of Japanese cuisine with our handcrafted sushi creations. Delight in the perfect harmony of vinegared rice, fresh seafood, and vibrant vegetables. From the iconic California roll to delicate nigiri, our sushi is a symphony of flavors and textures. Elevate your dining experience with each bite. Savor sushi, where simplicity meets sophistication.",
                    style: TextStyle(color: Colors.grey[600], height: 2),
                  )
                ],
              ),
            ),
          ),

          Container(
            color: primaryColor,
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                //price+quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //price
                    Text(
                      '\$' + widget.food.price,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),

                    //quantity
                    Row(
                      children: [
                        //minus
                        Container(
                          decoration: BoxDecoration(
                              color: secondaryColor, shape: BoxShape.circle),
                          child: IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            onPressed: decrementQuantity,
                          ),
                        ),

                        //count
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(quantityCount.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                        ),

                        //plus
                        Container(
                          decoration: BoxDecoration(
                              color: secondaryColor, shape: BoxShape.circle),
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: incrementQuantity,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 25),

                // add to cart button
                MyButton(text: "Add to Cart", onTap: addtoCart)
              ],
            ),
          )
        ],
      ),
    );
  }
}
