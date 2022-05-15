// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/snackbar.dart';
import 'chat/room_messages_page.dart';

class CustomRoom extends StatefulWidget {
  String roomName;
  String roomNo;

  CustomRoom(this.roomName, this.roomNo, {Key? key}) : super(key: key);

  @override
  State<CustomRoom> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CustomRoom> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((value) => null);
    } catch (error) {
      Fluttertoast.showToast(
          timeInSecForIosWeb: 5000,
          msg: error.toString(),
          backgroundColor: Colors.red);
    }
  }

  Future<void> _handleSignOut() async {
    await _googleSignIn.disconnect().then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount? user = _currentUser;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: SingleChildScrollView(
          child: Column(
            children: [
              (user != null)
                  ? DrawerHeader(
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                      child: UserAccountsDrawerHeader(
                        arrowColor: Colors.white,
                        accountName: Text(
                          user.displayName.toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        accountEmail: Text(user.email.toString()),
                        currentAccountPicture:
                            (user.photoUrl.toString() != "none" &&
                                    user.photoUrl.toString() != "null")
                                ? CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                        user.photoUrl.toString()),
                                  )
                                : (user.photoUrl.toString() == "none")
                                    ? CircleAvatar(
                                        backgroundColor: Colors.indigo.shade700,
                                        child: const Text("Login"))
                                    : CircleAvatar(
                                        backgroundColor: Colors.indigo.shade700,
                                        child: Center(
                                          child: Text(
                                            user.displayName
                                                .toString()
                                                .toString()
                                                .substring(0, 1),
                                            style: const TextStyle(
                                              fontSize: 40,
                                            ),
                                          ),
                                        )),
                      ),
                    )
                  : DrawerHeader(
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                      child: UserAccountsDrawerHeader(
                        arrowColor: Colors.white,
                        accountName: const Text(
                          "Dream-25",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        accountEmail:
                            const Text("Welcome to the dream's world"),
                        currentAccountPicture: CircleAvatar(
                            backgroundColor: Colors.indigo.shade700,
                            child: const Center(
                              child: Text(
                                "D",
                                style: TextStyle(
                                  fontSize: 40,
                                ),
                              ),
                            )),
                      ),
                    ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Make Sure URL is Correct",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              (user != null)
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("user_chats/rooms/all")
                          .where("room_name", isEqualTo: widget.roomName)
                          .where("room_no", isEqualTo: widget.roomNo)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                QueryDocumentSnapshot<Object?>?
                                    documentSnapshot =
                                    snapshot.data!.docs[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.blueGrey.shade100,
                                    child: InkWell(
                                      onTap: () {
                                        String password =
                                            documentSnapshot['room_password'];
                                        if (password == "") {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RoomMessages(
                                                        user.displayName
                                                            .toString(),
                                                        user.email.toString(),
                                                        user.photoUrl
                                                            .toString(),
                                                        documentSnapshot[
                                                            "room_name"],
                                                        documentSnapshot[
                                                            "room_no"],
                                                      )));
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                final TextEditingController
                                                    passwordController =
                                                    TextEditingController();

                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  content: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            3 /
                                                            4,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.152,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 8),
                                                          child: TextField(
                                                            controller:
                                                                passwordController,
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText:
                                                                  'Enter room Password',
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            if (password ==
                                                                passwordController
                                                                    .text) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              RoomMessages(
                                                                                user.displayName.toString(),
                                                                                user.email.toString(),
                                                                                user.photoUrl.toString(),
                                                                                documentSnapshot["room_name"],
                                                                                documentSnapshot["room_no"],
                                                                              )));
                                                            } else {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Wrong Password");
                                                            }
                                                          },
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(30,
                                                                    16, 30, 16),
                                                            child:
                                                                Text("Login"),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        }
                                      },
                                      child: ListTile(
                                        trailing: (user.email ==
                                                    "biswasmohan18@gmail.com" ||
                                                user.email ==
                                                    "biswasmohan2529@gmail.com")
                                            ? SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.75,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const SizedBox(width: 8),
                                                    InkWell(
                                                      onTap: () {
                                                        DocumentReference
                                                            documentReference =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "user_chats/rooms/all")
                                                                .doc(snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id);

                                                        documentReference
                                                            .delete()
                                                            .whenComplete(() {
                                                          showSnackbarC(
                                                              context,
                                                              "Deleted Succesfully",
                                                              Colors.red,
                                                              Colors.white);
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors
                                                                  .red.shade600,
                                                          child: const Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : const Icon(
                                                Icons.arrow_forward_ios),
                                        leading: CircleAvatar(
                                            child: Text(
                                                documentSnapshot["room_name"]
                                                    .toString()
                                                    .substring(0, 1))),
                                        title: Text(
                                          (user.email ==
                                                      "biswasmohan18@gmail.com" ||
                                                  user.email ==
                                                      "biswasmohan2529@gmail.com")
                                              ? "[" +
                                                  documentSnapshot["room_no"] +
                                                  "] " +
                                                  documentSnapshot["room_name"]
                                              : documentSnapshot["room_name"],
                                          style: TextStyle(
                                              color: Colors.blueGrey.shade900,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Card(
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Waiting for The Room"),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: CircularProgressIndicator(),
                                          )
                                        ]),
                                  ],
                                )),
                          );
                        }
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: ElevatedButton(
                        child: const Text("Login to Join a Room"),
                        onPressed: _handleSignIn,
                      )),
                    ),
              Visibility(
                visible: (user != null) ? true : false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: ElevatedButton(
                    child: const Text("Logut"),
                    onPressed: _handleSignOut,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
