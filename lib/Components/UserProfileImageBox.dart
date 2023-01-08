import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/EditImage.dart';
import 'package:flutter_application_1/res/ShimmarBox.dart';

Widget UserProfileImageBox(
    {required BuildContext context,
    required String imgurl,
    required name,
    online = false}) {
  return Container(
    margin: EdgeInsets.only(top: 15.0),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/userbg.jpeg",
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      backgroundColor: Colors.white,
                      fontSize: 12.0),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          bottom: -40,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: online
                      ? Color.fromARGB(255, 58, 196, 24)
                      : Color.fromARGB(255, 190, 190, 190),
                  width: 3,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                // child: Image.network(
                //   imgurl,
                //   height: 80.0,
                //   width: 80.0,
                //   fit: BoxFit.fitWidth,
                //   filterQuality: FilterQuality.low,
                //   errorBuilder: (context, error, stackTrace) {
                //     return ShimmerBox(
                //       height: 80.0,
                //       width: 80.0,
                //     );
                //   },
                // ),

                child: CachedNetworkImage(
                  imageUrl: imgurl,
                  height: 80.0,
                  width: 80.0,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => ShimmerBox(
                    height: 80.0,
                    width: 80.0,
                  ),
                  errorWidget: (context, url, error) => ShimmerBox(
                    height: 80.0,
                    width: 80.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => EditImage(
                          ImgUrl: imgurl.toString(),
                        )),
              );
            },
            icon: Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 18,
            ),
          ),
        )
      ],
    ),
  );
}
