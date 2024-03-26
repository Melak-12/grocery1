// import 'dart:js_interop';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:grocery1/pages/cart_page.dart' show CartPage;
import 'package:grocery1/pages/item_detail.dart' show ItemDetail;
import 'package:grocery1/pages/my_cart.dart' show MyCart;
import 'package:grocery1/pages/profile.dart';
import 'package:grocery1/pages/sidemenu.dart' show SideMenu;
import 'package:grocery1/providers/main_parent_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int size = 0;
  int cartItemSize = 0;
  List<String> items = [];
  List<String> cartItems = [];

  late SharedPreferences prefs;
  late SharedPreferences prefs2;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    sharedPref();
  }

  void sharedPref() async {
    prefs = await SharedPreferences.getInstance();
    prefs2 = await SharedPreferences.getInstance();
    items = prefs.getStringList("items") ?? [];
    cartItems = prefs.getStringList("cartItems") ?? [];

    setState(
      () {
        size = items.length;
        cartItemSize = cartItems.length;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainModel = Provider.of<MainModel>(context);
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 55, 66, 67),
        foregroundColor: Colors.white,
        title: Text(
          'Grocery  ',
          style: GoogleFonts.fahkwang(
              textStyle: const TextStyle(
                  fontSize: 15, color: Colors.white, letterSpacing: 3)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const MyCart();
                  },
                ),
              );
            },
            // icon: Icon(Icons.home),
            icon: badges.Badge(
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.red,
              ),
              badgeAnimation: const badges.BadgeAnimation.scale(
                animationDuration: Duration(seconds: 4),
                colorChangeAnimationDuration: Duration(seconds: 6),
                loopAnimation: true,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              badgeContent: cartItemSize > 0
                  ? Text(
                      cartItemSize.toString(),
                      style: const TextStyle(color: Colors.white),
                    )
                  : const Text("0"),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const Profile();
                },
              ));
            },
            child: Image(image: AssetImage('lib/images/burger1.png')),

            // child: Hero(
            //   tag: "profile image",
            //   child: Padding(
            //     padding: const EdgeInsets.all(11.0),
            //     child: FutureBuilder<String>(
            //       future: mainModel.proImage(),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return const CircularProgressIndicator();
            //         } else {
            //           final imagePath = snapshot.data!;
            //           return ClipOval(
            //             child: Image.file(
            //               File(imagePath),
            //               fit: BoxFit
            //                   .cover, // Ensure the image fills the circular clip
            //               width: 40, // Adjust the width as needed
            //               height:
            //                   40, // Set the height to match the width for a perfect circle
            //             ),
            //           );
            //         }
            //       },
            //     ),
            //   ),
            // ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    mainModel.getGreeting(),
                    style: GoogleFonts.sacramento(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 134, 163, 154),
                        fontSize: 20,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 11.0,
                  left: 11,
                ),
                child: Text(
                  "Let's order fresh items for you !",
                  style: GoogleFonts.fahkwang(
                    textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 122, 139, 155),
                      fontFamily: "Raleway",
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(1.0),
                child: Divider(),
              ),
              Expanded(
                child: size < 1
                    ? const Text("no data")
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: size,
                        itemBuilder: (context, index) {
                          final itemId = items[index];
                          final itemName =
                              prefs.getString("$itemId\$_name") ?? "no name";
                          final itemPrice =
                              prefs.getInt("$itemId\$_price") ?? 0;
                          final itemDisc =
                              prefs.getString("$itemId\$_disc") ?? "no disc";

                          final imagePath =
                              prefs.getString("$itemId\$_image_path");
                          // final profilePath =
                          //     prefs.getString("$itemId\$_profile_path");

                          return TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemDetail(
                                    itemName: itemName,
                                    itemId: itemId,
                                    itemPrice: itemPrice,
                                    itemDisc: itemDisc,
                                    itemImage: imagePath!,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              shadowColor:
                                  const Color.fromARGB(255, 202, 199, 199),
                              margin: const EdgeInsets.all(6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (imagePath != null)
                                      Image.file(
                                        File(imagePath),
                                        fit: BoxFit.cover,
                                        height: 96,
                                        width: 80,
                                      )
                                    // else
                                    //   Image.network(
                                    //     'https://media-cdn.tripadvisor.com/media/photo-s/06/ca/7d/be/bar-35-food-drinks.jpg',
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    ,
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          itemName,
                                          style: GoogleFonts.fahkwang(
                                            textStyle: const TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 131, 185, 186),
                                            ),
                                          ),
                                        ),
                                        const Spacer(
                                          flex: 1,
                                        ),
                                        Text(
                                          '$itemPrice\$',
                                          style: GoogleFonts.zillaSlab(
                                            textStyle: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 240, 124, 61),
                                                fontSize: 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          liked = !liked;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.favorite,
                                              size: 18,
                                              color: liked
                                                  ? const Color.fromARGB(
                                                      255, 255, 0, 0)
                                                  : Colors.grey.shade500),
                                          const SizedBox(
                                            width: 22,
                                          ),
                                          const Icon(
                                            Icons.share,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartPage()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 48, 162, 123),
        child: const Icon(Icons.add_shopping_cart),
      ),
      drawer: const SideMenu(),
    );
  }
}
