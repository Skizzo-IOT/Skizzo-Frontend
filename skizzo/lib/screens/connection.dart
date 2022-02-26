import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class Connection extends StatefulWidget {
  static const route = "/Connexion";

  const Connection({Key? key}) : super(key: key);

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  final TextEditingController _controller = TextEditingController();
  late WebSocketChannel _channel;
  final FocusNode _focusNode = FocusNode();

  int directionX = 0;
  int directionY = 0;

  @override
  void initState() {
    super.initState();

    _channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:3000/flutter'),
    );
    _sendDirection();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Connection"),
      ),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            width: 250,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTapDown: (_) {
                            print("Top Down");
                            directionY += 1;
                            _sendDirection();
                          },
                          onTapUp: (_) {
                            print("Top Up");
                            directionY -= 1;
                            _sendDirection();
                          },
                          onTapCancel: () {
                            print("Top Cancel");
                            directionY -= 1;
                            _sendDirection();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.arrow_drop_up),
                            radius: 50,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTapDown: (_) {
                            print("Left Down");
                            directionX -= 1;
                            _sendDirection();
                          },
                          onTapUp: (_) {
                            print("Left Up");
                            directionX += 1;
                            _sendDirection();
                          },
                          onTapCancel: () {
                            print("Left Cancel");
                            directionX += 1;
                            _sendDirection();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.arrow_left),
                            radius: 50,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTapDown: (_) {
                            print("Right Down");
                            directionX += 1;
                            _sendDirection();
                          },
                          onTapUp: (_) {
                            print("Right Up");
                            directionX -= 1;
                            _sendDirection();
                          },
                          onTapCancel: () {
                            print("Right Cancel");
                            directionX -= 1;
                            _sendDirection();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.arrow_right),
                            radius: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTapDown: (_) {
                            print("Bot Down");
                            directionY -= 1;
                            _sendDirection();
                          },
                          onTapUp: (_) {
                            print("Bot Up");
                            directionY += 1;
                            _sendDirection();
                          },
                          onTapCancel: () {
                            print("Bot Cancel");
                            directionY += 1;
                            _sendDirection();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.arrow_drop_down),
                            radius: 50,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Type? lastRuntimeType = null;
  LogicalKeyboardKey? lastLogicalKeyboardKey = null;
  List<LogicalKeyboardKey> keysPressed = [];

  void _handleKeyEvent(RawKeyEvent event) {
    if (event.runtimeType == RawKeyDownEvent) {
      if (!keysPressed.contains(event.logicalKey)) {
        keysPressed.add(event.logicalKey);
      }
    } else if (event.runtimeType == RawKeyUpEvent) {
      if (keysPressed.contains(event.logicalKey)) {
        keysPressed.remove(event.logicalKey);
      }
    }

    int nextDirectionX = 0;
    int nextDirectionY = 0;
    for (var key in keysPressed) {
      if (key == LogicalKeyboardKey.keyZ) {
        print("Z");
        nextDirectionY += 1;
      }
      if (key == LogicalKeyboardKey.keyQ) {
        print("Q");
        nextDirectionX -= 1;
      }
      if (key == LogicalKeyboardKey.keyS) {
        print("S");
        nextDirectionY -= 1;
      }
      if (key == LogicalKeyboardKey.keyD) {
        print("D");
        nextDirectionX += 1;
      }
    }

    if (nextDirectionX != directionX || nextDirectionY != directionY) {
      directionX = nextDirectionX;
      directionY = nextDirectionY;
      _sendDirection();
    }
  }

  void _sendDirection() {
    if (directionX > 1) directionX = 1;
    if (directionX < -1) directionX = -1;
    if (directionY > 1) directionY = 1;
    if (directionY < -1) directionY = -1;

    _channel.sink.add(
      jsonEncode(
        <String, dynamic>{
          'type': 'direction',
          'directionX': directionX,
          'directionY': directionY,
        },
      ),
    );
  }

  @override
  void dispose() {
    directionX = 0;
    directionY = 0;
    _sendDirection();
    _focusNode.dispose();
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
