import 'package:flutter/material.dart';

class CustomTextMessageSend extends StatelessWidget {
  final String msg;
  final String time;
  final String status;
  const CustomTextMessageSend(this.msg, this.time, this.status, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
            padding: const EdgeInsets.all(12.0),
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
            )),
      ),
    );
  }
}
