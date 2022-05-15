import 'package:cached_network_image/cached_network_image.dart';
import 'package:drm25/screens/chat/room_message_list.dart';
import 'package:drm25/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../chat/private_messages_page.dart';
import '../../chat/room_messages_page.dart';

// ignore: must_be_immutable
class HomeScreenDrawer extends StatefulWidget {
  String userName;
  String userEmail;
  String userProfileImageUrl;
  HomeScreenDrawer(this.userName, this.userEmail, this.userProfileImageUrl,
      {Key? key})
      : super(key: key);

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((value) => (value != null)
          ? Navigator.pushReplacementNamed(context, MyRoutes.splashRoute)
          : null);
    } catch (error) {
      Fluttertoast.showToast(
          timeInSecForIosWeb: 5000,
          msg: error.toString(),
          backgroundColor: Colors.red);
    }
  }

  Future<void> _handleSignOut() async {
    await _googleSignIn.disconnect().then((value) =>
        Navigator.pushReplacementNamed(context, MyRoutes.splashRoute));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color.fromARGB(125, 1, 2, 61),
        width: MediaQuery.of(context).size.width * 0.75,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                child: UserAccountsDrawerHeader(
                  arrowColor: Colors.white,
                  accountName: Text(
                    widget.userName,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(widget.userEmail),
                  currentAccountPicture: (widget.userProfileImageUrl !=
                              "none" &&
                          widget.userProfileImageUrl != "null")
                      ? CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                              widget.userProfileImageUrl),
                        )
                      : (widget.userProfileImageUrl == "none")
                          ? InkWell(
                              onTap: _handleSignIn,
                              child: CircleAvatar(
                                  backgroundColor: Colors.indigo.shade700,
                                  child: const Text("Login")),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.indigo.shade700,
                              child: Center(
                                child: Text(
                                  widget.userName.toString().substring(0, 1),
                                  style: const TextStyle(
                                    fontSize: 40,
                                  ),
                                ),
                              )),
                ),
              ),
              InkWell(
                onTap: (widget.userEmail != "Welcome to the dream's world")
                    ? () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RoomMessageList(
                                widget.userName.toString(),
                                widget.userEmail.toString(),
                                widget.userProfileImageUrl.toString())));
                      }
                    : _handleSignIn,
                child: const ListTile(
                  leading: Icon(
                    CupertinoIcons.layers_fill,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Rooms",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (widget.userEmail != "Welcome to the dream's world")
                    ? () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PrivateMessages(
                                widget.userName.toString(),
                                widget.userEmail.toString(),
                                widget.userProfileImageUrl.toString())));
                      }
                    : _handleSignIn,
                child: const ListTile(
                    leading: Icon(CupertinoIcons.bolt_circle_fill,
                        color: Colors.white),
                    title: Text(
                      "Private Messages",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
              ),
              InkWell(
                onTap: (widget.userEmail != "Welcome to the dream's world")
                    ? () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RoomMessages(
                                  widget.userName.toString(),
                                  widget.userEmail.toString(),
                                  widget.userProfileImageUrl.toString(),
                                  "Community",
                                  "1",
                                )));
                      }
                    : _handleSignIn,
                child: const ListTile(
                    leading:
                        Icon(CupertinoIcons.text_bubble, color: Colors.white),
                    title: Text(
                      "Community",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
              ),
              Container(
                height: 0.5,
                width: MediaQuery.of(context).size.width - 120,
                margin: const EdgeInsets.fromLTRB(17, 0, 12, 17),
                color: const Color.fromARGB(255, 110, 111, 133),
              ),
              InkWell(
                onTap: _handleSignOut,
                child: const ListTile(
                    leading: Icon(CupertinoIcons.square_arrow_left,
                        color: Colors.white),
                    title: Text(
                      "Logout",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
              ),
              Container(
                height: 0.5,
                width: MediaQuery.of(context).size.width - 120,
                margin: const EdgeInsets.fromLTRB(17, 0, 12, 17),
                color: const Color.fromARGB(255, 110, 111, 133),
              ),
              const ListTile(
                  leading: Icon(CupertinoIcons.checkmark_shield,
                      color: Colors.white),
                  title: Text(
                    "Dream Softwares",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
