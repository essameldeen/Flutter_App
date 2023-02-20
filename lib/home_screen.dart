import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        leading: const Icon(Icons.menu),
        title: const Text("Test Flutter"),
        actions: [
          const Icon(Icons.search_rounded),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              print("hi clicked");
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.purple,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50)
            ),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Image(
                  height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMNxU_hx7_YdbD_JsmKxvrf8CGCrgMFOsWOUj-qqsvyzdgPzsE_Tr0KMdgKGoutLnEG0I&usqp=CAU"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
