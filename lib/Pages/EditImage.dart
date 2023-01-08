import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/MyButton.dart';
import 'package:flutter_application_1/Components/MySnackBar.dart';
import 'package:flutter_application_1/Model/instances.dart';
import 'package:flutter_application_1/Model/user_info.dart';
import 'package:flutter_application_1/res/OnlyBackAppBar.dart';
import 'package:flutter_application_1/res/ShimmarBox.dart';

class EditImage extends StatefulWidget {
  final String ImgUrl;
  const EditImage({super.key, required this.ImgUrl});

  @override
  State<EditImage> createState() => _EditImageState(ImgUrl: this.ImgUrl);
}

class _EditImageState extends State<EditImage> {
  final String ImgUrl;
  _EditImageState({required this.ImgUrl});
  UploadTask? uploadTask;
  var ImgSrc = null;
  var extAlow = ['jpg', 'png', 'gif', 'jpeg'];

  var useinfo = UserInfo();
// Handel Popup error
  poperror(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        title: msg,
        onclick: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        BgColor: Colors.red,
        icon: const Icon(
          Icons.error_outline,
          color: Colors.white,
        )));
  }

// Handel File Picker

  pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowCompression: true,
        type: FileType.custom,
        allowedExtensions: extAlow,
      );

      if (extAlow.contains(result!.files.first.extension)) {
        setState(() {
          ImgSrc = result.files.first;
        });
      } else {
        poperror("Invalid Image Type");
      }
    } catch (e) {
      print({"error": e});
    }
  }

// Genrate Rendam String
  getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

// On submit Handel
  onSubmitUpload() async {
    try {
      if (ImgSrc != null) {
        if (extAlow.contains(ImgSrc.extension)) {
          final StoragePath = "/profile/${getRandomString(10) + ImgSrc!.name}";

          final pathSrc = File(ImgSrc.path);

          final fireStoreage =
              Instances().fireStoreage.ref().child(StoragePath);
          setState(() {
            uploadTask = fireStoreage.putFile(pathSrc);
          });

          final fileInfo = await uploadTask!.whenComplete(() {});
          final downloadUrl = await fileInfo.ref.getDownloadURL();

// delete image
          var getref = Instances().fireStoreage.refFromURL(ImgUrl).fullPath;

          if (getref != "profile/user.png") {
            await Instances().fireStoreage.ref().child(getref).delete();
          }
// update image source
          await useinfo.setUserUpdate({"pic": downloadUrl});
          setState(() {
            uploadTask = null;
          });
// anvgate page
          Navigator.of(context).pop(context);
        } else {
          poperror("Invalid Image Type");
        }
      } else {
        poperror("Please Select a Image");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OnlyBackAppbar(context),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Center(
                    child: GestureDetector(
                  onTap: () => pickFile(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Stack(
                      children: [
                        Container(
                          child: ImgSrc != null
                              ? Image.file(
                                  File(ImgSrc!.path),
                                  width: 300,
                                  height: 300,
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl: ImgUrl,
                                  width: 300,
                                  height: 300,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => ShimmerBox(
                                    height: 80.0,
                                    width: 80.0,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      ShimmerBox(
                                    height: 80.0,
                                    width: 80.0,
                                  ),
                                ),
                        ),
                        uploadTask != null
                            ? Container(
                                color: const Color.fromARGB(111, 255, 255, 255),
                                width: 300,
                                height: 300,
                                child: Center(child: loading()),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: MyButton(
              name: uploadTask == null
                  ? const Text(
                      "Update Picture",
                      style: TextStyle(color: Colors.white),
                    )
                  : Container(
                      width: 20,
                      height: 20,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
              desabl: uploadTask != null ? true : false,
              color: uploadTask != null
                  ? const Color.fromARGB(169, 0, 0, 0)
                  : Colors.black,
              ontap: onSubmitUpload),
        )
      ]),
    );
  }

  Widget loading() {
    return StreamBuilder(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final loadingdata = snapshot.data;
          double count = loadingdata!.bytesTransferred / loadingdata.totalBytes;

          return Text(
            "${(100 * count).roundToDouble()}%",
            style: const TextStyle(color: Colors.black, fontFamily: "snow"),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
