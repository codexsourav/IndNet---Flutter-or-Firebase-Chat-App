import 'package:flutter/material.dart';
import 'package:flutter_application_1/res/ShimmarBox.dart';

class HomePageLoading extends StatelessWidget {
  const HomePageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: ShimmerBox(
          width: 130,
          height: 30,
          magL: 20,
          radius: 5,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                ShimmerBox(width: 30, height: 30, radius: 5, marR: 10),
                ShimmerBox(width: 30, height: 30, radius: 5, marR: 10),
                ShimmerBox(width: 30, height: 30, radius: 5, marR: 10),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              ShimmerBox(width: 145, height: 40, magB: 50, magL: 20, mrgT: 20),
              ShimmerBox(
                  width: double.infinity, height: 70, magB: 30, radius: 20),
              ShimmerBox(
                  width: double.infinity, height: 70, magB: 30, radius: 20),
              ShimmerBox(
                  width: double.infinity, height: 70, magB: 30, radius: 20),
              ShimmerBox(
                  width: double.infinity, height: 70, magB: 30, radius: 20),
              ShimmerBox(
                  width: double.infinity, height: 70, magB: 30, radius: 20),
              ShimmerBox(
                  width: double.infinity, height: 70, magB: 30, radius: 20),
              ShimmerBox(
                  width: double.infinity, height: 70, magB: 30, radius: 20),
            ],
          ),
        ),
      ),
    );
  }
}
