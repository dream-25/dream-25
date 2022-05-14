import 'package:drm25/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/firebase_storage.dart';
import 'package:shimmer/shimmer.dart';

class CustomFileMessageSend extends StatelessWidget {
  final String msg;
  final String time;
  final String status;
  final String file;
  final String fileName;
  const CustomFileMessageSend(
      this.msg, this.time, this.status, this.file, this.fileName,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServicerStorageService storage = ServicerStorageService();
    return Padding(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width * 3 / 4,
          4,
          8,
          4),
      child: Card(
        color: Colors.blueGrey.shade100,
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: storage.downloadURl(file),
              builder:
                  (BuildContext context, AsyncSnapshot<String> audSnapshot) {
                if (audSnapshot.connectionState == ConnectionState.done &&
                    audSnapshot.hasData) {
                  return Card(
                    color: Colors.blueGrey.shade800,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.indigo.shade700,
                              child: const Icon(CupertinoIcons
                                  .rectangle_fill_on_rectangle_angled_fill)),
                          Text("   " + fileName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              )),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () async {
                                      // if (!await launchUrl(_url)) {
                                      //   showSnackbarC(
                                      //       context,
                                      //       "Something went wrong",
                                      //       Colors.red,
                                      //       Colors.white);
                                      // }

                                      String url = audSnapshot.data.toString();
                                      // ignore: deprecated_member_use
                                      var urllaunchable = await canLaunch(
                                          url); //canLaunch is from url_launcher package
                                      if (urllaunchable) {
                                        // ignore: deprecated_member_use
                                        await launch(
                                            url); //launch is from url_launcher package to launch URL
                                      } else {
                                        showSnackbarC(
                                            context,
                                            "Something went wrong",
                                            Colors.red,
                                            Colors.white);
                                      }
                                    },
                                    onLongPress: () async {
                                      ClipboardData data = ClipboardData(
                                          text: audSnapshot.data.toString());
                                      await Clipboard.setData(data);
                                      showSnackbarC(
                                          context,
                                          "Link copied to Clipboard",
                                          Colors.green,
                                          Colors.white);
                                    },
                                    child: CircleAvatar(
                                        backgroundColor:
                                            Colors.blueGrey.shade900,
                                        child: const Icon(Icons.download)),
                                  )))
                        ],
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      color: Colors.blueGrey.shade900,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 48.0,
                                height: 48.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 200,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Container(
                                    width: 200,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Container(
                                    width: 40.0,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                      visible: (msg == "") ? false : true,
                      child: Text(msg,
                          style: const TextStyle(
                            fontSize: 14,
                          ))),
                  Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          time,
                          style: const TextStyle(
                              fontSize: 10, color: Colors.blueGrey),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: (status == "done")
                            ? const Icon(
                                Icons.done_all,
                                color: Colors.deepPurple,
                                size: 15,
                              )
                            : const Icon(
                                Icons.done,
                                color: Colors.blueGrey,
                                size: 15,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
