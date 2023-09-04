import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:elearning_app/models/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final bool tail;
  final bool sent;
  final bool delivered;
  final bool seen;
  final TextStyle textStyle;
  final Message message;

  ChatBubble({Key? key,
    required this.message,
    this.bubbleRadius = BUBBLE_RADIUS,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    bool stateTick = false;
    Icon? stateIcon;
    if (sent) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (delivered) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (seen) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF92DEDA),
      );
    }

    return Row(
      children: <Widget>[
        isSender
            ? Expanded(
          child: SizedBox(
            width: 5,
          ),
        )
            : Container(),
        Container(
          color: Colors.transparent,
          constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .8),
          child: Align(
            alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(bubbleRadius),
                    topRight: Radius.circular(bubbleRadius),
                    bottomLeft: Radius.circular(tail
                        ? isSender
                        ? bubbleRadius
                        : 0
                        : BUBBLE_RADIUS),
                    bottomRight: Radius.circular(tail
                        ? isSender
                        ? 0
                        : bubbleRadius
                        : BUBBLE_RADIUS),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: stateTick
                          ? EdgeInsets.fromLTRB(12, 6, 28, 6)
                          : EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      child: Text(
                        message.message,
                        style: textStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    stateIcon != null && stateTick
                        ? Positioned(
                      bottom: 4,
                      right: 6,
                      child: stateIcon,
                    )
                        : SizedBox(
                      width: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
