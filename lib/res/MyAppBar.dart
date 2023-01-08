import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/FriendsPage.dart';
import 'package:flutter_application_1/Pages/NotificationsPage.dart';
import 'package:flutter_application_1/Pages/ProfilePage.dart';
import 'package:flutter_application_1/res/ShimmarBox.dart';

class MyAppBar extends StatefulWidget {
  final Widget child;
  final InfoData;
  const MyAppBar({super.key, required this.child, this.InfoData});

  @override
  State<MyAppBar> createState() =>
      _MyAppBarState(child: this.child, InfoData: this.InfoData);
}

class _MyAppBarState extends State<MyAppBar> {
  final Widget child;
  final InfoData;
  _MyAppBarState({required this.child, this.InfoData});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          floating: true,
          title: Container(
            margin: const EdgeInsets.only(left: 30.0),
            child: const Text(
              "indnet",
              style: TextStyle(fontFamily: "snow", color: Colors.black),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FriendsPage(),
                ));
              },
              icon: const Icon(
                Icons.person_search,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NotificationPage(),
                  ));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.black,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                      padding: const EdgeInsets.symmetric(vertical: 3.5),
                      height: 15.0,
                      width: 15.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "1",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.0,
                              fontFamily: "snow"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(13),
              margin: const EdgeInsets.only(right: 25.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyProfilePage(),
                  ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: InfoData['pic'],
                    height: 30.0,
                    width: 30.0,
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => ShimmerBox(
                      height: 30.0,
                      width: 30.0,
                    ),
                    errorWidget: (context, url, error) => ShimmerBox(
                      height: 30.0,
                      width: 30.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: child,
        ),
      ],
    );
    ;
  }
}
