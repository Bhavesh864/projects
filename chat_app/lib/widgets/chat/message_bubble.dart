import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userName;
  final String userImage;
  final Key userKey;

  // ignore: use_key_in_widget_constructors
  const MessageBubble(
    this.message,
    this.isMe,
    this.userName,
    this.userImage, {
    required this.userKey,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Theme.of(context).secondaryHeaderColor : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(12),
                  topLeft: const Radius.circular(12),
                  bottomLeft: !isMe ? const Radius.circular(0) : const Radius.circular(12),
                  bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(12),
                ),
              ),
              width: 150,
              margin: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 10,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      // ignore: deprecated_member_use
                      color: isMe ? Theme.of(context).accentTextTheme.titleLarge!.color : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      // ignore: deprecated_member_use
                      color: isMe ? Theme.of(context).accentTextTheme.titleLarge!.color : Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -8,
          left: isMe ? null : 130,
          right: isMe ? 130 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
    );
  }
}
