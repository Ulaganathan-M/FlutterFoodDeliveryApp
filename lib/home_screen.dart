import 'package:flutter/material.dart';
import 'package:loginform/user.dart';
import 'navBar.dart';
import 'package:loginform/colors.dart';
import 'package:loginform/constants.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  HomeScreen({required this.user});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavBar(user: widget.user),
      appBar: AppBar(
        automaticallyImplyLeading: false, // remove back button
        backgroundColor: primaryColor,
        title: Text(
          "Healthy Foods",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // backgroundColor: Colors.transparent,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery to",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                    // style: Theme.of(context).textTheme.subtitle2,
                  ),
                  InkWell(
                    onTap: () {
                      print("clicked");
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Current Location",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: primaryColor,
                          size: 30,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Ink(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        print(widget.user);
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.search),
                          ),
                          Text(
                            "Search Foods",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey.shade800),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                        );
                      },
                    );
                  },
                  icon: Image.asset(
                    FILTER_ICON,
                    height: 24,
                    width: 24,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            titlewidget(context, "Catagory"),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 115,
              child: Container(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listCards.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            print("clicked");
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            margin: EdgeInsets.only(
                                top: 5, bottom: 2, right: 5, left: 8),
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(83, 76, 175, 79),
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(listCards[index].imageUrl),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            listCards[index].title,
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            titlewidget(context, "Popular"),
            for (int i = 0; i < bannerList.length; i++) ...{
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 220,
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage(bannerList[i].imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        bannerList[i].foodName,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        bannerList[i].hotelName,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: primaryColor,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 4,
                                  right: 4,
                                ),
                                child: Text(
                                  bannerList[i].star,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 4,
                                  right: 4,
                                ),
                                child: Text(
                                  "(${bannerList[i].reviewCount} Ratings)",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "\$ ${bannerList[i].price}",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            }
          ],
        ),
      ),
    );
  }
}

@override
Widget titlewidget(BuildContext context, String title) {
  return Text(
    title,
    style: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  );
}

class CatagoryModel {
  late String imageUrl, title;
  CatagoryModel(this.imageUrl, this.title);
}

List<CatagoryModel> listCards = [
  CatagoryModel("assets/demo/burger.png", "Burger"),
  CatagoryModel("assets/demo/cake.png", "Cake"),
  CatagoryModel("assets/demo/pizza.png", "Pizza"),
  CatagoryModel("assets/demo/biryani.png", "Biryani"),
  CatagoryModel("assets/demo/masala-dosa.png", "Dosa"),
];

List<BannerModel> bannerList = [
  BannerModel("assets/foodlist/biryani1.jpg", "Chicken Biryani", "4.5", "250",
      "Dindigul Biryani", "345"),
  BannerModel("assets/foodlist/pizza1.jpg", "Spicy Pizza", "3.8", "200",
      "PizzaHut", "975"),
  BannerModel("assets/foodlist/dosa1.jpg", "Special Dosa", "4.3", "80",
      "Dosa Vandi", "667"),
  BannerModel("assets/foodlist/burger1.jpg", "Veg Burger", "4", "200",
      "McDonald's", "876"),
  BannerModel("assets/foodlist/cake1.jpg", "Birthday Cake", "4.5", "800",
      "FB Cakes", "456"),
  BannerModel("assets/foodlist/biryani2.jpg", "Mutton Biryani", "4.4", "350",
      "Salem SS Biryani", "465"),
  BannerModel("assets/foodlist/biryani3.jpg", "Beef Biryani", "4.2", "180",
      "A1 Biryani", "553"),
  BannerModel("assets/foodlist/dosa2.jpg", "Family Dosa", "4.6", "150",
      "Aandandha Bhavan", "456"),
  BannerModel("assets/foodlist/cake2.jpg", "Chocolate Cake", "4.2", "450",
      "Balaji Cakes", "553"),
  BannerModel("assets/foodlist/pizza2.jpg", "Chicken Pizza", "4.6", "350",
      "Domino's", "454"),
  BannerModel("assets/foodlist/burger2.jpg", "Chicken Burger", "4.2", "280",
      "Burger Stall", "345"),
  BannerModel("assets/foodlist/dosa3.jpg", "Nei Dosa", "4.7", "150",
      "Vasantha Bhavan", "439"),
  BannerModel("assets/foodlist/burger3.jpg", "Cheese Burger", "3.5", "250",
      "Burger Point", "540"),
];

class BannerModel {
  late String imageUrl, foodName, star, price, hotelName, reviewCount;
  BannerModel(this.imageUrl, this.foodName, this.star, this.price,
      this.hotelName, this.reviewCount);
}
