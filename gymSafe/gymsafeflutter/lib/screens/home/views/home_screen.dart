import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = PageController(
    initialPage: 0,
  );

  int numberPhotos = 4;
  int currentPhoto = 0;
  late MatchEngine _matchEngine;

  List<SwipeItem> items = [
    SwipeItem(
        content: "Liz",
        likeAction: () {
          log("Like");
        },
        nopeAction: () {
          log("Nope");
        },
        superlikeAction: () {
          log("Superlike");
        },
        onSlideUpdate: (SlideRegion? region) async {
          log("Region $region");
        }),
    SwipeItem(
        content: "Liz",
        likeAction: () {
          log("Like");
        },
        nopeAction: () {
          log("Nope");
        },
        superlikeAction: () {
          log("Superlike");
        },
        onSlideUpdate: (SlideRegion? region) async {
          log("Region $region");
        }),
    SwipeItem(
        content: "Liz",
        likeAction: () {
          log("Like");
        },
        nopeAction: () {
          log("Nope");
        },
        superlikeAction: () {
          log("Superlike");
        },
        onSlideUpdate: (SlideRegion? region) async {
          log("Region $region");
        }),
  ];

  @override
  void initState() {
    _matchEngine = MatchEngine(swipeItems: items);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "../../../assets/tinder_logo.png",
              scale: 18,
            ),
            Text(
              'tinder',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            )
          ],
        ),
      ),
      body: SwipeCards(
        matchEngine: _matchEngine,
        upSwipeAllowed: true,
        onStackFinished: () {},
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Hero(
                tag: "imageTag$i",
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("../../../assets/girl.png"))),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [Colors.black, Colors.transparent])),
                    ),
                    // ... (rest of the widget tree for the card)
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Adjust according to your logic
        onTap: (index) {
          // Handle tab switching
          setState(() {
            // Update selected index
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
