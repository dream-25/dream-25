import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomTextMessageRcv extends StatelessWidget {
  final String name;
  final String email;
  final String pic;
  final String msg;
  final String time;
  final String status;
  const CustomTextMessageRcv(
      this.name, this.email, this.pic, this.msg, this.time, this.status,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          4,
          4,
          MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width * 3 / 4,
          4),
      child: Card(
        color: Colors.blueGrey.shade100,
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: Colors.indigo.shade300,
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(pic),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(email),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(msg),
                  Column(
                    children: [
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
                      )
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
