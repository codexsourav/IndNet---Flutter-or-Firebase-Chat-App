import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/AlertBox.dart';
import 'package:flutter_application_1/Components/MyButton.dart';
import 'package:flutter_application_1/Components/MyInput.dart';
import 'package:flutter_application_1/Components/MySnackBar.dart';
import 'package:flutter_application_1/Components/TitleBar.dart';
import 'package:flutter_application_1/Model/user_info.dart';
import 'package:flutter_application_1/Pages/ProfilePage.dart';
import 'package:flutter_application_1/res/OnlyBackAppBar.dart';

class UpdateProfile extends StatefulWidget {
  final String name;
  final String bio;
  const UpdateProfile({super.key, required this.name, required this.bio});

  @override
  State<UpdateProfile> createState() =>
      UpdateProfileState(name: name, bio: bio);
}

class UpdateProfileState extends State<UpdateProfile> {
  String name;
  bool loading = false;
  String bio;
  UpdateProfileState({required this.name, required this.bio});
  var errormsg = null;
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameCont = TextEditingController(text: name);
    final TextEditingController bioCont = TextEditingController(text: bio);
    var userinfo = UserInfo();

    updatefun() {
      setState(() {
        name = nameCont.text;
        bio = bioCont.text;
      });
      if (nameCont.text.isEmpty) {
        errormsg = "Please Enter Your Valid Name";
      } else {
        setState(() {
          loading = true;
        });

        userinfo.setUserUpdate(
            {"name": nameCont.text, "bio": bioCont.text}).then((value) {
          setState(() {
            loading = false;
          });

          if (!value!.containsKey("error")) {
            Navigator.of(context).pop(
                MaterialPageRoute(builder: (context) => const MyProfilePage()));
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                    "Update Error",
                    "Your Data Is Not Updated. Sumthing Want Wrong...",
                    "OK",
                    context);
              },
            );
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OnlyBackAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleBar("Update Profile"),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 15.0),
              child: MyInput(
                  lable: LableInput("Your Name"),
                  lableError: errormsg != null
                      ? errorlableText(errormsg)
                      : const SizedBox(),
                  BorderRadiusVal: 5,
                  TextInputType: TextInputType.name,
                  maxlen: 20,
                  onChanged: (data) {
                    if (errormsg != null) {
                      setState(() {
                        errormsg = null;
                      });
                    }
                  },
                  hintText: "Name",
                  controller: nameCont,
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 15.0),
              child: MyInput(
                TextInputType: TextInputType.multiline,
                lable: LableInput("Bio Info"),
                controller: bioCont,
                BorderRadiusVal: 5,
                maxlen: 80,
                onChanged: (data) {
                  if (errormsg != null) {
                    setState(() {
                      errormsg = null;
                    });
                  }
                },
                hintText: "Bio",
                icon: const Icon(
                  Icons.abc_rounded,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 15.0),
              child: MyButton(
                  color: loading
                      ? const Color.fromARGB(255, 53, 53, 53)
                      : const Color.fromARGB(255, 0, 0, 0),
                  desabl: loading,
                  name: loading
                      ? Container(
                          width: 20,
                          height: 20,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Update Info",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "snow"),
                        ),
                  ontap: updatefun,
                  borderRadiusVal: 5),
            )
          ],
        ),
      ),
    );
  }

  Widget errorlableText(String error) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
          alignment: Alignment.topRight,
          child: Text(
            error,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          )),
    );
  }

  Widget LableInput(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5),
      child: Text(
        name,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13.0,
            color: Color.fromARGB(255, 68, 68, 68)),
      ),
    );
  }
}
