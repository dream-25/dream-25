import 'dart:typed_data';
import 'package:drm25/screens/chat/widgets/text_msg_rcv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:file_picker/file_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/snackbar.dart';
import 'widgets/file_message_rcv.dart';
import 'widgets/file_message_send.dart';
import 'widgets/text_msg_send.dart';
import '../../utils/firebase_storage.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class RoomMessages extends StatefulWidget {
  String userName;
  String userEmail;
  String userProfileImageUrl;
  String roomName;
  String roomNo;
  RoomMessages(
    this.userName,
    this.userEmail,
    this.userProfileImageUrl,
    this.roomName,
    this.roomNo, {
    Key? key,
  }) : super(key: key);

  @override
  State<RoomMessages> createState() => _RoomMessagesState();
}

class _RoomMessagesState extends State<RoomMessages> {
  bool loading = false;
  final TextEditingController _controller = TextEditingController();
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;

  @override
  void initState() {
    super.initState();
  }

  String message = "";

  final ServicerStorageService storage = ServicerStorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Text(widget.roomName.toString().substring(0, 1)),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(" ${widget.roomName}",
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Visibility(
                    visible: (loading == true) ? true : false,
                    child: SizedBox(
                      height: 5,
                      width: MediaQuery.of(context).size.width,
                      child: const LinearProgressIndicator(),
                    )),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(
                            "user_chats/${(widget.roomName + widget.roomNo).toString().replaceAll(" ", "-")}/saved_messages")
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
                              if (documentSnapshot["UserEmail"] ==
                                  widget.userEmail) {
                                return (documentSnapshot["type"] == "TEXT")
                                    ? InkWell(
                                        onLongPress: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  title: const Text(
                                                      "Delete this Message",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      )),
                                                  backgroundColor:
                                                      Colors.blueGrey.shade800,
                                                  actions: <Widget>[
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          DocumentReference
                                                              documentReference =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "user_chats/${(widget.roomName + widget.roomNo).toString().replaceAll(" ", "-")}/saved_messages")
                                                                  .doc(snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
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
                                                        child: const Text(
                                                            "Delete")),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();

                                                        ClipboardData data =
                                                            ClipboardData(
                                                                text:
                                                                    documentSnapshot[
                                                                        "msg"]);
                                                        await Clipboard.setData(
                                                            data);
                                                        showSnackbarC(
                                                            context,
                                                            "Copied Succesfully",
                                                            Colors.green,
                                                            Colors.white);
                                                      },
                                                      child: const Text(
                                                          "Copy Message"),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: CustomTextMessageSend(
                                            documentSnapshot["msg"],
                                            documentSnapshot["time"],
                                            documentSnapshot["status"]),
                                      )
                                    : InkWell(
                                        onLongPress: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  title: const Text(
                                                      "Delete this Message",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      )),
                                                  backgroundColor:
                                                      Colors.blueGrey.shade800,
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        DocumentReference
                                                            documentReference =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "user_chats/${(widget.roomName + widget.roomNo).toString().replaceAll(" ", "-")}/saved_messages")
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
                                                      child:
                                                          const Text("Delete"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();

                                                        ClipboardData data =
                                                            ClipboardData(
                                                                text:
                                                                    documentSnapshot[
                                                                        "msg"]);
                                                        await Clipboard.setData(
                                                            data);
                                                        showSnackbarC(
                                                            context,
                                                            "Copied Succesfully",
                                                            Colors.green,
                                                            Colors.white);
                                                      },
                                                      child: const Text(
                                                          "Copy Message"),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: CustomFileMessageSend(
                                          documentSnapshot["msg"],
                                          documentSnapshot["time"],
                                          documentSnapshot["status"],
                                          documentSnapshot["file"],
                                          documentSnapshot["file_name"],
                                        ),
                                      );
                              } else {
                                return (documentSnapshot["type"] == "TEXT")
                                    ? InkWell(
                                        onLongPress: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  title: const Text(
                                                      "Delete this Message",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      )),
                                                  backgroundColor:
                                                      Colors.blueGrey.shade800,
                                                  actions: <Widget>[
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          DocumentReference
                                                              documentReference =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "user_chats/${(widget.roomName + widget.roomNo).toString().replaceAll(" ", "-")}/saved_messages")
                                                                  .doc(snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
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
                                                        child: const Text(
                                                            "Delete")),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();

                                                        ClipboardData data =
                                                            ClipboardData(
                                                                text:
                                                                    documentSnapshot[
                                                                        "msg"]);
                                                        await Clipboard.setData(
                                                            data);
                                                        showSnackbarC(
                                                            context,
                                                            "Copied Succesfully",
                                                            Colors.green,
                                                            Colors.white);
                                                      },
                                                      child: const Text(
                                                          "Copy Message"),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: CustomTextMessageRcv(
                                            documentSnapshot["UserName"],
                                            documentSnapshot["UserEmail"],
                                            documentSnapshot["UserPic"],
                                            documentSnapshot["msg"],
                                            documentSnapshot["time"],
                                            documentSnapshot["status"]),
                                      )
                                    : InkWell(
                                        onLongPress: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  title: const Text(
                                                      "Delete this Message",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      )),
                                                  backgroundColor:
                                                      Colors.blueGrey.shade800,
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        DocumentReference
                                                            documentReference =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "user_chats/${(widget.roomName + widget.roomNo).toString().replaceAll(" ", "-")}/saved_messages")
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
                                                      child:
                                                          const Text("Delete"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();

                                                        ClipboardData data =
                                                            ClipboardData(
                                                                text:
                                                                    documentSnapshot[
                                                                        "msg"]);
                                                        await Clipboard.setData(
                                                            data);
                                                        showSnackbarC(
                                                            context,
                                                            "Copied Succesfully",
                                                            Colors.green,
                                                            Colors.white);
                                                      },
                                                      child: const Text(
                                                          "Copy Message"),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: CustomFileMessageRcv(
                                          documentSnapshot["UserName"],
                                          documentSnapshot["UserEmail"],
                                          documentSnapshot["UserPic"],
                                          documentSnapshot["msg"],
                                          documentSnapshot["time"],
                                          documentSnapshot["status"],
                                          documentSnapshot["file"],
                                          documentSnapshot["file_name"],
                                        ),
                                      );
                              }
                            });
                      } else {
                        return const Center();
                      }
                    })
              ]),
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 65,
            color: Colors.blueGrey.shade900,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 60,
                    child: Card(
                      margin: const EdgeInsets.only(
                        left: 2,
                        right: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: TextFormField(
                          controller: _controller,
                          focusNode: focusNode,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                sendButton = true;
                                message = value;
                              });
                            } else {
                              setState(() {
                                sendButton = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: " Type a message",
                            hintStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.file_present_rounded,
                                color: Colors.blueGrey.shade900.withOpacity(.5),
                              ),
                              onPressed: () async {
                                if (kIsWeb) {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles();
                                  if (result != null) {
                                    setState(() {
                                      loading = true;
                                    });
                                    showSnackbarC(context, "Sending File",
                                        Colors.amber, Colors.white);
                                    Uint8List? file = result.files.first.bytes;
                                    String fileName = result.files.first.name;
                                    FirebaseStorage.instance
                                        .ref()
                                        .child(
                                            "user_messages/files/${widget.userEmail.toString().replaceAll("@", "-")}//$fileName")
                                        .putData(file!)
                                        .then((p0) async {
                                      DateTime now = DateTime.now();
                                      String formattedDate =
                                          DateFormat('hh:mm:ss aa').format(now);
                                      _controller.clear();
                                      DocumentReference documentReference =
                                          FirebaseFirestore.instance
                                              .collection(
                                                  "user_chats/${(widget.roomName + widget.roomNo).toString().replaceAll(" ", "-")}/saved_messages")
                                              .doc(DateTime.now()
                                                  .millisecondsSinceEpoch
                                                  .toString());

                                      Map<String, String> todoList = {
                                        "UserEmail":
                                            widget.userEmail.toString(),
                                        "UserName": widget.userName.toString(),
                                        "UserPic": widget.userProfileImageUrl
                                            .toString(),
                                        "msg": message,
                                        "file_name": fileName,
                                        "file": await storage.downloadURl(
                                            "user_messages/files/${widget.userEmail.toString().replaceAll("@", "-")}/$fileName"),
                                        "time": formattedDate,
                                        "time_mili": DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString(),
                                        "status": "done",
                                        "type": "FILE"
                                      };
                                      documentReference
                                          .set(todoList)
                                          .whenComplete(() async {
                                        message = "";
                                        showSnackbarC(context, "File Sent",
                                            Colors.green, Colors.white);
                                        setState(() {
                                          loading = false;
                                        });
                                      });
                                    });
                                  } else {
                                    showSnackbarC(context, "No Files Picked",
                                        Colors.red, Colors.white);
                                  }
                                } else {
                                  final results = await FilePicker.platform
                                      .pickFiles(
                                          allowMultiple: false,
                                          allowCompression: true,
                                          type: FileType.any);

                                  if (results == null) {
                                    showSnackbarC(context, "No Files Picked",
                                        Colors.red, Colors.white);
                                  } else {
                                    setState(() {
                                      loading = true;
                                    });
                                    showSnackbarC(context, "Sending File",
                                        Colors.amber, Colors.white);
                                    final path = results.files.single.path!;
                                    final fileName = results.files.single.name;
                                    storage
                                        .uploadFile(path, fileName,
                                            "user_messages/files/${widget.userEmail.toString().replaceAll("@", "-")}/")
                                        .then((value) async {
                                      DateTime now = DateTime.now();
                                      String formattedDate =
                                          DateFormat('hh:mm:ss aa').format(now);
                                      _controller.clear();
                                      DocumentReference documentReference =
                                          FirebaseFirestore.instance
                                              .collection(
                                                  "user_chats/${(widget.roomName + widget.roomNo).toString().replaceAll(" ", "-")}/saved_messages")
                                              .doc(DateTime.now()
                                                  .millisecondsSinceEpoch
                                                  .toString());

                                      Map<String, String> todoList = {
                                        "UserEmail":
                                            widget.userEmail.toString(),
                                        "UserName": widget.userName.toString(),
                                        "UserPic": widget.userProfileImageUrl
                                            .toString(),
                                        "msg": message,
                                        "file_name": fileName,
                                        "file": await storage.downloadURl(
                                            "user_messages/files/${widget.userEmail.toString().replaceAll("@", "-")}/$fileName"),
                                        "time": formattedDate,
                                        "time_mili": DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString(),
                                        "status": "done",
                                        "type": "FILE"
                                      };
                                      documentReference
                                          .set(todoList)
                                          .whenComplete(() async {
                                        message = "";
                                        showSnackbarC(context, "File Sent",
                                            Colors.green, Colors.white);
                                        setState(() {
                                          loading = false;
                                        });
                                      });
                                    });
                                  }
                                }
                              },
                            ),
                            contentPadding: const EdgeInsets.all(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 2,
                      left: 2,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (message.isNotEmpty) {
                          DateTime now = DateTime.now();
                          String formattedDate =
                              DateFormat('hh:mm:ss aa').format(now);
                          _controller.clear();
                          DocumentReference documentReference = FirebaseFirestore
                              .instance
                              .collection(
                                  "user_chats/${(widget.roomName + widget.roomNo).toString().replaceAll(" ", "-")}/saved_messages")
                              .doc(DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString());

                          Map<String, String> todoList = {
                            "UserEmail": widget.userEmail.toString(),
                            "UserName": widget.userName.toString(),
                            "UserPic": widget.userProfileImageUrl.toString(),
                            "msg": message,
                            "time": formattedDate,
                            "time_mili": DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            "status": "done",
                            "type": "TEXT"
                          };
                          documentReference
                              .set(todoList)
                              .whenComplete(() async {
                            message = "";
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
