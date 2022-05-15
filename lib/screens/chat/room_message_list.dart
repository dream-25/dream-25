// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drm25/screens/chat/room_messages_page.dart';
import 'package:drm25/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RoomMessageList extends StatefulWidget {
  String userName;
  String userEmail;
  String userPic;
  RoomMessageList(this.userName, this.userEmail, this.userPic, {Key? key})
      : super(key: key);

  @override
  State<RoomMessageList> createState() => _RoomMessageListState();
}

class _RoomMessageListState extends State<RoomMessageList> {
  String roomName = "";
  String roomNo = "";
  String roomPassword = "";
  createToDo() {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("user_chats/rooms/all")
        .doc(roomNo);

    Map<String, String> todoList = {
      "room_name": roomName,
      "room_no": roomNo,
      "room_password": roomPassword,
    };

    documentReference.set(todoList).whenComplete(
        () => showSnackbarC(context, "Room Added", Colors.green, Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text("Rooms", style: TextStyle(color: Colors.white)),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("user_chats/rooms/all")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                      snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.blueGrey.shade100,
                      child: InkWell(
                        onTap: () {
                          String password = documentSnapshot['room_password'];
                          if (password == "") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RoomMessages(
                                      widget.userName.toString(),
                                      widget.userEmail.toString(),
                                      widget.userPic.toString(),
                                      documentSnapshot["room_name"],
                                      documentSnapshot["room_no"],
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
                                            BorderRadius.circular(10)),
                                    content: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          3 /
                                          4,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.152,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            child: TextField(
                                              controller: passwordController,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Enter room Password',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (password ==
                                                  passwordController.text) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RoomMessages(
                                                              widget.userName
                                                                  .toString(),
                                                              widget.userEmail
                                                                  .toString(),
                                                              widget.userPic
                                                                  .toString(),
                                                              documentSnapshot[
                                                                  "room_name"],
                                                              documentSnapshot[
                                                                  "room_no"],
                                                            )));
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "Wrong Password");
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  30, 16, 30, 16),
                                              child: Text("Login"),
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
                          trailing: (widget.userEmail ==
                                      "biswasmohan18@gmail.com" ||
                                  widget.userEmail ==
                                      "biswasmohan2529@gmail.com")
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width -
                                      MediaQuery.of(context).size.width * 0.66,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          roomName =
                                              documentSnapshot["room_name"];
                                          roomNo = documentSnapshot["room_no"];
                                          roomPassword =
                                              documentSnapshot["room_password"];

                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                final TextEditingController
                                                    nameController =
                                                    TextEditingController();
                                                final TextEditingController
                                                    noController =
                                                    TextEditingController();
                                                final TextEditingController
                                                    passwordController =
                                                    TextEditingController();
                                                nameController.text = roomName;
                                                noController.text = roomNo;
                                                passwordController.text =
                                                    roomPassword;
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
                                                            0.35,
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
                                                                noController,
                                                            onChanged:
                                                                ((value) {
                                                              roomNo = value;
                                                            }),
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText:
                                                                  'Enter room No',
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 8),
                                                          child: TextField(
                                                            controller:
                                                                nameController,
                                                            onChanged:
                                                                ((value) {
                                                              roomName = value;
                                                            }),
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText:
                                                                  'Enter room Name',
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 8),
                                                          child: TextField(
                                                            controller:
                                                                passwordController,
                                                            onChanged:
                                                                ((value) {
                                                              roomPassword =
                                                                  value;
                                                            }),
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
                                                            createToDo();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(30,
                                                                    16, 30, 16),
                                                            child: Text("Save"),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: CircleAvatar(
                                            backgroundColor:
                                                Colors.blueGrey.shade900,
                                            child: const Icon(Icons.edit)),
                                      ),
                                      const SizedBox(width: 8),
                                      InkWell(
                                        onTap: () {
                                          DocumentReference documentReference =
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      "user_chats/rooms/all")
                                                  .doc(snapshot
                                                      .data!.docs[index].id);

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
                                                Colors.red.shade600,
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            )),
                                      ),
                                      const SizedBox(width: 8),
                                      InkWell(
                                        onTap: () async {
                                          ClipboardData data = ClipboardData(
                                              text:
                                                  "http://dream-25.web.app/#/custom_room?rnm=${documentSnapshot['room_name']}&rn=${documentSnapshot['room_no']}&p=${documentSnapshot['room_password']}");
                                          await Clipboard.setData(data);
                                          showSnackbarC(
                                              context,
                                              "Link copied to Clipboard",
                                              Colors.green,
                                              Colors.white);
                                        },
                                        child: const CircleAvatar(
                                            backgroundColor: Colors.green,
                                            child: Icon(
                                              Icons.copy,
                                              color: Colors.white,
                                            )),
                                      )
                                    ],
                                  ),
                                )
                              : const Icon(Icons.arrow_forward_ios),
                          leading: CircleAvatar(
                              child: Text(documentSnapshot["room_name"]
                                  .toString()
                                  .substring(0, 1))),
                          title: Text(
                            (widget.userEmail == "biswasmohan18@gmail.com" ||
                                    widget.userEmail ==
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
            return const Center();
          }
        },
      ),
      floatingActionButton: Visibility(
        visible: (widget.userEmail == "biswasmohan18@gmail.com" ||
            widget.userEmail == "biswasmohan2529@gmail.com"),
        child: FloatingActionButton(
          onPressed: () {
            roomName = "";
            roomNo = "";
            roomPassword = "";
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  final TextEditingController nameController =
                      TextEditingController();
                  final TextEditingController noController =
                      TextEditingController();
                  final TextEditingController passwordController =
                      TextEditingController();
                  nameController.text = roomName;
                  noController.text = roomNo;
                  passwordController.text = roomPassword;
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width * 3 / 4,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: TextField(
                              controller: noController,
                              onChanged: ((value) {
                                roomNo = value;
                              }),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter room No',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: TextField(
                              controller: nameController,
                              onChanged: ((value) {
                                roomName = value;
                              }),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter room Name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: TextField(
                              controller: passwordController,
                              onChanged: ((value) {
                                roomPassword = value;
                              }),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter room Password',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              createToDo();
                              Navigator.of(context).pop();
                            },
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(30, 16, 30, 16),
                              child: Text("Save"),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
