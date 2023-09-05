import 'package:epsihelp_app/models/message.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class SentMessageCard extends StatelessWidget {
  const SentMessageCard({super.key, required this.msg});

  final Message msg;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        left: 40,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kPurple,
      ),
      padding: const EdgeInsets.all(15),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(msg.message),
            Text(
              msg.time.toString(),
              style: const TextStyle(
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReceivedMessageCard extends StatelessWidget {
  const ReceivedMessageCard({super.key, required this.msg});
  final Message msg;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        right: 40,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kLightGrey,
      ),
      padding: const EdgeInsets.all(15),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.black54,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(msg.message),
            Text(
              msg.time.toString(),
              style: const TextStyle(
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
